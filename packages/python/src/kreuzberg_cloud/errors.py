"""Public exception hierarchy for the kreuzberg-cloud client."""

from __future__ import annotations

from typing import TYPE_CHECKING, Any

if TYPE_CHECKING:
    import httpx


class KreuzbergCloudError(Exception):
    """Base exception raised for any kreuzberg-cloud client error."""

    def __init__(self, message: str, *, status_code: int | None = None, payload: Any | None = None) -> None:
        super().__init__(message)
        self.status_code = status_code
        self.payload = payload


class AuthError(KreuzbergCloudError):
    """Raised when the API rejects the request with HTTP 401 (missing/invalid credentials)."""


class ValidationError(KreuzbergCloudError):
    """Raised when the API rejects the request with HTTP 400 (malformed input)."""


class NotFoundError(KreuzbergCloudError):
    """Raised when the API returns HTTP 404 (resource does not exist)."""


class RateLimitError(KreuzbergCloudError):
    """Raised when the API returns HTTP 429 (rate limit exceeded).

    The optional ``retry_after`` attribute exposes the server-suggested wait
    time in seconds, parsed from the ``Retry-After`` response header when
    present.
    """

    def __init__(
        self,
        message: str,
        *,
        status_code: int | None = 429,
        payload: Any | None = None,
        retry_after: float | None = None,
    ) -> None:
        super().__init__(message, status_code=status_code, payload=payload)
        self.retry_after = retry_after


class ServerError(KreuzbergCloudError):
    """Raised when the API returns any HTTP 5xx (server-side failure)."""


class TimeoutError(KreuzbergCloudError):  # noqa: A001 — intentional shadowing of builtin to surface a domain-specific timeout
    """Raised when a client-side wait operation exceeds its budget.

    Distinct from ``httpx.TimeoutException`` (single-request network timeout)
    — this is raised by polling helpers like :meth:`wait_for_job` when the
    overall deadline passes before the job reaches a terminal state.
    """


def _parse_retry_after(value: str | None) -> float | None:
    """Parse a ``Retry-After`` header value into seconds, returning ``None`` on failure."""
    if value is None:
        return None
    try:
        return float(value)
    except ValueError:
        return None


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


def raise_for_status(response: httpx.Response) -> None:
    """Convert a non-2xx httpx response into the matching :class:`KreuzbergCloudError` subclass.

    No-op for 2xx responses. Used by every public client method to normalize
    error reporting across the SDK surface.
    """
    status = response.status_code
    if 200 <= status < 300:
        return

    payload = _safe_json(response)
    message = _extract_message(payload, f"HTTP {status}")

    if status == 400:
        raise ValidationError(message, status_code=status, payload=payload)
    if status == 401:
        raise AuthError(message, status_code=status, payload=payload)
    if status == 404:
        raise NotFoundError(message, status_code=status, payload=payload)
    if status == 429:
        retry_after = _parse_retry_after(response.headers.get("Retry-After"))
        raise RateLimitError(message, status_code=status, payload=payload, retry_after=retry_after)
    if 500 <= status < 600:
        raise ServerError(message, status_code=status, payload=payload)
    raise KreuzbergCloudError(message, status_code=status, payload=payload)
