"""Coverage for the Enterprise data-room and project-document operations.

Every data-room route is Enterprise-only, so each method is tier-gated. Three
behaviours are specific to this surface and are pinned here: the room writes
that take ``If-Match`` (412/428 map to the precondition errors), the public
``/public/rooms`` routes that must send no credential, and the 404
``data_room.disabled`` answer a plan without data rooms gives on every route.
"""

from __future__ import annotations

import json
from typing import TYPE_CHECKING, Any

import httpx
import pytest
import respx

from xberg_io_sdk import (
    AsyncXbergClient,
    DataRoomsDisabledError,
    NotFoundError,
    PreconditionFailedError,
    PreconditionRequiredError,
    XbergClient,
    XbergError,
)

if TYPE_CHECKING:
    from collections.abc import Callable

ROOM_ID = "11111111-1111-4111-8111-111111111111"
PROJECT_ID = "22222222-2222-4222-8222-222222222222"
DOCUMENT_ID = "33333333-3333-4333-8333-333333333333"
OTHER_DOCUMENT_ID = "44444444-4444-4444-8444-444444444444"
INVITATION_ID = "55555555-5555-4555-8555-555555555555"
USER_ID = "user-sub-1"
SLUG = "q3-board-pack"
ITEM_REF = "itm_abc"
SESSION_TOKEN = "header.payload.signature"
PDF_BYTES = b"%PDF-1.7 original"
PNG_BYTES = b"\x89PNG\r\n\x1a\n page"
NOW = "2026-10-01T09:00:00Z"

ROOM = {
    "id": ROOM_ID,
    "project_id": PROJECT_ID,
    "name": "Board pack",
    "description": None,
    "version": 7,
    "created_by": USER_ID,
    "created_at": NOW,
    "updated_at": NOW,
    "rights": {"permissions": ["data_room.read"], "role": "OWNER"},
}
ITEM = {
    "document_id": DOCUMENT_ID,
    "position": 0,
    "filename": "minutes.pdf",
    "mime_type": "application/pdf",
    "size_bytes": 1234,
    "updated_at": NOW,
}
MEMBER = {
    "user_id": USER_ID,
    "kind": "member",
    "role": "VIEWER",
    "role_name": "data_room.viewer",
    "is_owner": False,
    "added_by": "owner-sub",
    "created_at": NOW,
}
INVITATION = {
    "id": INVITATION_ID,
    "email": "guest@example.test",
    "role": "VIEWER",
    "role_name": "data_room.viewer",
    "status": "pending",
    "invited_by": USER_ID,
    "delivery_channel": "email",
    "expires_at": NOW,
    "created_at": NOW,
}
PUBLICATION = {
    "room_version": 7,
    "state": "published",
    "mode": "live",
    "download_allowed": True,
    "generation": 3,
    "slug": SLUG,
}
PUBLIC_ITEM = {
    "item_ref": ITEM_REF,
    "filename": "minutes.pdf",
    "mime_type": "application/pdf",
    "size_bytes": 1234,
    "updated_at": NOW,
}
DOCUMENT = {
    "document_id": DOCUMENT_ID,
    "filename": "minutes.pdf",
    "mime_type": "application/pdf",
    "size_bytes": 1234,
    "updated_at": NOW,
}


def page(key: str, entries: list[dict[str, Any]], *, limit: int = 50, offset: int = 0) -> dict[str, Any]:
    """Build a ``{key, total, limit, offset}`` list body as every room list route answers."""
    return {key: entries, "total": len(entries), "limit": limit, "offset": offset}


def disabled() -> httpx.Response:
    """The answer of every room route on a plan without data rooms."""
    return httpx.Response(
        404,
        json={
            "error": {
                "code": "data_room.disabled",
                "message": "Data rooms are not part of the plan of this deployment.",
            }
        },
    )


R = f"/v1/rooms/{ROOM_ID}"
P = f"/public/rooms/{SLUG}"

# (method name, args, kwargs, verb, wire path, status, response body or bytes)
OPERATIONS: list[tuple[str, tuple[Any, ...], dict[str, Any], str, str, int, Any]] = [
    ("list_documents", (), {}, "GET", "/v1/documents", 200, page("documents", [DOCUMENT])),
    ("list_rooms", (), {}, "GET", "/v1/rooms", 200, page("rooms", [ROOM])),
    ("create_room", ({"name": "Board pack"},), {}, "POST", "/v1/rooms", 201, ROOM),
    ("get_room", (ROOM_ID,), {}, "GET", R, 200, ROOM),
    ("update_room", (ROOM_ID, {"name": "New"}), {"if_match": 7}, "PATCH", R, 200, ROOM),
    ("delete_room", (ROOM_ID,), {}, "DELETE", R, 204, None),
    ("restore_room", (ROOM_ID,), {}, "POST", f"{R}/restore", 200, ROOM),
    ("list_room_items", (ROOM_ID,), {}, "GET", f"{R}/items", 200, {**page("items", [ITEM]), "version": 7}),
    ("add_room_item", (ROOM_ID, {"document_id": DOCUMENT_ID}), {}, "POST", f"{R}/items", 201, ITEM),
    (
        "reorder_room_items",
        (ROOM_ID, {"document_ids": [DOCUMENT_ID]}),
        {"if_match": 7},
        "PUT",
        f"{R}/items/order",
        200,
        {"document_ids": [DOCUMENT_ID], "version": 8},
    ),
    ("remove_room_item", (ROOM_ID, DOCUMENT_ID), {}, "DELETE", f"{R}/items/{DOCUMENT_ID}", 204, None),
    (
        "get_room_item_content",
        (ROOM_ID, DOCUMENT_ID),
        {},
        "GET",
        f"{R}/items/{DOCUMENT_ID}/content",
        200,
        {"document_id": DOCUMENT_ID, "filename": "minutes.pdf", "mime_type": "application/pdf", "status": "pending"},
    ),
    ("download_room_item", (ROOM_ID, DOCUMENT_ID), {}, "GET", f"{R}/items/{DOCUMENT_ID}/download", 200, PDF_BYTES),
    ("get_room_item_page", (ROOM_ID, DOCUMENT_ID, 2), {}, "GET", f"{R}/items/{DOCUMENT_ID}/pages/2", 200, PNG_BYTES),
    ("list_room_members", (ROOM_ID,), {}, "GET", f"{R}/members", 200, page("members", [MEMBER])),
    (
        "add_room_member",
        (ROOM_ID, {"user_id": USER_ID, "role": "VIEWER"}),
        {},
        "POST",
        f"{R}/members",
        201,
        MEMBER,
    ),
    (
        "change_room_member_role",
        (ROOM_ID, USER_ID, {"role": "EDITOR"}),
        {},
        "PATCH",
        f"{R}/members/{USER_ID}",
        200,
        MEMBER,
    ),
    ("remove_room_member", (ROOM_ID, USER_ID), {}, "DELETE", f"{R}/members/{USER_ID}", 204, None),
    ("transfer_room_ownership", (ROOM_ID, {"user_id": USER_ID}), {}, "POST", f"{R}/ownership", 204, None),
    ("leave_room", (ROOM_ID,), {}, "POST", f"{R}/leave", 204, None),
    ("list_room_invitations", (ROOM_ID,), {}, "GET", f"{R}/invitations", 200, page("invitations", [INVITATION])),
    (
        "create_room_invitation",
        (ROOM_ID, {"email": "guest@example.test", "role": "VIEWER"}),
        {},
        "POST",
        f"{R}/invitations",
        201,
        INVITATION,
    ),
    ("revoke_room_invitation", (ROOM_ID, INVITATION_ID), {}, "DELETE", f"{R}/invitations/{INVITATION_ID}", 204, None),
    (
        "preview_room_invitation",
        ({"token": "inv-token"},),
        {},
        "POST",
        "/v1/room-invitations/preview",
        200,
        {"room_name": "Board pack", "item_count": 3},
    ),
    (
        "accept_room_invitation",
        ({"token": "inv-token"},),
        {},
        "POST",
        "/v1/room-invitations/accept",
        200,
        {"room_id": ROOM_ID, "project_id": PROJECT_ID, "kind": "guest", "role": "VIEWER"},
    ),
    ("get_room_publication", (ROOM_ID,), {}, "GET", f"{R}/publication", 200, PUBLICATION),
    (
        "set_room_publication",
        (ROOM_ID, {"state": "published"}),
        {"if_match": 7},
        "PUT",
        f"{R}/publication",
        200,
        PUBLICATION,
    ),
    ("get_public_room", (SLUG,), {}, "GET", P, 200, {"name": "Board pack", "description": None}),
    ("list_public_room_items", (SLUG,), {}, "GET", f"{P}/items", 200, page("items", [PUBLIC_ITEM])),
    (
        "get_public_room_item_content",
        (SLUG, ITEM_REF),
        {},
        "GET",
        f"{P}/items/{ITEM_REF}/content",
        200,
        {"item_ref": ITEM_REF, "filename": "minutes.pdf", "mime_type": "application/pdf", "result": None},
    ),
    ("download_public_room_item", (SLUG, ITEM_REF), {}, "GET", f"{P}/items/{ITEM_REF}/download", 200, PDF_BYTES),
]

PUBLIC_METHODS = {name for name, *_ in OPERATIONS if name.endswith("public_room") or "public_room_" in name}


def mock_response(status: int, body: Any) -> httpx.Response:
    """Answer with JSON, raw bytes, or an empty 204, matching what the route serves."""
    if body is None:
        return httpx.Response(status)
    if isinstance(body, bytes):
        return httpx.Response(status, content=body, headers={"Content-Type": "application/octet-stream"})
    return httpx.Response(status, json=body)


def test_the_table_names_every_data_room_operation_once() -> None:
    assert len(OPERATIONS) == 31
    assert len({(verb, path) for _, _, _, verb, path, _, _ in OPERATIONS}) == 31
    assert {
        "get_public_room",
        "list_public_room_items",
        "get_public_room_item_content",
        "download_public_room_item",
    } == PUBLIC_METHODS


@pytest.mark.parametrize(("name", "args", "kwargs", "verb", "path", "status", "body"), OPERATIONS)
@respx.mock
def test_each_operation_reaches_its_route_sync(
    *, base_url: str, api_key: str, name: str, args: tuple, kwargs: dict, verb: str, path: str, status: int, body: Any
) -> None:
    route = respx.request(verb, f"{base_url}{path}").mock(return_value=mock_response(status, body))
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        result = getattr(client, name)(*args, **kwargs)

    assert route.call_count == 1
    request = route.calls.last.request
    assert request.method == verb
    assert request.url.path == path
    if body is None:
        assert result is None
    elif isinstance(body, bytes):
        assert result == body
    else:
        assert result.to_dict()  # decoded into the generated model
    if args and isinstance(args[-1], dict):
        assert json.loads(request.content) == args[-1]
    if name in PUBLIC_METHODS:
        assert "authorization" not in request.headers
    else:
        assert request.headers["authorization"] == f"Bearer {api_key}"


@pytest.mark.parametrize(("name", "args", "kwargs", "verb", "path", "status", "body"), OPERATIONS)
@respx.mock
async def test_each_operation_reaches_its_route_async(
    *, base_url: str, api_key: str, name: str, args: tuple, kwargs: dict, verb: str, path: str, status: int, body: Any
) -> None:
    route = respx.request(verb, f"{base_url}{path}").mock(return_value=mock_response(status, body))
    async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        result = await getattr(client, name)(*args, **kwargs)

    assert route.call_count == 1
    request = route.calls.last.request
    assert request.url.path == path
    if isinstance(body, bytes):
        assert result == body
    elif body is None:
        assert result is None
    if name in PUBLIC_METHODS:
        assert "authorization" not in request.headers
    else:
        assert request.headers["authorization"] == f"Bearer {api_key}"


# -- If-Match --------------------------------------------------------------------


IF_MATCH_CALLS: list[tuple[str, Callable[[XbergClient, Any], Any], str, str, dict[str, Any]]] = [
    ("update_room", lambda c, v: c.update_room(ROOM_ID, {"name": "x"}, if_match=v), "PATCH", R, ROOM),
    (
        "reorder_room_items",
        lambda c, v: c.reorder_room_items(ROOM_ID, {"document_ids": []}, if_match=v),
        "PUT",
        f"{R}/items/order",
        {"document_ids": [], "version": 8},
    ),
    (
        "set_room_publication",
        lambda c, v: c.set_room_publication(ROOM_ID, {"state": "unpublished"}, if_match=v),
        "PUT",
        f"{R}/publication",
        PUBLICATION,
    ),
]


@pytest.mark.parametrize(("name", "call", "verb", "path", "body"), IF_MATCH_CALLS)
@pytest.mark.parametrize(("version", "sent"), [(7, '"7"'), ('"7"', '"7"'), ("7", "7")])
@respx.mock
def test_room_writes_send_the_version_as_if_match(
    *, base_url: str, api_key: str, name: str, call: Callable, verb: str, path: str, body: Any, version: Any, sent: str
) -> None:
    route = respx.request(verb, f"{base_url}{path}").mock(return_value=httpx.Response(200, json=body))
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        call(client, version)

    assert route.calls.last.request.headers["if-match"] == sent, name


@pytest.mark.parametrize(("name", "call", "verb", "path", "body"), IF_MATCH_CALLS)
@pytest.mark.parametrize(
    ("status", "error_type", "code"),
    [(412, PreconditionFailedError, "precondition_failed"), (428, PreconditionRequiredError, "precondition_required")],
)
@respx.mock
def test_room_writes_map_precondition_statuses(
    *,
    base_url: str,
    api_key: str,
    name: str,
    call: Callable,
    verb: str,
    path: str,
    body: Any,
    status: int,
    error_type: type[XbergError],
    code: str,
) -> None:
    respx.request(verb, f"{base_url}{path}").mock(
        return_value=httpx.Response(status, json={"error": {"code": code, "message": "The room changed"}})
    )
    with (
        XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client,
        pytest.raises(error_type) as info,
    ):
        call(client, 6)

    assert info.value.status == status, name
    assert info.value.code == code


@pytest.mark.parametrize("bad", [True, 7.0, None])
def test_if_match_rejects_a_value_that_is_no_room_version(base_url: str, api_key: str, bad: Any) -> None:
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client, pytest.raises(TypeError):
        client.update_room(ROOM_ID, {"name": "x"}, if_match=bad)


def test_if_match_rejects_a_blank_string(base_url: str, api_key: str) -> None:
    with (
        XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client,
        pytest.raises(ValueError, match="must not be blank"),
    ):
        client.update_room(ROOM_ID, {"name": "x"}, if_match="  ")


@respx.mock
def test_the_new_version_comes_back_on_the_answer(base_url: str, api_key: str) -> None:
    respx.patch(f"{base_url}{R}").mock(return_value=httpx.Response(200, json={**ROOM, "version": 8}))
    respx.put(f"{base_url}{R}/items/order").mock(
        return_value=httpx.Response(200, json={"document_ids": [OTHER_DOCUMENT_ID, DOCUMENT_ID], "version": 9})
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        room = client.update_room(ROOM_ID, {"description": None}, if_match=7)
        order = client.reorder_room_items(
            ROOM_ID, {"document_ids": [OTHER_DOCUMENT_ID, DOCUMENT_ID]}, if_match=room.version
        )

    assert room.version == 8
    assert order.version == 9
    assert [str(d) for d in order.document_ids] == [OTHER_DOCUMENT_ID, DOCUMENT_ID]


@respx.mock
async def test_async_room_write_sends_if_match_and_maps_412(base_url: str, api_key: str) -> None:
    route = respx.put(f"{base_url}{R}/publication").mock(
        return_value=httpx.Response(412, json={"error": {"code": "precondition_failed", "message": "stale"}})
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        with pytest.raises(PreconditionFailedError):
            await client.set_room_publication(ROOM_ID, {"state": "published"}, if_match=3)

    assert route.calls.last.request.headers["if-match"] == '"3"'


# -- Public routes and session credentials --------------------------------------


@respx.mock
def test_public_routes_send_no_credential_or_cookie(base_url: str) -> None:
    route = respx.get(f"{base_url}{P}").mock(return_value=httpx.Response(200, json={"name": "Board pack"}))
    headers = {"Cookie": "session=abc", "X-Api-Key": "kz_other", "X-Trace": "kept"}
    with XbergClient(api_key="kz_secret", base_url=base_url, target="enterprise", headers=headers) as client:
        assert client.get_public_room(SLUG).name == "Board pack"

    sent = route.calls.last.request.headers
    assert "authorization" not in sent
    assert "cookie" not in sent
    assert "x-api-key" not in sent
    assert sent["x-trace"] == "kept"


@respx.mock
def test_public_routes_work_without_an_api_key(base_url: str) -> None:
    route = respx.get(f"{base_url}{P}/items").mock(
        return_value=httpx.Response(200, json=page("items", [PUBLIC_ITEM], limit=10, offset=20))
    )
    with XbergClient(base_url=base_url, target="enterprise") as client:
        items = client.list_public_room_items(SLUG, limit=10, offset=20)

    assert items.items[0].item_ref == ITEM_REF
    assert dict(route.calls.last.request.url.params) == {"limit": "10", "offset": "20"}
    assert "authorization" not in route.calls.last.request.headers


@respx.mock
def test_authenticated_room_route_after_a_public_one_still_sends_the_key(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}{P}").mock(return_value=httpx.Response(200, json={"name": "Board pack"}))
    private = respx.get(f"{base_url}{R}").mock(return_value=httpx.Response(200, json=ROOM))
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        client.get_public_room(SLUG)
        client.get_room(ROOM_ID)

    assert private.calls.last.request.headers["authorization"] == f"Bearer {api_key}"


@pytest.mark.parametrize("name", ["preview_room_invitation", "accept_room_invitation"])
@respx.mock
def test_invitation_routes_send_the_session_token_in_place_of_the_key(base_url: str, api_key: str, name: str) -> None:
    _, args, _, verb, path, status, body = next(op for op in OPERATIONS if op[0] == name)
    route = respx.request(verb, f"{base_url}{path}").mock(return_value=httpx.Response(status, json=body))
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        getattr(client, name)(*args, session_token=SESSION_TOKEN)

    assert route.calls.last.request.headers["authorization"] == f"Bearer {SESSION_TOKEN}"
    assert json.loads(route.calls.last.request.content) == {"token": "inv-token"}


@respx.mock
async def test_async_accept_invitation_sends_the_session_token(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}/v1/room-invitations/accept").mock(
        return_value=httpx.Response(
            200, json={"room_id": ROOM_ID, "project_id": PROJECT_ID, "kind": "guest", "role": "VIEWER"}
        )
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        accepted = await client.accept_room_invitation({"token": "t"}, session_token=SESSION_TOKEN)

    assert str(accepted.room_id) == ROOM_ID
    assert route.calls.last.request.headers["authorization"] == f"Bearer {SESSION_TOKEN}"


# -- Pagination, downloads ------------------------------------------------------


@respx.mock
def test_list_rooms_sends_state_and_pagination(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}/v1/rooms").mock(
        return_value=httpx.Response(200, json=page("rooms", [ROOM], limit=5, offset=10))
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        rooms = client.list_rooms(state="deleted", limit=5, offset=10)

    assert dict(route.calls.last.request.url.params) == {"state": "deleted", "limit": "5", "offset": "10"}
    assert (rooms.total, rooms.limit, rooms.offset) == (1, 5, 10)
    assert rooms.rooms[0].version == 7


@pytest.mark.parametrize(
    ("name", "path", "key"),
    [
        ("list_room_items", f"{R}/items", "items"),
        ("list_room_members", f"{R}/members", "members"),
        ("list_room_invitations", f"{R}/invitations", "invitations"),
    ],
)
@respx.mock
def test_room_lists_send_limit_and_offset(base_url: str, api_key: str, name: str, path: str, key: str) -> None:
    body = {**page(key, [], limit=2, offset=4), "version": 1}
    route = respx.get(f"{base_url}{path}").mock(return_value=httpx.Response(200, json=body))
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        getattr(client, name)(ROOM_ID, limit=2, offset=4)

    assert dict(route.calls.last.request.url.params) == {"limit": "2", "offset": "4"}


@respx.mock
def test_list_documents_paginates_and_omits_unset_parameters(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}/v1/documents").mock(
        return_value=httpx.Response(200, json=page("documents", [DOCUMENT]))
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        first = client.list_documents()
        client.list_documents(limit=100, offset=50)

    assert str(first.documents[0].document_id) == DOCUMENT_ID
    assert dict(route.calls[0].request.url.params) == {}
    assert dict(route.calls[1].request.url.params) == {"limit": "100", "offset": "50"}


@respx.mock
def test_download_returns_the_original_bytes_untouched(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}{R}/items/{DOCUMENT_ID}/download").mock(
        return_value=httpx.Response(
            200,
            content=PDF_BYTES,
            headers={"Content-Type": "application/pdf", "Content-Disposition": 'attachment; filename="minutes.pdf"'},
        )
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        assert client.download_room_item(ROOM_ID, DOCUMENT_ID) == PDF_BYTES


@respx.mock
def test_download_refused_by_the_room_raises_instead_of_returning_the_error_body(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}{P}/items/{ITEM_REF}/download").mock(
        return_value=httpx.Response(404, json={"error": {"code": "not_found", "message": "The room is not published"}})
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client, pytest.raises(NotFoundError):
        client.download_public_room_item(SLUG, ITEM_REF)


# -- Plan gating, tier gating, retries ------------------------------------------


@pytest.mark.parametrize(
    ("name", "args", "kwargs", "verb", "path"),
    [(n, a, k, v, p) for n, a, k, v, p, _, _ in OPERATIONS if n != "list_documents"],
)
@respx.mock
def test_data_room_disabled_raises_a_typed_not_found(
    *, base_url: str, api_key: str, name: str, args: tuple, kwargs: dict, verb: str, path: str
) -> None:
    respx.request(verb, f"{base_url}{path}").mock(return_value=disabled())
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        with pytest.raises(DataRoomsDisabledError) as info:
            getattr(client, name)(*args, **kwargs)

    assert isinstance(info.value, NotFoundError)
    assert info.value.code == "data_room.disabled"
    assert info.value.status == 404


@respx.mock
def test_a_plain_room_404_is_not_reported_as_disabled(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}{R}").mock(
        return_value=httpx.Response(404, json={"error": {"code": "not_found", "message": "Room not found"}})
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        with pytest.raises(NotFoundError) as info:
            client.get_room(ROOM_ID)

    assert not isinstance(info.value, DataRoomsDisabledError)


@pytest.mark.parametrize(("name", "args", "kwargs"), [(n, a, k) for n, a, k, *_ in OPERATIONS])
@respx.mock
def test_data_room_methods_refuse_the_pro_tier_before_the_wire(
    base_url: str, api_key: str, name: str, args: tuple, kwargs: dict
) -> None:
    with XbergClient(api_key=api_key, base_url=base_url, target="pro") as client:
        with pytest.raises(XbergError, match=rf"{name}\(\) is not available on the 'pro' tier"):
            getattr(client, name)(*args, **kwargs)

    assert respx.calls.call_count == 0


@respx.mock
def test_room_creation_is_not_replayed_on_503_by_default(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}/v1/rooms").mock(return_value=httpx.Response(503, json={"message": "busy"}))
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise", retries=2) as client:
        with pytest.raises(XbergError):
            client.create_room({"name": "Board pack"})

    assert route.call_count == 1


@respx.mock
def test_room_creation_is_replayed_when_the_client_opts_in(
    base_url: str, api_key: str, monkeypatch: pytest.MonkeyPatch
) -> None:
    monkeypatch.setattr("xberg_io_sdk.client.time.sleep", lambda _: None)
    route = respx.post(f"{base_url}/v1/rooms").mock(
        side_effect=[httpx.Response(503, json={"message": "busy"}), httpx.Response(201, json=ROOM)]
    )
    with XbergClient(
        api_key=api_key, base_url=base_url, target="enterprise", retries=2, retry_non_idempotent=True
    ) as client:
        assert client.create_room({"name": "Board pack"}).name == "Board pack"

    assert route.call_count == 2


@respx.mock
def test_room_reads_are_replayed_on_503(base_url: str, api_key: str, monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setattr("xberg_io_sdk.client.time.sleep", lambda _: None)
    route = respx.get(f"{base_url}{P}").mock(
        side_effect=[httpx.Response(503, json={"message": "busy"}), httpx.Response(200, json={"name": "Board pack"})]
    )
    with XbergClient(base_url=base_url, target="enterprise", retries=1) as client:
        client.get_public_room(SLUG)

    assert route.call_count == 2
    assert all("authorization" not in call.request.headers for call in route.calls)


@pytest.mark.parametrize(("name", "call", "verb", "path", "body"), IF_MATCH_CALLS)
@respx.mock
def test_versioned_writes_are_not_replayed_on_503_by_default(
    *, base_url: str, api_key: str, name: str, call: Callable, verb: str, path: str, body: Any
) -> None:
    route = respx.request(verb, f"{base_url}{path}").mock(return_value=httpx.Response(503, json={"message": "busy"}))
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise", retries=2) as client:
        with pytest.raises(XbergError):
            call(client, 7)

    assert route.call_count == 1, name


@pytest.mark.parametrize(("name", "call", "verb", "path", "body"), IF_MATCH_CALLS)
@respx.mock
def test_versioned_writes_are_replayed_on_503_when_the_client_opts_in(
    *,
    base_url: str,
    api_key: str,
    monkeypatch: pytest.MonkeyPatch,
    name: str,
    call: Callable,
    verb: str,
    path: str,
    body: Any,
) -> None:
    monkeypatch.setattr("xberg_io_sdk.client.time.sleep", lambda _: None)
    route = respx.request(verb, f"{base_url}{path}").mock(
        side_effect=[httpx.Response(503, json={"message": "busy"}), httpx.Response(200, json=body)]
    )
    with XbergClient(
        api_key=api_key, base_url=base_url, target="enterprise", retries=2, retry_non_idempotent=True
    ) as client:
        call(client, 7)

    assert route.call_count == 2, name


@respx.mock
def test_versioned_write_is_still_replayed_on_429(base_url: str, api_key: str, monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setattr("xberg_io_sdk.client.time.sleep", lambda _: None)
    route = respx.put(f"{base_url}{R}/publication").mock(
        side_effect=[httpx.Response(429, json={"message": "slow down"}), httpx.Response(200, json=PUBLICATION)]
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise", retries=2) as client:
        client.set_room_publication(ROOM_ID, {"state": "published"}, if_match=7)

    assert route.call_count == 2


@respx.mock
def test_room_item_removal_is_replayed_on_503(base_url: str, api_key: str, monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setattr("xberg_io_sdk.client.time.sleep", lambda _: None)
    route = respx.delete(f"{base_url}{R}/items/{DOCUMENT_ID}").mock(
        side_effect=[httpx.Response(503, json={"message": "busy"}), httpx.Response(204)]
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise", retries=2) as client:
        client.remove_room_item(ROOM_ID, DOCUMENT_ID)

    assert route.call_count == 2


@respx.mock
async def test_async_versioned_write_is_not_replayed_on_504(base_url: str, api_key: str) -> None:
    route = respx.put(f"{base_url}{R}/items/order").mock(return_value=httpx.Response(504, json={"message": "late"}))
    async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise", retries=2) as client:
        with pytest.raises(XbergError):
            await client.reorder_room_items(ROOM_ID, {"document_ids": []}, if_match=7)

    assert route.call_count == 1


@pytest.mark.parametrize("name", ["preview_room_invitation", "accept_room_invitation"])
@pytest.mark.parametrize("blank", ["", "   "])
@respx.mock
def test_invitation_routes_refuse_a_blank_session_token_before_the_wire(
    base_url: str, api_key: str, name: str, blank: str
) -> None:
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        with pytest.raises(ValueError, match="session_token must not be blank"):
            getattr(client, name)({"token": "inv-token"}, session_token=blank)

    assert respx.calls.call_count == 0


@pytest.mark.parametrize("name", ["preview_room_invitation", "accept_room_invitation"])
@pytest.mark.parametrize("blank", ["", "\t "])
@respx.mock
async def test_async_invitation_routes_refuse_a_blank_session_token_before_the_wire(
    base_url: str, api_key: str, name: str, blank: str
) -> None:
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        with pytest.raises(ValueError, match="session_token must not be blank"):
            await getattr(client, name)({"token": "inv-token"}, session_token=blank)

    assert respx.calls.call_count == 0


@respx.mock
def test_path_parameters_are_percent_encoded(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}/public/rooms/a%2Fb/items/c%3Fd/content").mock(
        return_value=httpx.Response(
            200, json={"item_ref": "c?d", "filename": "f", "mime_type": "text/plain", "result": None}
        )
    )
    with XbergClient(base_url=base_url, target="enterprise") as client:
        client.get_public_room_item_content("a/b", "c?d")

    assert route.call_count == 1
