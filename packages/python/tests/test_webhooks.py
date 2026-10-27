"""Webhook signature verification, against vectors the server's signer produces."""

from __future__ import annotations

import pytest

from xberg_io_sdk import (
    DEFAULT_WEBHOOK_TOLERANCE_SECONDS,
    WEBHOOK_SIGNATURE_HEADER,
    WebhookSignatureError,
    verify_webhook_signature,
    verify_webhook_signature_or_raise,
)
from xberg_io_sdk import webhooks as webhooks_module

SECRET = "whsec_test"
BODY = b'{"event":"job.completed","job_id":"j1"}'
T = 1_700_000_000
# HMAC-SHA256("whsec_test", "1700000000." + BODY), computed independently with
# `openssl dgst -sha256 -hmac whsec_test`; secret and body are the server signer's test inputs.  ~keep
V1 = "3a1304cbfa5270ffc0f8e72192b25d803293dc6312d34e40e8b9feea0b574c03"
# The same over the secret "retired", for the key-rotation case.  ~keep
V1_RETIRED = "1ff07f276e8942bbaf1bdf17141006bb2b808f242a067e19a973d17a34ca775f"
HEADER = f"t={T},v1={V1}"


def test_constants_match_the_server() -> None:
    assert WEBHOOK_SIGNATURE_HEADER == "X-Webhook-Signature"
    assert DEFAULT_WEBHOOK_TOLERANCE_SECONDS == 300


def test_accepts_a_fresh_signature() -> None:
    assert verify_webhook_signature(SECRET, HEADER, BODY, now=T + 100) is True
    assert verify_webhook_signature_or_raise(SECRET, HEADER, BODY, now=T + 100) is None


def test_accepts_a_str_body_and_bytes_secret() -> None:
    assert verify_webhook_signature(SECRET.encode(), HEADER, BODY.decode(), now=T) is True


def test_accepts_uppercase_hex_and_whitespace_around_elements() -> None:
    assert verify_webhook_signature(SECRET, f" t={T} , v1={V1.upper()} ", BODY, now=T) is True


def test_accepts_the_edges_of_the_tolerance_window() -> None:
    assert verify_webhook_signature(SECRET, HEADER, BODY, now=T + 300) is True
    assert verify_webhook_signature(SECRET, HEADER, BODY, now=T - 300) is True


@pytest.mark.parametrize("now", [T + 301, T - 301])
def test_rejects_a_stale_or_future_timestamp(now: int) -> None:
    assert verify_webhook_signature(SECRET, HEADER, BODY, now=now) is False
    with pytest.raises(WebhookSignatureError) as exc_info:
        verify_webhook_signature_or_raise(SECRET, HEADER, BODY, now=now)
    assert exc_info.value.reason == "outside_tolerance"
    assert str(exc_info.value) == f"signature timestamp {T} is outside the tolerance window at {now}"


def test_custom_tolerance_moves_the_window() -> None:
    assert verify_webhook_signature(SECRET, HEADER, BODY, tolerance=600, now=T + 600) is True
    assert verify_webhook_signature(SECRET, HEADER, BODY, tolerance=0, now=T + 1) is False


def test_rejects_a_tampered_body() -> None:
    assert verify_webhook_signature(SECRET, HEADER, b"{}", now=T) is False
    with pytest.raises(WebhookSignatureError) as exc_info:
        verify_webhook_signature_or_raise(SECRET, HEADER, b"{}", now=T)
    assert exc_info.value.reason == "mismatch"
    assert str(exc_info.value) == "signature does not match the request body"


def test_rejects_a_wrong_secret() -> None:
    assert verify_webhook_signature("other", HEADER, BODY, now=T) is False


def test_rejects_a_tampered_timestamp() -> None:
    assert verify_webhook_signature(SECRET, f"t={T + 1},v1={V1}", BODY, now=T) is False


def test_accepts_any_matching_v1_during_rotation() -> None:
    rotating = f"t={T},v1={V1_RETIRED},v1={V1}"
    assert verify_webhook_signature(SECRET, rotating, BODY, now=T) is True
    assert verify_webhook_signature("retired", rotating, BODY, now=T) is True
    assert verify_webhook_signature("other", rotating, BODY, now=T) is False


@pytest.mark.parametrize(
    ("header", "reason"),
    [
        ("sha256=abcd", "missing_timestamp"),
        (f"t=abc,v1={V1}", "missing_timestamp"),
        (f"t={T}", "missing_signature"),
        (f"v1={V1}", "missing_timestamp"),
        ("", "missing_timestamp"),
    ],
)
def test_rejects_malformed_headers(header: str, reason: str) -> None:
    assert verify_webhook_signature(SECRET, header, BODY, now=T) is False
    with pytest.raises(WebhookSignatureError) as exc_info:
        verify_webhook_signature_or_raise(SECRET, header, BODY, now=T)
    assert exc_info.value.reason == reason


@pytest.mark.parametrize("v1", ["zz" * 32, V1[:-1], "", V1 + "00"])
def test_rejects_non_hex_or_wrong_length_signatures(v1: str) -> None:
    assert verify_webhook_signature(SECRET, f"t={T},v1={v1}", BODY, now=T) is False


def test_rejects_out_of_range_timestamps() -> None:
    assert verify_webhook_signature(SECRET, f"t={-(2**63)},v1=abcd", BODY, now=0) is False
    with pytest.raises(WebhookSignatureError) as exc_info:
        verify_webhook_signature_or_raise(SECRET, f"t={2**63},v1=abcd", BODY, now=0)
    assert exc_info.value.reason == "missing_timestamp"


def test_defaults_now_to_the_current_clock(monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setattr(webhooks_module.time, "time", lambda: T + 299.9)
    assert verify_webhook_signature(SECRET, HEADER, BODY) is True
    monkeypatch.setattr(webhooks_module.time, "time", lambda: T + 301.0)
    assert verify_webhook_signature(SECRET, HEADER, BODY) is False


def test_negative_tolerance_is_refused() -> None:
    with pytest.raises(ValueError, match="non-negative"):
        verify_webhook_signature(SECRET, HEADER, BODY, tolerance=-1, now=T)
