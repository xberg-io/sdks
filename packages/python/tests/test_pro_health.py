"""Native typed Pro health preserves the Enterprise backend method contract."""

from __future__ import annotations

from contextlib import contextmanager
from typing import TYPE_CHECKING

import httpx
import pytest
import respx

from xberg_io_sdk import AsyncXbergClient, AuthError, NotFoundError, ServerError, XbergClient, XbergError

if TYPE_CHECKING:
    from collections.abc import Iterator

BASE_URL = "https://data.example.test"
BACKEND_URL = "https://backend.example.test"
HEALTH = {
    "status": "ok",
    "tier": "pro",
    "license": {"state": "grace"},
    "rag": {"enabled": False},
    "auto_tune": {"enabled": True},
    "future_field": "retained",
}


@contextmanager
def client_pair(target: str | None = "pro", retries: int = 0) -> Iterator[tuple[XbergClient, AsyncXbergClient]]:
    options = {
        "base_url": BASE_URL,
        "control_plane_base_url": BACKEND_URL,
        "api_key": "data-key",
        "control_plane_token": "backend-key",
        "target": target,
        "retries": retries,
    }
    with XbergClient(**options) as sync:
        yield sync, AsyncXbergClient(**options)


def assert_health(value: object) -> None:
    from xberg_io_sdk import ProHealthResponse

    assert isinstance(value, ProHealthResponse)
    assert value.status == "ok"
    assert value.tier == "pro"
    assert value.license_.state == "grace"
    assert value.rag.enabled is False
    assert value.auto_tune.enabled is True
    assert value.additional_properties == {"future_field": "retained"}
    assert value.to_dict() == HEALTH


@respx.mock
@pytest.mark.asyncio
async def test_returns_typed_pro_health_on_data_origin_for_both_clients() -> None:
    route = respx.get(f"{BASE_URL}/healthz").mock(return_value=httpx.Response(200, json=HEALTH))
    with client_pair() as (sync, async_client):
        assert_health(sync.pro_healthz())
        async with async_client:
            assert_health(await async_client.pro_healthz())
    assert route.call_count == 2
    assert [call.request.headers["authorization"] for call in route.calls] == ["Bearer data-key"] * 2


@respx.mock
@pytest.mark.asyncio
async def test_supports_unauthenticated_health_without_backend_credential() -> None:
    route = respx.get(f"{BASE_URL}/healthz").mock(return_value=httpx.Response(200, json=HEALTH))
    with XbergClient(base_url=BASE_URL, target="pro", control_plane_token="backend-key") as sync:
        assert_health(sync.pro_healthz())
    async with AsyncXbergClient(base_url=BASE_URL, target="pro", control_plane_token="backend-key") as client:
        assert_health(await client.pro_healthz())
    assert route.call_count == 2
    assert [call.request.headers.get("authorization") for call in route.calls] == [None, None]


@respx.mock
@pytest.mark.asyncio
async def test_rejects_explicit_enterprise_without_http() -> None:
    with client_pair(target="enterprise") as (sync, async_client):
        with pytest.raises(XbergError, match="requires the 'pro' tier"):
            sync.pro_healthz()
        async with async_client:
            with pytest.raises(XbergError, match="requires the 'pro' tier"):
                await async_client.pro_healthz()
    assert len(respx.calls) == 0


@respx.mock
@pytest.mark.asyncio
@pytest.mark.parametrize("tier,expected", [("pro", 3), ("enterprise", 1)])
async def test_automatic_target_uses_one_probe_then_fresh_reads(tier: str, expected: int) -> None:
    payload = HEALTH if tier == "pro" else {"status": "ok", "tier": tier}
    route = respx.get(f"{BASE_URL}/healthz").mock(return_value=httpx.Response(200, json=payload))
    with client_pair(target=None) as (sync, async_client):
        if tier == "pro":
            assert_health(sync.pro_healthz())
            assert_health(sync.pro_healthz())
        else:
            with pytest.raises(XbergError, match="requires the 'pro' tier"):
                sync.pro_healthz()
        assert route.call_count == expected
        async with async_client:
            if tier == "pro":
                assert_health(await async_client.pro_healthz())
                assert_health(await async_client.pro_healthz())
            else:
                with pytest.raises(XbergError, match="requires the 'pro' tier"):
                    await async_client.pro_healthz()
    assert route.call_count == expected * 2


@respx.mock
@pytest.mark.asyncio
@pytest.mark.parametrize("status,error_type", [(401, AuthError), (404, NotFoundError), (503, ServerError)])
async def test_maps_errors_without_retry_when_disabled(status: int, error_type: type[XbergError]) -> None:
    route = respx.get(f"{BASE_URL}/healthz").mock(return_value=httpx.Response(status, json={"message": "unavailable"}))
    with client_pair() as (sync, async_client):
        with pytest.raises(error_type) as sync_error:
            sync.pro_healthz()
        assert sync_error.value.status_code == status
        assert route.call_count == 1
        async with async_client:
            with pytest.raises(error_type) as async_error:
                await async_client.pro_healthz()
            assert async_error.value.status_code == status
    assert route.call_count == 2


@respx.mock
@pytest.mark.asyncio
async def test_retries_transient_errors_through_existing_transport() -> None:
    route = respx.get(f"{BASE_URL}/healthz").mock(
        side_effect=[
            httpx.Response(503, json={"message": "unavailable"}),
            httpx.Response(200, json=HEALTH),
            httpx.Response(503, json={"message": "unavailable"}),
            httpx.Response(200, json=HEALTH),
        ]
    )
    with client_pair(retries=1) as (sync, async_client):
        assert_health(sync.pro_healthz())
        assert route.call_count == 2
        async with async_client:
            assert_health(await async_client.pro_healthz())
    assert route.call_count == 4


@respx.mock
@pytest.mark.asyncio
async def test_preserves_enterprise_health_origin_public_auth_and_pro_rejection() -> None:
    route = respx.get(f"{BACKEND_URL}/healthz").mock(
        return_value=httpx.Response(200, json={"status": "ok", "tier": "enterprise"})
    )
    with client_pair(target="enterprise") as (sync, async_client):
        assert sync.healthz().tier == "enterprise"
        async with async_client:
            assert (await async_client.healthz()).tier == "enterprise"
    with client_pair() as (sync, async_client):
        with pytest.raises(XbergError, match="requires the 'enterprise' tier"):
            sync.healthz()
        async with async_client:
            with pytest.raises(XbergError, match="requires the 'enterprise' tier"):
                await async_client.healthz()
    assert route.call_count == 2
    assert [call.request.headers.get("authorization") for call in route.calls] == [None, None]
