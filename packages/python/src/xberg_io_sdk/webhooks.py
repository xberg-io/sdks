"""Verify the ``X-Webhook-Signature`` header on a delivered webhook.

The header is ``t=<unix seconds>,v1=<hex>``, where the hex is HMAC-SHA256 under
the webhook secret over ``"<t>.<body>"``. This mirrors the server's own
verifier: the last ``t`` element wins, every ``v1`` element is tried so a
delivery signed with two secrets during a rotation still verifies, the
timestamp window is checked before the digest, and the digest comparison is
constant-time.
"""

from __future__ import annotations

import hashlib
import hmac
import re
import time

from xberg_io_sdk.errors import XbergError

WEBHOOK_SIGNATURE_HEADER = "X-Webhook-Signature"
"""The request header that carries the signature."""

DEFAULT_WEBHOOK_TOLERANCE_SECONDS = 300
"""How far ``t`` may sit from the receiver's clock before a delivery is rejected as a replay."""

_INT64_MIN = -(2**63)
_INT64_MAX = 2**63 - 1
_TIMESTAMP = re.compile(r"[+-]?[0-9]+")
_HEX = re.compile(r"(?:[0-9a-fA-F]{2})*")


class WebhookSignatureError(XbergError):
    """Raised by :func:`verify_webhook_signature_or_raise` when a signature header is rejected.

    ``reason`` is one of ``"missing_timestamp"``, ``"missing_signature"``,
    ``"outside_tolerance"`` or ``"mismatch"``.
    """

    def __init__(self, message: str, *, reason: str) -> None:
        super().__init__(message, status_code=None)
        self.reason = reason


def _parse_timestamp(value: str) -> int | None:
    """Parse ``t`` exactly as Rust's ``str::parse::<i64>`` does, else ``None``."""
    if not _TIMESTAMP.fullmatch(value):
        return None
    parsed = int(value)
    return parsed if _INT64_MIN <= parsed <= _INT64_MAX else None


def verify_webhook_signature_or_raise(
    secret: str | bytes,
    header: str,
    body: bytes | str,
    tolerance: int = DEFAULT_WEBHOOK_TOLERANCE_SECONDS,
    now: int | None = None,
) -> None:
    """Verify a webhook signature header against the raw request body, raising on rejection.

    ``body`` must be the exact bytes received (a ``str`` is UTF-8 encoded);
    re-serialized JSON will not verify. ``now`` is the receiver's clock in unix
    seconds and defaults to the current time. Raises
    :class:`WebhookSignatureError` with the rejection ``reason``.
    """
    if tolerance < 0:
        raise ValueError("tolerance must be a non-negative number of seconds")
    timestamp: int | None = None
    candidates: list[str] = []
    for element in header.split(","):
        key, sep, value = element.strip().partition("=")
        if not sep:
            continue
        if key == "t":
            timestamp = _parse_timestamp(value)
        elif key == "v1":
            candidates.append(value)

    if timestamp is None:
        raise WebhookSignatureError("signature header has no t=<unix seconds> element", reason="missing_timestamp")
    if not candidates:
        raise WebhookSignatureError("signature header has no v1=<hex> element", reason="missing_signature")
    current = int(time.time()) if now is None else now
    if abs(current - timestamp) > tolerance:
        raise WebhookSignatureError(
            f"signature timestamp {timestamp} is outside the tolerance window at {current}",
            reason="outside_tolerance",
        )

    key_bytes = secret.encode() if isinstance(secret, str) else secret
    body_bytes = body.encode() if isinstance(body, str) else body
    expected = hmac.new(key_bytes, f"{timestamp}.".encode() + body_bytes, hashlib.sha256).digest()
    matched = False
    for candidate in candidates:
        if _HEX.fullmatch(candidate) and hmac.compare_digest(expected, bytes.fromhex(candidate)):
            matched = True
    if not matched:
        raise WebhookSignatureError("signature does not match the request body", reason="mismatch")


def verify_webhook_signature(
    secret: str | bytes,
    header: str,
    body: bytes | str,
    tolerance: int = DEFAULT_WEBHOOK_TOLERANCE_SECONDS,
    now: int | None = None,
) -> bool:
    """Return whether ``header`` is a valid, fresh signature of ``body`` under ``secret``.

    ``header`` is the ``X-Webhook-Signature`` value, ``t=<unix>,v1=<hex>``.
    A timestamp more than ``tolerance`` seconds from ``now`` (default: the
    current time) is rejected as a replay. Use
    :func:`verify_webhook_signature_or_raise` to learn why a header was rejected.

    >>> verify_webhook_signature(secret, request.headers["X-Webhook-Signature"], request.body)  # doctest: +SKIP
    True
    """
    try:
        verify_webhook_signature_or_raise(secret, header, body, tolerance=tolerance, now=now)
    except WebhookSignatureError:
        return False
    return True
