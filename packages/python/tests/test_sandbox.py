"""Tests for the sandbox-key onboarding flow (``create_sandbox_key`` / ``from_sandbox``)."""

from __future__ import annotations

import datetime as dt

import httpx
import pytest
import respx

from kreuzberg_cloud import AsyncKreuzbergCloud, KreuzbergCloud, RateLimitError, SandboxKey

SANDBOX_KEY_PAYLOAD = {
    "api_key": "sk_sandbox_01ABCDEFGHIJKLMNOPQRSTUVWX",
    "expires_at": "2026-05-10T10:00:00Z",
    "pages_remaining": 50,
}


@respx.mock
def test_create_sandbox_key_sync_returns_typed_value(base_url: str) -> None:
    respx.post(f"{base_url}/v1/sandbox/key").mock(return_value=httpx.Response(200, json=SANDBOX_KEY_PAYLOAD))

    with KreuzbergCloud(base_url=base_url) as client:
        key = client.create_sandbox_key()

    assert isinstance(key, SandboxKey)
    assert key.api_key == SANDBOX_KEY_PAYLOAD["api_key"]
    assert key.pages_remaining == 50
    assert key.expires_at == dt.datetime(2026, 5, 10, 10, 0, 0, tzinfo=dt.timezone.utc)


@pytest.mark.asyncio
@respx.mock
async def test_create_sandbox_key_async_returns_typed_value(base_url: str) -> None:
    respx.post(f"{base_url}/v1/sandbox/key").mock(return_value=httpx.Response(200, json=SANDBOX_KEY_PAYLOAD))

    async with AsyncKreuzbergCloud(base_url=base_url) as client:
        key = await client.create_sandbox_key()

    assert key.api_key == SANDBOX_KEY_PAYLOAD["api_key"]


@respx.mock
def test_from_sandbox_sync_returns_authenticated_client(base_url: str) -> None:
    respx.post(f"{base_url}/v1/sandbox/key").mock(return_value=httpx.Response(200, json=SANDBOX_KEY_PAYLOAD))

    client = KreuzbergCloud.from_sandbox(base_url=base_url)
    try:
        assert client._headers["Authorization"] == f"Bearer {SANDBOX_KEY_PAYLOAD['api_key']}"
    finally:
        client.close()


@pytest.mark.asyncio
@respx.mock
async def test_from_sandbox_async_returns_authenticated_client(base_url: str) -> None:
    respx.post(f"{base_url}/v1/sandbox/key").mock(return_value=httpx.Response(200, json=SANDBOX_KEY_PAYLOAD))

    client = await AsyncKreuzbergCloud.from_sandbox(base_url=base_url)
    try:
        assert client._headers["Authorization"] == f"Bearer {SANDBOX_KEY_PAYLOAD['api_key']}"
    finally:
        await client.aclose()


@respx.mock
def test_create_sandbox_key_sync_raises_rate_limit_with_retry_after(base_url: str) -> None:
    respx.post(f"{base_url}/v1/sandbox/key").mock(
        return_value=httpx.Response(
            429,
            json={"error": "rate_limited", "message": "too many sandbox keys from this IP"},
            headers={"Retry-After": "60"},
        ),
    )

    with KreuzbergCloud(base_url=base_url) as client, pytest.raises(RateLimitError) as exc_info:
        client.create_sandbox_key()
    assert exc_info.value.retry_after == 60.0


@pytest.mark.asyncio
@respx.mock
async def test_from_sandbox_async_raises_rate_limit(base_url: str) -> None:
    respx.post(f"{base_url}/v1/sandbox/key").mock(
        return_value=httpx.Response(429, json={"message": "throttled"}),
    )

    with pytest.raises(RateLimitError):
        await AsyncKreuzbergCloud.from_sandbox(base_url=base_url)
