"""``enterprise_healthz`` decodes the Enterprise ``/healthz`` body leniently."""

from __future__ import annotations

import httpx
import pytest
import respx

from xberg_io_sdk import AsyncXbergClient, EnterpriseHealth, XbergClient, XbergError

FULL_BODY = {
    "status": "ok",
    "tier": "enterprise",
    "auto_tune": {"enabled": True},
    "rag": {"enabled": True},
    "data_rooms": {"enabled": False},
}


@respx.mock
def test_enterprise_healthz_decodes_every_feature_flag(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}/healthz").mock(return_value=httpx.Response(200, json=FULL_BODY))

    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        health = client.enterprise_healthz()

    assert health == EnterpriseHealth(
        status="ok", tier="enterprise", rag=True, auto_tune=True, data_rooms=False, raw=FULL_BODY
    )
    assert route.call_count == 1


@respx.mock
def test_enterprise_healthz_tolerates_an_older_server_without_data_rooms(base_url: str, api_key: str) -> None:
    body = {"status": "ok", "tier": "enterprise", "rag": {"enabled": True}, "auto_tune": "yes"}
    respx.get(f"{base_url}/healthz").mock(return_value=httpx.Response(200, json=body))

    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        health = client.enterprise_healthz()

    assert health.status == "ok"
    assert health.tier == "enterprise"
    assert health.rag is True
    assert health.auto_tune is None
    assert health.data_rooms is None
    assert health.raw == body


@respx.mock
def test_enterprise_healthz_is_refused_on_pro_before_any_request(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}/healthz").mock(return_value=httpx.Response(200, json=FULL_BODY))

    with (
        XbergClient(api_key=api_key, base_url=base_url, target="pro") as client,
        pytest.raises(XbergError, match="requires the 'enterprise' tier"),
    ):
        client.enterprise_healthz()

    assert route.call_count == 0


@pytest.mark.asyncio
@respx.mock
async def test_async_enterprise_healthz_probes_the_tier_then_decodes(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}/healthz").mock(return_value=httpx.Response(200, json=FULL_BODY))

    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        health = await client.enterprise_healthz()

    assert (health.tier, health.rag, health.auto_tune, health.data_rooms) == ("enterprise", True, True, False)
    assert route.call_count == 2
