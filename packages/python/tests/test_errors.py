"""Tests verifying every HTTP error class is raised on the matching status code."""

from __future__ import annotations

from datetime import UTC, datetime, timedelta
from email.utils import format_datetime

import httpx
import pytest
import respx

from xberg_io_sdk import (
    AsyncXbergClient,
    AuthError,
    NotFoundError,
    RateLimitError,
    ServerError,
    ValidationError,
    XbergClient,
    XbergError,
)
from xberg_io_sdk.errors import _extract_message, parse_retry_after


@respx.mock
def test_400_raises_validation_error_sync(base_url: str, api_key: str) -> None:
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(400, json={"error": "bad_request", "message": "missing file"}),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client, pytest.raises(ValidationError) as exc_info:
        client.extract(file=b"x")
    assert exc_info.value.status_code == 400
    assert "missing file" in str(exc_info.value)


@respx.mock
def test_401_raises_auth_error_sync(base_url: str, api_key: str) -> None:
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(401, json={"error": "unauthorized", "message": "invalid api key"}),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client, pytest.raises(AuthError) as exc_info:
        client.extract(file=b"x")
    assert exc_info.value.status_code == 401


@respx.mock
def test_403_raises_auth_error_sync(base_url: str, api_key: str) -> None:
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(403, json={"error": "forbidden", "message": "project access denied"}),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client, pytest.raises(AuthError) as exc_info:
        client.extract(file=b"x")
    assert exc_info.value.status_code == 403


@respx.mock
def test_404_raises_not_found_error_sync(base_url: str, api_key: str) -> None:
    job_id = "11111111-1111-1111-1111-111111111111"
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(404, json={"error": "not_found", "message": "no such job"}),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client, pytest.raises(NotFoundError):
        client.get_job(job_id)


@respx.mock
def test_429_raises_rate_limit_error_with_retry_after(base_url: str, api_key: str) -> None:
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(
            429,
            json={"error": "rate_limited", "message": "slow down"},
            headers={"Retry-After": "12"},
        ),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client, pytest.raises(RateLimitError) as exc_info:
        client.extract(file=b"x")
    assert exc_info.value.retry_after == 12.0


@respx.mock
def test_429_without_retry_after_header_has_none(base_url: str, api_key: str) -> None:
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(429, json={"message": "rate limited"}),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client, pytest.raises(RateLimitError) as exc_info:
        client.extract(file=b"x")
    assert exc_info.value.retry_after is None


@respx.mock
def test_500_raises_server_error_sync(base_url: str, api_key: str) -> None:
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(500, json={"error": "internal_error", "message": "boom"}),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client, pytest.raises(ServerError) as exc_info:
        client.extract(file=b"x")
    assert exc_info.value.status_code == 500


@respx.mock
def test_503_raises_server_error_sync(base_url: str, api_key: str) -> None:
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(503, json={"message": "unavailable"}),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client, pytest.raises(ServerError):
        client.extract(file=b"x")


@respx.mock
def test_unknown_4xx_raises_base_error(base_url: str, api_key: str) -> None:
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(418, json={"message": "teapot"}),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client, pytest.raises(XbergError) as exc_info:
        client.extract(file=b"x")
    assert exc_info.value.status_code == 418
    assert type(exc_info.value) is XbergError


@respx.mock
def test_non_json_error_body_falls_back_to_default_message(base_url: str, api_key: str) -> None:
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(500, content=b"<html>oops</html>"),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client, pytest.raises(ServerError) as exc_info:
        client.extract(file=b"x")
    assert "HTTP 500" in str(exc_info.value)
    assert exc_info.value.payload is None


@pytest.mark.asyncio
@respx.mock
async def test_401_raises_auth_error_async(base_url: str, api_key: str) -> None:
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(401, json={"message": "no creds"}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        with pytest.raises(AuthError):
            await client.extract(file=b"x")


@pytest.mark.asyncio
@respx.mock
async def test_429_raises_rate_limit_error_async(base_url: str, api_key: str) -> None:
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(
            429,
            json={"message": "rate limit hit"},
            headers={"Retry-After": "5"},
        ),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        with pytest.raises(RateLimitError) as exc_info:
            await client.extract(file=b"x")
    assert exc_info.value.retry_after == 5.0


@pytest.mark.asyncio
@respx.mock
async def test_500_raises_server_error_async(base_url: str, api_key: str) -> None:
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(502, json={"message": "bad gateway"}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        with pytest.raises(ServerError):
            await client.extract(file=b"x")


@respx.mock
def test_400_on_get_job_raises_validation_error(base_url: str, api_key: str) -> None:
    job_id = "22222222-2222-2222-2222-222222222222"
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(400, json={"message": "bad job id format"}),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client, pytest.raises(ValidationError):
        client.get_job(job_id)


# -- parse_retry_after ------------------------------------------------------------


def test_parse_retry_after_none_returns_none() -> None:
    assert parse_retry_after(None) is None


def test_parse_retry_after_delay_seconds() -> None:
    assert parse_retry_after("42") == 42.0


def test_parse_retry_after_http_date_in_future_returns_positive_seconds() -> None:
    future = datetime.now(tz=UTC) + timedelta(seconds=30)
    header_value = format_datetime(future, usegmt=True)
    result = parse_retry_after(header_value)
    assert result is not None
    assert 25.0 <= result <= 30.5


def test_parse_retry_after_http_date_without_tzinfo_is_treated_as_utc() -> None:
    future = datetime.now(tz=UTC) + timedelta(seconds=10)
    naive_rfc1123 = future.strftime("%a, %d %b %Y %H:%M:%S")
    result = parse_retry_after(naive_rfc1123)
    assert result is not None
    assert 5.0 <= result <= 10.5


def test_parse_retry_after_http_date_in_past_clamps_to_zero() -> None:
    past = datetime.now(tz=UTC) - timedelta(seconds=60)
    header_value = format_datetime(past, usegmt=True)
    assert parse_retry_after(header_value) == 0.0


def test_parse_retry_after_unparseable_value_returns_none() -> None:
    assert parse_retry_after("not-a-date-or-number") is None


@respx.mock
def test_429_with_http_date_retry_after_header(base_url: str, api_key: str) -> None:
    future = datetime.now(tz=UTC) + timedelta(seconds=20)
    header_value = format_datetime(future, usegmt=True)
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(
            429,
            json={"message": "slow down"},
            headers={"Retry-After": header_value},
        ),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client, pytest.raises(RateLimitError) as exc_info:
        client.extract(file=b"x")
    assert exc_info.value.retry_after is not None
    assert 15.0 <= exc_info.value.retry_after <= 20.5


# -- _extract_message --------------------------------------------------------------


def test_extract_message_falls_back_to_default_when_no_known_key_present() -> None:
    assert _extract_message({"unrelated": "field"}, "HTTP 500") == "HTTP 500"


def test_extract_message_skips_non_string_value_and_uses_next_key() -> None:
    assert _extract_message({"message": 123, "error": "actual error"}, "default") == "actual error"


def test_extract_message_skips_empty_string_value_and_uses_next_key() -> None:
    assert _extract_message({"message": "", "error": "", "detail": "the real detail"}, "default") == "the real detail"
