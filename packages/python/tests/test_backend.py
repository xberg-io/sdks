"""Wire contracts for all 48 Enterprise backend operations, distinct from Pro."""

from __future__ import annotations

import json
from pathlib import Path
from typing import Any
from urllib.parse import quote

import httpx
import pytest
import respx

from xberg_io_sdk import AsyncXbergClient, XbergClient, XbergError

CASES = json.loads(Path(__file__).with_name("backend_contract_cases.json").read_text())
CONTROL_URL = "https://control.example.test"
PATH_NAMES = {
    "id": "project_id",
    "iid": "integration_id",
    "doc_id": "document_id",
    "inv_id": "invitation_id",
    "wh_id": "webhook_id",
}


def case_path(case: dict[str, Any]) -> str:
    path = case["path"]
    for name, value in case["arguments"].items():
        original = next((key for key, renamed in PATH_NAMES.items() if renamed == name), name)
        path = path.replace("{" + original + "}", quote(str(value), safe=""))
    return path


def response_for(case: dict[str, Any]) -> httpx.Response:
    if "response" in case:
        return httpx.Response(case["status"], json=case["response"])
    if case.get("bytes"):
        return httpx.Response(200, content=b"document bytes")
    if case["operation_id"] == "oauth_callback":
        return httpx.Response(303, headers={"Location": "https://console.example.test/connected"})
    return httpx.Response(case["status"])


@pytest.mark.parametrize("asynchronous", [False, True])
@pytest.mark.parametrize("case", CASES, ids=lambda case: case["name"])
@respx.mock
async def test_backend_operation_wire_contract(
    base_url: str, api_key: str, asynchronous: bool, case: dict[str, Any]
) -> None:
    assert len(CASES) == 48
    route = respx.request(case["verb"], CONTROL_URL + case_path(case)).mock(return_value=response_for(case))
    arguments = dict(case["arguments"])
    if case.get("multipart"):
        arguments["file"] = b"document bytes"
    options = {"base_url": base_url, "api_key": api_key, "control_plane_base_url": CONTROL_URL, "target": "enterprise"}
    if asynchronous:
        async with AsyncXbergClient(**options) as client:
            result = await getattr(client, case["name"])(**arguments)
    else:
        with XbergClient(**options) as sync_client:
            result = getattr(sync_client, case["name"])(**arguments)
    assert route.call_count == 1
    request = route.calls.last.request
    assert request.url.params == httpx.QueryParams(case["query"])
    assert request.headers.get("Authorization") == (None if case["public"] else f"Bearer {api_key}")
    if "body" in arguments:
        assert json.loads(request.content) == arguments["body"]
    if case.get("multipart"):
        assert request.headers["Content-Type"].startswith("multipart/form-data;")
        assert b'name="file"' in request.content
        assert b"document bytes" in request.content
    if "model" in case:
        assert type(result).__name__ == case["model"]
        assert "_generated_backend" in type(result).__module__
        assert result.to_dict() == case["response"]
    elif case.get("bytes"):
        assert result == b"document bytes"
    elif case["operation_id"] == "oauth_callback":
        assert result == "https://console.example.test/connected"
    else:
        assert result is None


@pytest.mark.parametrize("asynchronous", [False, True])
@pytest.mark.parametrize("case", CASES, ids=lambda case: case["name"])
@respx.mock
async def test_backend_operation_propagates_errors(
    base_url: str, api_key: str, asynchronous: bool, case: dict[str, Any]
) -> None:
    route = respx.request(case["verb"], CONTROL_URL + case_path(case)).respond(403, json={"error": "denied"})
    arguments = dict(case["arguments"])
    if case.get("multipart"):
        arguments["file"] = b"document bytes"
    options = {"base_url": base_url, "api_key": api_key, "control_plane_base_url": CONTROL_URL, "target": "enterprise"}
    if asynchronous:
        async with AsyncXbergClient(**options) as client:
            with pytest.raises(XbergError) as error:
                await getattr(client, case["name"])(**arguments)
    else:
        with XbergClient(**options) as sync_client, pytest.raises(XbergError) as error:
            getattr(sync_client, case["name"])(**arguments)
    assert error.value.status_code == 403
    assert route.call_count == 1


@pytest.mark.parametrize("asynchronous", [False, True])
@respx.mock
async def test_control_credentials_do_not_leak_between_origins_or_public_routes(
    base_url: str, api_key: str, asynchronous: bool
) -> None:
    projects = respx.get(CONTROL_URL + "/v1/projects").respond(
        200, json={"projects": [], "total": 0, "limit": 1, "offset": 0}
    )
    health = respx.get(CONTROL_URL + "/healthz").respond(200, json={"status": "ok", "tier": "enterprise"})
    usage = respx.get(base_url + "/v1/usage").respond(200, json={"pages": 7})
    options = {
        "base_url": base_url,
        "api_key": api_key,
        "control_plane_base_url": CONTROL_URL,
        "control_plane_token": "backend-session",
        "headers": {
            "authorization": "Bearer stale",
            "Cookie": "session=private",
            "Proxy-Authorization": "Basic private",
            "X-Api-Key": "private",
        },
        "target": "enterprise",
    }
    if asynchronous:
        async with AsyncXbergClient(**options) as client:
            await client.backend_list_projects()
            await client.healthz()
            assert await client.usage() == {"pages": 7}
    else:
        with XbergClient(**options) as sync_client:
            sync_client.backend_list_projects()
            sync_client.healthz()
            assert sync_client.usage() == {"pages": 7}
    for name in ("Cookie", "Proxy-Authorization", "X-Api-Key"):
        assert name not in projects.calls.last.request.headers
        assert name not in health.calls.last.request.headers
        assert name in usage.calls.last.request.headers
    assert projects.calls.last.request.headers.get_list("Authorization") == ["Bearer backend-session"]
    assert "Authorization" not in health.calls.last.request.headers
    assert usage.calls.last.request.headers.get_list("Authorization") == [f"Bearer {api_key}"]


@pytest.mark.parametrize("asynchronous", [False, True])
@respx.mock
async def test_public_sandbox_uses_its_own_token_and_supports_web_without_a_file(
    base_url: str, api_key: str, asynchronous: bool
) -> None:
    case = next(case for case in CASES if case["operation_id"] == "public_sandbox_extract")
    route = respx.post(CONTROL_URL + case["path"]).mock(return_value=response_for(case))
    options = {
        "base_url": base_url,
        "api_key": api_key,
        "control_plane_base_url": CONTROL_URL,
        "control_plane_token": "backend-session",
        "target": "enterprise",
    }
    arguments = {"mode": "web", "url": "https://example.test/page", "sandbox_token": "sandbox-oidc"}
    if asynchronous:
        async with AsyncXbergClient(**options) as client:
            await client.public_sandbox_extract(**arguments)
    else:
        with XbergClient(**options) as sync_client:
            sync_client.public_sandbox_extract(**arguments)
    request = route.calls.last.request
    assert request.headers["Authorization"] == "Bearer sandbox-oidc"
    assert request.headers["Content-Type"].startswith("multipart/form-data;")
    assert b'name="mode"' in request.content
    assert b"web" in request.content
    assert b"https://example.test/page" in request.content
    assert b'name="file"' not in request.content
    assert b"backend-session" not in request.content


@pytest.mark.parametrize("asynchronous", [False, True])
@pytest.mark.parametrize("status", [200, 303])
@respx.mock
async def test_oauth_callback_rejects_missing_redirect_location(base_url: str, asynchronous: bool, status: int) -> None:
    respx.get(CONTROL_URL + "/v1/oauth/callback").respond(status)
    options = {"base_url": base_url, "control_plane_base_url": CONTROL_URL, "target": "enterprise"}
    if asynchronous:
        async with AsyncXbergClient(**options) as client:
            with pytest.raises(XbergError):
                await client.oauth_callback(code="code", state="state")
    else:
        with XbergClient(**options) as sync_client, pytest.raises(XbergError):
            sync_client.oauth_callback(code="code", state="state")


@pytest.mark.parametrize("asynchronous", [False, True])
@pytest.mark.parametrize("case", CASES, ids=lambda case: case["name"])
@respx.mock
async def test_backend_methods_refuse_an_explicit_pro_target(
    base_url: str, asynchronous: bool, case: dict[str, Any]
) -> None:
    arguments = dict(case["arguments"])
    if case.get("multipart"):
        arguments["file"] = b"document bytes"
    if asynchronous:
        async with AsyncXbergClient(base_url=base_url, target="pro") as client:
            with pytest.raises(XbergError, match="requires the 'enterprise' tier"):
                await getattr(client, case["name"])(**arguments)
    else:
        with XbergClient(base_url=base_url, target="pro") as sync_client:
            with pytest.raises(XbergError, match="requires the 'enterprise' tier"):
                getattr(sync_client, case["name"])(**arguments)


@pytest.mark.parametrize("asynchronous", [False, True])
@respx.mock
async def test_backend_invalid_json_is_a_contextual_sdk_error(base_url: str, asynchronous: bool) -> None:
    respx.get(CONTROL_URL + "/auth/config").respond(200, content=b"not json")
    options = {"base_url": base_url, "control_plane_base_url": CONTROL_URL, "target": "enterprise"}
    if asynchronous:
        async with AsyncXbergClient(**options) as client:
            with pytest.raises(XbergError, match="JSON"):
                await client.get_auth_config()
    else:
        with XbergClient(**options) as sync_client, pytest.raises(XbergError, match="JSON"):
            sync_client.get_auth_config()


@pytest.mark.parametrize("asynchronous", [False, True])
@respx.mock
async def test_oauth_callback_rejects_an_empty_location(base_url: str, asynchronous: bool) -> None:
    respx.get(CONTROL_URL + "/v1/oauth/callback").respond(303, headers={"Location": ""})
    options = {"base_url": base_url, "control_plane_base_url": CONTROL_URL, "target": "enterprise"}
    if asynchronous:
        async with AsyncXbergClient(**options) as client:
            with pytest.raises(XbergError):
                await client.oauth_callback(code="code", state="state")
    else:
        with XbergClient(**options) as sync_client, pytest.raises(XbergError):
            sync_client.oauth_callback(code="code", state="state")


@pytest.mark.parametrize("asynchronous", [False, True])
@pytest.mark.parametrize("segment", [".", ".."])
@respx.mock
async def test_member_dot_segments_cannot_retarget_account_management(
    base_url: str, asynchronous: bool, segment: str
) -> None:
    escaped = "%2E" * len(segment)
    route = respx.delete(CONTROL_URL + "/v1/projects/project/members/" + escaped).respond(204)
    options = {"base_url": base_url, "control_plane_base_url": CONTROL_URL, "target": "enterprise"}
    if asynchronous:
        async with AsyncXbergClient(**options) as client:
            await client.remove_member("project", segment)
    else:
        with XbergClient(**options) as sync_client:
            sync_client.remove_member("project", segment)
    assert route.call_count == 1
    assert route.calls.last.request.url.raw_path == ("/v1/projects/project/members/" + escaped).encode()


@pytest.mark.parametrize("asynchronous", [False, True])
@respx.mock
async def test_backend_methods_respect_a_previously_discovered_pro_tier(base_url: str, asynchronous: bool) -> None:
    respx.get(base_url + "/healthz").respond(200, json={"tier": "pro"})
    respx.get(base_url + "/auth/config").respond(200, json={"methods": ["api_key"]})
    if asynchronous:
        async with AsyncXbergClient(base_url=base_url) as client:
            await client.auth_config()
            with pytest.raises(XbergError, match="requires the 'enterprise' tier"):
                await client.backend_list_projects()
    else:
        with XbergClient(base_url=base_url) as sync_client:
            sync_client.auth_config()
            with pytest.raises(XbergError, match="requires the 'enterprise' tier"):
                sync_client.backend_list_projects()


@pytest.mark.parametrize("asynchronous", [False, True])
@respx.mock
async def test_explicit_empty_control_token_disables_api_key_fallback(
    base_url: str, api_key: str, asynchronous: bool
) -> None:
    route = respx.get(CONTROL_URL + "/v1/projects").respond(
        200, json={"projects": [], "total": 0, "limit": 1, "offset": 0}
    )
    options = {
        "base_url": base_url,
        "api_key": api_key,
        "control_plane_base_url": CONTROL_URL,
        "control_plane_token": "",
        "target": "enterprise",
    }
    if asynchronous:
        async with AsyncXbergClient(**options) as client:
            await client.backend_list_projects()
    else:
        with XbergClient(**options) as sync_client:
            sync_client.backend_list_projects()
    assert "Authorization" not in route.calls.last.request.headers
