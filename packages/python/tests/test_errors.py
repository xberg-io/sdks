"""Tests verifying every HTTP error class is raised on the matching status code."""

from __future__ import annotations

import httpx
import pytest
import respx

from xberg_enterprise import (
    AsyncKreuzbergCloud,
    AuthError,
    KreuzbergCloud,
    KreuzbergCloudError,
    NotFoundError,
    RateLimitError,
    ServerError,
    ValidationError,
)


@respx.mock
def test_400_raises_validation_error_sync(base_url: str, api_key: str) -> None:
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(400, json={"error": "bad_request", "message": "missing file"}),
    )
    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client, pytest.raises(ValidationError) as exc_info:
        client.extract(file=b"x")
    assert exc_info.value.status_code == 400
    assert "missing file" in str(exc_info.value)


@respx.mock
def test_401_raises_auth_error_sync(base_url: str, api_key: str) -> None:
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(401, json={"error": "unauthorized", "message": "invalid api key"}),
    )
    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client, pytest.raises(AuthError) as exc_info:
        client.extract(file=b"x")
    assert exc_info.value.status_code == 401


@respx.mock
def test_404_raises_not_found_error_sync(base_url: str, api_key: str) -> None:
    job_id = "11111111-1111-1111-1111-111111111111"
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(404, json={"error": "not_found", "message": "no such job"}),
    )
    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client, pytest.raises(NotFoundError):
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
    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client, pytest.raises(RateLimitError) as exc_info:
        client.extract(file=b"x")
    assert exc_info.value.retry_after == 12.0


@respx.mock
def test_429_without_retry_after_header_has_none(base_url: str, api_key: str) -> None:
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(429, json={"message": "rate limited"}),
    )
    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client, pytest.raises(RateLimitError) as exc_info:
        client.extract(file=b"x")
    assert exc_info.value.retry_after is None


@respx.mock
def test_500_raises_server_error_sync(base_url: str, api_key: str) -> None:
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(500, json={"error": "internal_error", "message": "boom"}),
    )
    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client, pytest.raises(ServerError) as exc_info:
        client.extract(file=b"x")
    assert exc_info.value.status_code == 500


@respx.mock
def test_503_raises_server_error_sync(base_url: str, api_key: str) -> None:
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(503, json={"message": "unavailable"}),
    )
    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client, pytest.raises(ServerError):
        client.extract(file=b"x")


@respx.mock
def test_unknown_4xx_raises_base_error(base_url: str, api_key: str) -> None:
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(418, json={"message": "teapot"}),
    )
    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client, pytest.raises(KreuzbergCloudError) as exc_info:
        client.extract(file=b"x")
    # 418 falls through to the base class — not a 5xx, not a known 4xx.
    assert exc_info.value.status_code == 418
    assert type(exc_info.value) is KreuzbergCloudError


@respx.mock
def test_non_json_error_body_falls_back_to_default_message(base_url: str, api_key: str) -> None:
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(500, content=b"<html>oops</html>"),
    )
    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client, pytest.raises(ServerError) as exc_info:
        client.extract(file=b"x")
    assert "HTTP 500" in str(exc_info.value)
    assert exc_info.value.payload is None


@pytest.mark.asyncio
@respx.mock
async def test_401_raises_auth_error_async(base_url: str, api_key: str) -> None:
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(401, json={"message": "no creds"}),
    )
    async with AsyncKreuzbergCloud(api_key=api_key, base_url=base_url) as client:
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
    async with AsyncKreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        with pytest.raises(RateLimitError) as exc_info:
            await client.extract(file=b"x")
    assert exc_info.value.retry_after == 5.0


@pytest.mark.asyncio
@respx.mock
async def test_500_raises_server_error_async(base_url: str, api_key: str) -> None:
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(502, json={"message": "bad gateway"}),
    )
    async with AsyncKreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        with pytest.raises(ServerError):
            await client.extract(file=b"x")


@respx.mock
def test_400_on_get_job_raises_validation_error(base_url: str, api_key: str) -> None:
    job_id = "22222222-2222-2222-2222-222222222222"
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(400, json={"message": "bad job id format"}),
    )
    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client, pytest.raises(ValidationError):
        client.get_job(job_id)
