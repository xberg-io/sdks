"""Public exception hierarchy for the Xberg SDK (Enterprise + Pro)."""

from __future__ import annotations

from datetime import datetime, timezone
from email.utils import parsedate_to_datetime
from typing import TYPE_CHECKING, Any

if TYPE_CHECKING:
    import httpx


class XbergError(Exception):
    """Base exception raised for any Xberg SDK client error.

    For an HTTP error, ``message`` is the server's own message, ``code`` its
    stable machine-readable error code and ``details`` its structured context,
    decoded from either the nested ``{"error": {"code", "message", "details"}}``
    envelope or the older flat shape; a body with no message falls back to the
    status line. ``status`` (alias ``status_code``) is the HTTP status, ``None``
    for an error raised before any response arrived. ``code`` and ``details``
    are ``None`` when the server did not send them.
    """

    def __init__(
        self,
        message: str,
        *,
        status_code: int | None = None,
        payload: Any | None = None,
        code: str | None = None,
        details: dict[str, Any] | None = None,
    ) -> None:
        super().__init__(message)
        self.message = message
        self.status_code = status_code
        self.payload = payload
        self.code = code
        self.details = details

    @property
    def status(self) -> int | None:
        """The HTTP status code, or ``None`` when no response was received."""
        return self.status_code


class AuthError(XbergError):
    """Raised when the API rejects the request with HTTP 401 or 403 (missing/invalid/forbidden credentials)."""


class ValidationError(XbergError):
    """Raised when the API rejects the request with HTTP 400 (malformed input)."""


class NotFoundError(XbergError):
    """Raised when the API returns HTTP 404 (resource does not exist)."""


class DataRoomsDisabledError(NotFoundError):
    """Raised on HTTP 404 with code ``data_room.disabled``: this deployment's plan does not offer data rooms.

    Every data-room route, the public ones included, answers this before checking
    the credential. A subclass of :class:`NotFoundError`, so an existing
    ``except NotFoundError`` still catches it. ``enterprise_healthz().data_rooms``
    reports the same flag ahead of time.
    """


_DATA_ROOM_DISABLED_CODE = "data_room.disabled"


class RateLimitError(XbergError):
    """Raised when the API returns HTTP 429 (rate limit exceeded).

    The optional ``retry_after`` attribute exposes the server-suggested wait
    time in seconds, parsed from the ``Retry-After`` response header when
    present (delay-seconds or an HTTP-date).
    """

    def __init__(
        self,
        message: str,
        *,
        status_code: int | None = 429,
        payload: Any | None = None,
        retry_after: float | None = None,
        code: str | None = None,
        details: dict[str, Any] | None = None,
    ) -> None:
        super().__init__(message, status_code=status_code, payload=payload, code=code, details=details)
        self.retry_after = retry_after


class ServerError(XbergError):
    """Raised when the API returns any HTTP 5xx (server-side failure)."""


class _TimeoutLimitMixin:
    """Decodes the ``limit`` / ``timeout_seconds`` details the server's request-timeout layer sends."""

    details: dict[str, Any] | None

    @property
    def limit(self) -> str | None:
        """Which server limit fired: ``"handler"`` (504) or ``"body_idle"`` (408), else ``None``."""
        value = (self.details or {}).get("limit")
        return value if isinstance(value, str) else None

    @property
    def timeout_seconds(self) -> int | None:
        """The configured limit in seconds, as the server reported it, else ``None``."""
        value = (self.details or {}).get("timeout_seconds")
        return value if isinstance(value, int) and not isinstance(value, bool) else None


class RequestTimeoutError(_TimeoutLimitMixin, XbergError):
    """Raised on HTTP 408: the request body stopped arriving before the upload completed.

    ``limit`` is ``"body_idle"`` and ``timeout_seconds`` the idle window the
    server allows between body reads. Not retried by default.
    """


class GatewayTimeoutError(_TimeoutLimitMixin, ServerError):
    """Raised on HTTP 504: the server did not produce a response in time.

    A subclass of :class:`ServerError`, so an existing ``except ServerError``
    still catches it. ``limit`` is ``"handler"`` and ``timeout_seconds`` the
    handler budget. The server may already have accepted the work, which is why
    a ``POST`` is not retried on 504 unless the client opts in.
    """


class ResultExpiredError(XbergError):
    """Raised on HTTP 410: the requested job result has expired and is no longer stored."""


class PreconditionFailedError(XbergError):
    """Raised on HTTP 412: an ``If-Match`` precondition did not match the resource's current version."""


class PreconditionRequiredError(XbergError):
    """Raised on HTTP 428: the operation requires an ``If-Match`` precondition the request did not send."""


class TimeoutError(XbergError):  # noqa: A001 — intentional shadowing of builtin to surface a domain-specific timeout
    """Raised when a client-side wait operation exceeds its budget.

    Distinct from ``httpx.TimeoutException`` (single-request network timeout)
    — this is raised by polling helpers like :meth:`wait_for_job` when the
    overall deadline passes before the job reaches a terminal state.
    """


def parse_retry_after(value: str | None) -> float | None:
    """Parse a ``Retry-After`` header into seconds, accepting delay-seconds and HTTP-date forms.

    Returns ``None`` when the header is absent or unparseable. HTTP-date values
    are converted to a non-negative number of seconds from now.
    """
    if value is None:
        return None
    stripped = value.strip()
    try:
        return float(stripped)
    except ValueError:
        pass
    try:
        target = parsedate_to_datetime(stripped)
    except (TypeError, ValueError):
        return None
    if target is None:
        return None
    if target.tzinfo is None:
        target = target.replace(tzinfo=timezone.utc)
    delta = (target - datetime.now(tz=timezone.utc)).total_seconds()
    return max(0.0, delta)


def _safe_json(response: httpx.Response) -> Any | None:
    """Return ``response.json()`` or ``None`` if the body is not valid JSON."""
    try:
        return response.json()
    except ValueError:
        return None


def _extract_message(payload: Any | None, default: str) -> str:
    """Pull a useful error message out of the API's structured error payload."""
    if isinstance(payload, dict):
        for key in ("message", "error", "detail"):
            value = payload.get(key)
            if isinstance(value, str) and value:
                return value
    return default


def _parse_error_envelope(payload: Any | None) -> tuple[str | None, str | None, dict[str, Any] | None]:
    """Return ``(message, code, details)`` from a nested or flat error body.

    Nested (current): ``{"error": {"code": str, "message": str, "details": {...}}}``.
    Flat (older servers): ``{"error": "<code>", "message": str}``, or a lone
    ``message`` / ``error`` / ``detail`` string. Any part the body lacks is ``None``.
    """
    if not isinstance(payload, dict):
        return None, None, None
    nested = payload.get("error")
    if isinstance(nested, dict):
        message = nested.get("message")
        code = nested.get("code")
        details = nested.get("details")
        return (
            message if isinstance(message, str) and message else None,
            code if isinstance(code, str) and code else None,
            details if isinstance(details, dict) else None,
        )
    message = _extract_message(payload, "") or None
    code = payload.get("code")
    if not (isinstance(code, str) and code):
        flat_error = payload.get("error")
        # ~keep In the flat shape `error` is the code when a separate `message`
        # ~keep carries the text; alone, it is the only text there is.
        code = flat_error if isinstance(flat_error, str) and flat_error and flat_error != message else None
    details = payload.get("details")
    return message, code, details if isinstance(details, dict) else None


_STATUS_ERRORS: dict[int, type[XbergError]] = {
    400: ValidationError,
    401: AuthError,
    403: AuthError,
    404: NotFoundError,
    408: RequestTimeoutError,
    410: ResultExpiredError,
    412: PreconditionFailedError,
    428: PreconditionRequiredError,
    504: GatewayTimeoutError,
}


def raise_for_status(response: httpx.Response) -> None:
    """Convert a non-2xx httpx response into the matching :class:`XbergError` subclass.

    No-op for 2xx responses. Used by every public client method to normalize
    error reporting across the SDK surface. Both 401 and 403 map to
    :class:`AuthError` — the API uses 403 for a valid-but-forbidden principal.
    The message is the server's own; only a body with no message at all falls
    back to the status line.
    """
    status = response.status_code
    if 200 <= status < 300:
        return

    payload = _safe_json(response)
    message, code, details = _parse_error_envelope(payload)
    if message is None:
        message = f"HTTP {status} {response.reason_phrase}".rstrip()
    fields: dict[str, Any] = {"status_code": status, "payload": payload, "code": code, "details": details}

    if status == 429:
        retry_after = parse_retry_after(response.headers.get("Retry-After"))
        raise RateLimitError(message, retry_after=retry_after, **fields)
    if status == 404 and code == _DATA_ROOM_DISABLED_CODE:
        raise DataRoomsDisabledError(message, **fields)
    error_type = _STATUS_ERRORS.get(status)
    if error_type is None:
        error_type = ServerError if 500 <= status < 600 else XbergError
    raise error_type(message, **fields)
