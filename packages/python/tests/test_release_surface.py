"""Wire-level checks for endpoints added in the Pro 0.5.0 spec sync."""

from __future__ import annotations

import inspect
import json
from typing import TYPE_CHECKING, Any, NamedTuple

import pytest
import respx

from xberg_io_sdk import AsyncXbergClient, XbergClient

if TYPE_CHECKING:
    from xberg_io_sdk.client import Target

PROJECT = "11111111-1111-4111-8111-111111111111"
ROOM = "22222222-2222-4222-8222-222222222222"
LINK = "33333333-3333-4333-8333-333333333333"
NOW = "2026-11-01T09:00:00+00:00"
CONFIG_PATH = f"/v1/projects/{PROJECT}/extraction-config"
PROJECT_PATH = f"/v1/projects/{PROJECT}"
LINKS_PATH = f"/v1/rooms/{ROOM}/links"
LINK_DATA = {
    "id": LINK,
    "role": "VIEWER",
    "role_name": "data_room.viewer",
    "status": "ACTIVE",
    "created_at": NOW,
    "created_by": "owner",
    "token": "link-token",
}
PROJECT_DATA = {
    "id": PROJECT,
    "name": "Renamed",
    "slug": "project",
    "status": "active",
    "owner_user_id": "owner",
    "created_at": NOW,
    "updated_at": NOW,
    "api_key_count": 0,
    "webhook_count": 0,
    "total_pages_extracted": 0,
}
ACCEPTED = {"room_id": ROOM, "project_id": PROJECT, "kind": "guest", "role": "VIEWER"}


class Operation(NamedTuple):
    name: str
    tier: Target
    verb: str
    path: str
    args: tuple[Any, ...]
    kwargs: dict[str, Any]
    body: dict[str, Any] | None
    response: dict[str, Any] | None
    status: int


@pytest.mark.parametrize("client_type", [XbergClient, AsyncXbergClient])
@pytest.mark.parametrize(
    "operation",
    [
        Operation(
            "get_project_extraction_config",
            "enterprise",
            "GET",
            CONFIG_PATH,
            (PROJECT,),
            {},
            None,
            {"extraction_config": None},
            200,
        ),
        Operation(
            "set_project_extraction_config",
            "enterprise",
            "PUT",
            CONFIG_PATH,
            (PROJECT, {}),
            {},
            {},
            {"extraction_config": {}},
            200,
        ),
        Operation(
            "clear_project_extraction_config", "enterprise", "DELETE", CONFIG_PATH, (PROJECT,), {}, None, None, 204
        ),
        Operation(
            "list_room_links",
            "enterprise",
            "GET",
            LINKS_PATH + "?limit=2&offset=1",
            (ROOM,),
            {"limit": 2, "offset": 1},
            None,
            {"links": [], "total": 0, "limit": 2, "offset": 1},
            200,
        ),
        Operation(
            "create_room_link",
            "enterprise",
            "POST",
            LINKS_PATH,
            (ROOM, {"role": "VIEWER"}),
            {},
            {"role": "VIEWER"},
            LINK_DATA,
            201,
        ),
        Operation(
            "revoke_room_link", "enterprise", "DELETE", f"{LINKS_PATH}/{LINK}", (ROOM, LINK), {}, None, None, 204
        ),
        Operation(
            "accept_room_link",
            "enterprise",
            "POST",
            "/v1/room-links/accept",
            ({"token": "link-token"},),
            {"session_token": "session"},
            {"token": "link-token"},
            ACCEPTED,
            200,
        ),
        Operation("pro_get_project", "pro", "GET", PROJECT_PATH, (PROJECT,), {}, None, PROJECT_DATA, 200),
        Operation(
            "pro_update_project",
            "pro",
            "PATCH",
            PROJECT_PATH,
            (PROJECT, {"name": "Renamed"}),
            {},
            {"name": "Renamed"},
            PROJECT_DATA,
            200,
        ),
        Operation("pro_delete_project", "pro", "DELETE", PROJECT_PATH, (PROJECT,), {}, None, None, 204),
    ],
)
@respx.mock
async def test_release_operation_wire_contract(
    base_url: str,
    api_key: str,
    client_type: type[XbergClient | AsyncXbergClient],
    operation: Operation,
) -> None:
    name, tier, verb, path, args, kwargs, body, response, status = operation
    route = respx.request(verb, base_url + path).respond(status, json=response)
    client = client_type(api_key=api_key, base_url=base_url, target=tier)
    if isinstance(client, AsyncXbergClient):
        async with client:
            result = await getattr(client, name)(*args, **kwargs)
    else:
        with client:
            result = getattr(client, name)(*args, **kwargs)
    assert not inspect.isawaitable(result)
    assert route.call_count == 1
    request = route.calls.last.request
    assert request.headers.get("authorization") == f"Bearer {kwargs.get('session_token', api_key)}"
    assert request.headers.get("x-project-id") == (PROJECT if path == CONFIG_PATH else None)
    assert (json.loads(request.content) if request.content else None) == body
    if response is None:
        assert result is None
    else:
        assert result.to_dict() == response
