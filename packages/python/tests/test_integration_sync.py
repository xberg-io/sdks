"""Durable integration synchronization request and response contracts."""

import json

import pytest
import respx

from xberg_io_sdk import AsyncXbergClient, NotFoundError, XbergClient, XbergError

URL = "https://pro.example.test"
PATH = f"{URL}/v1/projects/project-1/integrations/integration-1/sync"
STATE = {"enabled": False, "interval_seconds": 900}


@respx.mock
def test_sync_reads_persisted_state() -> None:
    route = respx.get(PATH).respond(200, json=STATE)
    with XbergClient(api_key="test", base_url=URL, target="pro") as client:
        assert client.get_integration_sync("project-1", "integration-1").to_dict() == STATE
    assert route.call_count == 1


@pytest.mark.parametrize("enabled", [True, False])
@respx.mock
def test_sync_writes_preference_and_accepts_empty_response(enabled: bool) -> None:
    route = respx.put(PATH).respond(204)
    with XbergClient(api_key="test", base_url=URL, target="pro") as client:
        assert client.set_integration_sync("project-1", "integration-1", {"enabled": enabled}) is None
    request = route.calls.last.request
    assert json.loads(request.content) == {"enabled": enabled}
    assert request.headers["content-type"] == "application/json"


@pytest.mark.asyncio
@respx.mock
async def test_async_reads_persisted_state() -> None:
    route = respx.get(PATH).respond(200, json=STATE)
    async with AsyncXbergClient(api_key="test", base_url=URL, target="pro") as client:
        assert (await client.get_integration_sync("project-1", "integration-1")).to_dict() == STATE
    assert route.call_count == 1


@pytest.mark.asyncio
@pytest.mark.parametrize("enabled", [True, False])
@respx.mock
async def test_async_writes_preference_and_accepts_empty_response(enabled: bool) -> None:
    route = respx.put(PATH).respond(204)
    async with AsyncXbergClient(api_key="test", base_url=URL, target="pro") as client:
        assert await client.set_integration_sync("project-1", "integration-1", {"enabled": enabled}) is None
    assert json.loads(route.calls.last.request.content) == {"enabled": enabled}
    assert route.calls.last.request.headers["content-type"] == "application/json"


@pytest.mark.parametrize("method", ["get", "set"])
@respx.mock
def test_sync_propagates_server_failure(method: str) -> None:
    respx.route(method="GET" if method == "get" else "PUT", url=PATH).respond(404, json={"message": "missing"})
    with XbergClient(api_key="test", base_url=URL, target="pro") as client, pytest.raises(NotFoundError) as exc:
        getattr(client, f"{method}_integration_sync")(
            "project-1", "integration-1", *([] if method == "get" else [{"enabled": True}])
        )
    assert exc.value.status_code == 404


@pytest.mark.asyncio
@pytest.mark.parametrize("method", ["get", "set"])
@respx.mock
async def test_async_propagates_server_failure(method: str) -> None:
    respx.route(method="GET" if method == "get" else "PUT", url=PATH).respond(404, json={"message": "missing"})
    async with AsyncXbergClient(api_key="test", base_url=URL, target="pro") as client:
        with pytest.raises(NotFoundError) as exc:
            await getattr(client, f"{method}_integration_sync")(
                "project-1", "integration-1", *([] if method == "get" else [{"enabled": True}])
            )
    assert exc.value.status_code == 404


@pytest.mark.parametrize("method", ["get", "set"])
@respx.mock
def test_sync_refuses_enterprise_before_http(method: str) -> None:
    with (
        XbergClient(api_key="test", base_url=URL, target="enterprise") as client,
        pytest.raises(XbergError, match="pro"),
    ):
        getattr(client, f"{method}_integration_sync")(
            "project-1", "integration-1", *([] if method == "get" else [{"enabled": True}])
        )
    assert len(respx.calls) == 0


@pytest.mark.asyncio
@pytest.mark.parametrize("method", ["get", "set"])
@respx.mock
async def test_async_refuses_enterprise_before_http(method: str) -> None:
    async with AsyncXbergClient(api_key="test", base_url=URL, target="enterprise") as client:
        with pytest.raises(XbergError, match="pro"):
            await getattr(client, f"{method}_integration_sync")(
                "project-1", "integration-1", *([] if method == "get" else [{"enabled": True}])
            )
    assert len(respx.calls) == 0
