"""Coverage for the five saved-preset operations, which both specs declare and neither gates.

Both specs serve ``/v1/saved_presets`` and ``/v1/saved_presets/{preset_id}`` — the hyphenated
spelling the client once sent to Pro survives only as an OpenAPI *tag* name, which is not a
route. Nothing here resolves a tier, so these calls must never trigger the ``/healthz`` probe;
``respx`` fails any request to an unmocked route, so a stray probe would break these tests.
"""

from __future__ import annotations

import json
from typing import TYPE_CHECKING

import httpx
import pytest
import respx

from xberg_io_sdk import AsyncXbergClient, XbergClient
from xberg_io_sdk._generated_api.models.create_saved_preset_request import CreateSavedPresetRequest
from xberg_io_sdk._generated_api.models.create_saved_preset_request_schema import (
    CreateSavedPresetRequestSchema,
)

if TYPE_CHECKING:
    from xberg_io_sdk.client import Target

PRO_URL = "https://pro.example.test"
PRESETS_PATH = "/v1/saved_presets"
PRESET_ID = "55555555-5555-5555-5555-555555555555"

PRESET_SUMMARY = {
    "id": PRESET_ID,
    "name": "invoices",
    "preferred_call_mode": "text_only",
    "created_at": "2026-05-01T09:00:00Z",
    "description": "Vendor invoices",
}

PRESET_DETAIL = {
    "id": PRESET_ID,
    "name": "invoices",
    "preferred_call_mode": "text_only",
    "emit_citations": True,
    "schema": {"type": "object", "properties": {"total": {"type": "number"}}},
    "created_at": "2026-05-01T09:00:00Z",
    "updated_at": "2026-05-02T09:00:00Z",
}

PRESET_LIST = {"presets": [PRESET_SUMMARY], "total": 1, "limit": 50, "page": 1}
CREATE_RESPONSE = {"id": PRESET_ID, "name": "invoices", "message": "created", "success": True}
UPDATE_RESPONSE = {"message": "updated", "success": True}

CREATE_BODY = {"name": "invoices", "schema": {"type": "object"}, "preferred_call_mode": "text_only"}
UPDATE_BODY = {
    "name": "invoices-v2",
    "schema": {"type": "object"},
    "preferred_call_mode": "vision_only",
    "emit_citations": False,
}


def _client(api_key: str, base_url: str, target: Target) -> XbergClient:
    return XbergClient(api_key=api_key, base_url=base_url, target=target)


def _async_client(api_key: str, base_url: str, target: Target) -> AsyncXbergClient:
    return AsyncXbergClient(api_key=api_key, base_url=base_url, target=target)


# -- one path spelling, both tiers ---------------------------------------------


@respx.mock
def test_list_saved_presets_uses_underscore_path_on_enterprise(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}{PRESETS_PATH}").mock(return_value=httpx.Response(200, json=PRESET_LIST))
    with _client(api_key, base_url, "enterprise") as client:
        response = client.list_saved_presets()

    assert response.total == 1
    assert [preset.name for preset in response.presets] == ["invoices"]
    assert route.calls.last.request.method == "GET"
    assert route.calls.last.request.url.path == PRESETS_PATH


@respx.mock
def test_list_saved_presets_uses_the_same_underscore_path_on_pro(api_key: str) -> None:
    route = respx.get(f"{PRO_URL}{PRESETS_PATH}").mock(return_value=httpx.Response(200, json=PRESET_LIST))
    with _client(api_key, PRO_URL, "pro") as client:
        assert client.list_saved_presets().limit == 50

    assert route.calls.last.request.method == "GET"
    assert route.calls.last.request.url.path == PRESETS_PATH


@respx.mock
def test_saved_preset_path_never_hyphenates_the_collection(api_key: str) -> None:
    # The hyphenated route Pro was once sent is in neither spec; a request to it must not appear.
    hyphenated = respx.get(f"{PRO_URL}/v1/saved-presets/{PRESET_ID}")
    route = respx.get(f"{PRO_URL}{PRESETS_PATH}/{PRESET_ID}").mock(
        return_value=httpx.Response(200, json=PRESET_DETAIL),
    )
    with _client(api_key, PRO_URL, "pro") as client:
        assert str(client.get_saved_preset(PRESET_ID).id) == PRESET_ID

    assert route.calls.last.request.url.path == f"{PRESETS_PATH}/{PRESET_ID}"
    assert hyphenated.call_count == 0


@respx.mock
def test_saved_preset_calls_do_not_probe_the_tier(base_url: str, api_key: str) -> None:
    # No `target`: a surviving tier gate would issue GET /healthz, which is not mocked here.
    route = respx.get(f"{base_url}{PRESETS_PATH}").mock(return_value=httpx.Response(200, json=PRESET_LIST))
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        client.list_saved_presets()

    assert route.call_count == 1


# -- the five operations — sync ------------------------------------------------


@respx.mock
def test_list_saved_presets_sync_forwards_pagination(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}{PRESETS_PATH}").mock(return_value=httpx.Response(200, json=PRESET_LIST))
    with _client(api_key, base_url, "enterprise") as client:
        client.list_saved_presets(limit=10, offset=20)

    assert dict(route.calls.last.request.url.params) == {"limit": "10", "offset": "20"}


@respx.mock
def test_list_saved_presets_sync_omits_unset_pagination(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}{PRESETS_PATH}").mock(return_value=httpx.Response(200, json=PRESET_LIST))
    with _client(api_key, base_url, "enterprise") as client:
        client.list_saved_presets()

    assert dict(route.calls.last.request.url.params) == {}


@respx.mock
def test_create_saved_preset_sync(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}{PRESETS_PATH}").mock(
        return_value=httpx.Response(201, json=CREATE_RESPONSE),
    )
    with _client(api_key, base_url, "enterprise") as client:
        response = client.create_saved_preset(CREATE_BODY)

    assert str(response.id) == PRESET_ID
    assert response.success is True
    assert route.calls.last.request.method == "POST"
    assert route.calls.last.request.url.path == PRESETS_PATH
    assert json.loads(route.calls.last.request.content) == CREATE_BODY


@respx.mock
def test_create_saved_preset_sync_accepts_generated_request_model(api_key: str) -> None:
    route = respx.post(f"{PRO_URL}{PRESETS_PATH}").mock(return_value=httpx.Response(201, json=CREATE_RESPONSE))
    with _client(api_key, PRO_URL, "pro") as client:
        response = client.create_saved_preset(
            CreateSavedPresetRequest(
                name="invoices",
                preferred_call_mode="text_only",
                # `schema` is a generated model now that the spec types it, not a bare dict.
                schema=CreateSavedPresetRequestSchema.from_dict({"type": "object"}),
            ),
        )

    assert response.name == "invoices"
    assert json.loads(route.calls.last.request.content)["name"] == "invoices"


@respx.mock
def test_get_saved_preset_sync(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}{PRESETS_PATH}/{PRESET_ID}").mock(
        return_value=httpx.Response(200, json=PRESET_DETAIL),
    )
    with _client(api_key, base_url, "enterprise") as client:
        preset = client.get_saved_preset(PRESET_ID)

    assert str(preset.id) == PRESET_ID
    assert preset.emit_citations is True
    assert preset.schema.to_dict() == {"type": "object", "properties": {"total": {"type": "number"}}}
    assert route.calls.last.request.method == "GET"


@respx.mock
def test_update_saved_preset_sync_uses_patch(base_url: str, api_key: str) -> None:
    route = respx.patch(f"{base_url}{PRESETS_PATH}/{PRESET_ID}").mock(
        return_value=httpx.Response(200, json=UPDATE_RESPONSE),
    )
    with _client(api_key, base_url, "enterprise") as client:
        response = client.update_saved_preset(PRESET_ID, UPDATE_BODY)

    assert response.success is True
    assert response.message == "updated"
    assert route.calls.last.request.method == "PATCH"
    assert route.calls.last.request.url.path == f"{PRESETS_PATH}/{PRESET_ID}"
    assert json.loads(route.calls.last.request.content) == UPDATE_BODY


@respx.mock
def test_delete_saved_preset_sync_returns_none_on_204(base_url: str, api_key: str) -> None:
    route = respx.delete(f"{base_url}{PRESETS_PATH}/{PRESET_ID}").mock(return_value=httpx.Response(204))
    with _client(api_key, base_url, "enterprise") as client:
        assert client.delete_saved_preset(PRESET_ID) is None

    assert route.calls.last.request.method == "DELETE"
    assert route.calls.last.request.url.path == f"{PRESETS_PATH}/{PRESET_ID}"


@respx.mock
def test_delete_saved_preset_sync_on_pro_uses_the_same_path(api_key: str) -> None:
    route = respx.delete(f"{PRO_URL}{PRESETS_PATH}/{PRESET_ID}").mock(return_value=httpx.Response(204))
    with _client(api_key, PRO_URL, "pro") as client:
        assert client.delete_saved_preset(PRESET_ID) is None

    assert route.calls.last.request.url.path == f"{PRESETS_PATH}/{PRESET_ID}"


# -- the five operations — async -----------------------------------------------


@pytest.mark.asyncio
@respx.mock
async def test_list_saved_presets_async_on_enterprise(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}{PRESETS_PATH}").mock(return_value=httpx.Response(200, json=PRESET_LIST))
    async with _async_client(api_key, base_url, "enterprise") as client:
        response = await client.list_saved_presets(limit=5)

    assert str(response.presets[0].id) == PRESET_ID
    assert route.calls.last.request.url.path == PRESETS_PATH
    assert dict(route.calls.last.request.url.params) == {"limit": "5"}


@pytest.mark.asyncio
@respx.mock
async def test_list_saved_presets_async_on_pro(api_key: str) -> None:
    route = respx.get(f"{PRO_URL}{PRESETS_PATH}").mock(return_value=httpx.Response(200, json=PRESET_LIST))
    async with _async_client(api_key, PRO_URL, "pro") as client:
        assert (await client.list_saved_presets()).total == 1

    assert route.calls.last.request.url.path == PRESETS_PATH


@pytest.mark.asyncio
@respx.mock
async def test_create_saved_preset_async(api_key: str) -> None:
    route = respx.post(f"{PRO_URL}{PRESETS_PATH}").mock(return_value=httpx.Response(201, json=CREATE_RESPONSE))
    async with _async_client(api_key, PRO_URL, "pro") as client:
        response = await client.create_saved_preset(CREATE_BODY)

    assert str(response.id) == PRESET_ID
    assert route.calls.last.request.method == "POST"
    assert json.loads(route.calls.last.request.content) == CREATE_BODY


@pytest.mark.asyncio
@respx.mock
async def test_get_saved_preset_async(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}{PRESETS_PATH}/{PRESET_ID}").mock(
        return_value=httpx.Response(200, json=PRESET_DETAIL),
    )
    async with _async_client(api_key, base_url, "enterprise") as client:
        preset = await client.get_saved_preset(PRESET_ID)

    assert preset.name == "invoices"
    assert route.calls.last.request.method == "GET"


@pytest.mark.asyncio
@respx.mock
async def test_update_saved_preset_async_uses_patch(api_key: str) -> None:
    route = respx.patch(f"{PRO_URL}{PRESETS_PATH}/{PRESET_ID}").mock(
        return_value=httpx.Response(200, json=UPDATE_RESPONSE),
    )
    async with _async_client(api_key, PRO_URL, "pro") as client:
        response = await client.update_saved_preset(PRESET_ID, UPDATE_BODY)

    assert response.message == "updated"
    assert route.calls.last.request.method == "PATCH"
    assert route.calls.last.request.url.path == f"{PRESETS_PATH}/{PRESET_ID}"


@pytest.mark.asyncio
@respx.mock
async def test_delete_saved_preset_async(base_url: str, api_key: str) -> None:
    route = respx.delete(f"{base_url}{PRESETS_PATH}/{PRESET_ID}").mock(return_value=httpx.Response(204))
    async with _async_client(api_key, base_url, "enterprise") as client:
        assert await client.delete_saved_preset(PRESET_ID) is None

    assert route.calls.last.request.method == "DELETE"
