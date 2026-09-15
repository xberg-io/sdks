"""Coverage for the Xberg Pro control plane: projects, API keys, and integrations.

All thirteen operations live only in ``spec/pro/openapi.yaml``, so every one is gated to
the ``pro`` tier and every one decodes into a generated response model rather than a raw
dict. Each method is exercised once synchronously and once asynchronously.
"""

from __future__ import annotations

import json

import httpx
import pytest
import respx

from xberg_io_sdk import AsyncXbergClient, XbergClient, XbergError
from xberg_io_sdk._generated_pro.models.create_api_key_request import CreateApiKeyRequest
from xberg_io_sdk._generated_pro.models.create_project_request import CreateProjectRequest

PRO_URL = "https://pro.example.test"
PROJECT_ID = "11111111-1111-1111-1111-111111111111"
INTEGRATION_ID = "22222222-2222-2222-2222-222222222222"
KEY_ID = "33333333-3333-3333-3333-333333333333"

PROJECT = {
    "id": PROJECT_ID,
    "name": "Acme",
    "slug": "acme",
    "status": "active",
    "owner_user_id": "44444444-4444-4444-4444-444444444444",
    "created_at": "2026-05-01T09:00:00Z",
    "updated_at": "2026-05-02T09:00:00Z",
    "api_key_count": 2,
    "webhook_count": 1,
    "total_pages_extracted": 512,
}

API_KEY_ENTRY = {
    "id": KEY_ID,
    "key_prefix": "kz_live_abcd",
    "scope": "write",
    "created_at": "2026-05-01T09:00:00Z",
}

INTEGRATION = {
    "id": INTEGRATION_ID,
    "name": "Team Drive",
    "kind": "google_drive",
    "auth_type": "oauth2",
    "provider": "google",
}


def _pro_client(api_key: str) -> XbergClient:
    return XbergClient(api_key=api_key, base_url=PRO_URL, target="pro")


def _async_pro_client(api_key: str) -> AsyncXbergClient:
    return AsyncXbergClient(api_key=api_key, base_url=PRO_URL, target="pro")


# -- projects — sync -----------------------------------------------------------


@respx.mock
def test_list_projects_sync_forwards_pagination(api_key: str) -> None:
    route = respx.get(f"{PRO_URL}/v1/projects").mock(
        return_value=httpx.Response(200, json={"projects": [PROJECT], "total": 1, "limit": 25, "offset": 0}),
    )
    with _pro_client(api_key) as client:
        response = client.list_projects(limit=25, offset=0)

    assert response.total == 1
    assert response.limit == 25
    assert [project.slug for project in response.projects] == ["acme"]
    assert response.projects[0].api_key_count == 2
    assert dict(route.calls.last.request.url.params) == {"limit": "25", "offset": "0"}


@respx.mock
def test_list_projects_sync_omits_unset_pagination(api_key: str) -> None:
    route = respx.get(f"{PRO_URL}/v1/projects").mock(
        return_value=httpx.Response(200, json={"projects": [], "total": 0, "limit": 50, "offset": 0}),
    )
    with _pro_client(api_key) as client:
        assert client.list_projects().projects == []
    assert dict(route.calls.last.request.url.params) == {}


@respx.mock
def test_create_project_sync_accepts_mapping_body(api_key: str) -> None:
    route = respx.post(f"{PRO_URL}/v1/projects").mock(return_value=httpx.Response(201, json=PROJECT))
    with _pro_client(api_key) as client:
        project = client.create_project({"name": "Acme", "slug": "acme"})

    assert str(project.id) == PROJECT_ID
    assert project.name == "Acme"
    assert json.loads(route.calls.last.request.content) == {"name": "Acme", "slug": "acme"}


@respx.mock
def test_create_project_sync_accepts_generated_request_model(api_key: str) -> None:
    route = respx.post(f"{PRO_URL}/v1/projects").mock(return_value=httpx.Response(201, json=PROJECT))
    with _pro_client(api_key) as client:
        project = client.create_project(CreateProjectRequest(name="Acme", slug="acme"))

    assert project.slug == "acme"
    assert json.loads(route.calls.last.request.content) == {"name": "Acme", "slug": "acme"}


# -- API keys — sync -----------------------------------------------------------


@respx.mock
def test_list_api_keys_sync(api_key: str) -> None:
    route = respx.get(f"{PRO_URL}/v1/projects/{PROJECT_ID}/api-keys").mock(
        return_value=httpx.Response(200, json={"api_keys": [API_KEY_ENTRY], "total": 1, "limit": 10, "offset": 0}),
    )
    with _pro_client(api_key) as client:
        response = client.list_api_keys(PROJECT_ID, limit=10)

    assert response.total == 1
    assert [entry.key_prefix for entry in response.api_keys] == ["kz_live_abcd"]
    assert dict(route.calls.last.request.url.params) == {"limit": "10"}


@respx.mock
def test_create_api_key_sync_returns_plaintext_key_once(api_key: str) -> None:
    route = respx.post(f"{PRO_URL}/v1/projects/{PROJECT_ID}/api-keys").mock(
        return_value=httpx.Response(
            201,
            json={
                "id": KEY_ID,
                "key": "kz_live_abcdefghijklmnop",
                "key_prefix": "kz_live_abcd",
                "scope": "write",
                "created_at": "2026-05-01T09:00:00Z",
            },
        ),
    )
    with _pro_client(api_key) as client:
        created = client.create_api_key(PROJECT_ID, CreateApiKeyRequest(name="ci"))

    assert created.key == "kz_live_abcdefghijklmnop"
    assert created.key_prefix == "kz_live_abcd"
    assert json.loads(route.calls.last.request.content) == {"name": "ci"}


@respx.mock
def test_revoke_api_key_sync(api_key: str) -> None:
    route = respx.delete(f"{PRO_URL}/v1/projects/{PROJECT_ID}/api-keys/{KEY_ID}").mock(
        return_value=httpx.Response(204),
    )
    with _pro_client(api_key) as client:
        assert client.revoke_api_key(PROJECT_ID, KEY_ID) is None
    assert route.call_count == 1


# -- integrations — sync -------------------------------------------------------


@respx.mock
def test_list_integrations_sync(api_key: str) -> None:
    respx.get(f"{PRO_URL}/v1/projects/{PROJECT_ID}/integrations").mock(
        return_value=httpx.Response(200, json={"integrations": [INTEGRATION], "total": 1, "limit": 25, "offset": 0}),
    )
    with _pro_client(api_key) as client:
        response = client.list_integrations(PROJECT_ID)

    assert response.total == 1
    assert [integration.kind for integration in response.integrations] == ["google_drive"]


@respx.mock
def test_create_integration_sync(api_key: str) -> None:
    route = respx.post(f"{PRO_URL}/v1/projects/{PROJECT_ID}/integrations").mock(
        return_value=httpx.Response(201, json=INTEGRATION),
    )
    with _pro_client(api_key) as client:
        integration = client.create_integration(
            PROJECT_ID,
            {"name": "Team Drive", "kind": "google_drive", "auth_type": "oauth2"},
        )

    assert str(integration.id) == INTEGRATION_ID
    assert integration.provider == "google"
    assert json.loads(route.calls.last.request.content)["kind"] == "google_drive"


@respx.mock
def test_get_integration_sync(api_key: str) -> None:
    respx.get(f"{PRO_URL}/v1/projects/{PROJECT_ID}/integrations/{INTEGRATION_ID}").mock(
        return_value=httpx.Response(200, json=INTEGRATION),
    )
    with _pro_client(api_key) as client:
        assert client.get_integration(PROJECT_ID, INTEGRATION_ID).name == "Team Drive"


@respx.mock
def test_delete_integration_sync(api_key: str) -> None:
    route = respx.delete(f"{PRO_URL}/v1/projects/{PROJECT_ID}/integrations/{INTEGRATION_ID}").mock(
        return_value=httpx.Response(204),
    )
    with _pro_client(api_key) as client:
        assert client.delete_integration(PROJECT_ID, INTEGRATION_ID) is None
    assert route.call_count == 1


@respx.mock
def test_connect_integration_sync_returns_authorize_url(api_key: str) -> None:
    route = respx.post(f"{PRO_URL}/v1/projects/{PROJECT_ID}/integrations/{INTEGRATION_ID}/connect").mock(
        return_value=httpx.Response(200, json={"authorize_url": "https://accounts.google.com/o/oauth2/auth?x=1"}),
    )
    with _pro_client(api_key) as client:
        begun = client.connect_integration(PROJECT_ID, INTEGRATION_ID)

    assert begun.authorize_url == "https://accounts.google.com/o/oauth2/auth?x=1"
    assert route.call_count == 1


@respx.mock
def test_disconnect_integration_sync(api_key: str) -> None:
    route = respx.post(f"{PRO_URL}/v1/projects/{PROJECT_ID}/integrations/{INTEGRATION_ID}/disconnect").mock(
        return_value=httpx.Response(204),
    )
    with _pro_client(api_key) as client:
        assert client.disconnect_integration(PROJECT_ID, INTEGRATION_ID) is None
    assert route.call_count == 1


@respx.mock
def test_list_integration_documents_sync_forwards_filters(api_key: str) -> None:
    route = respx.get(f"{PRO_URL}/v1/projects/{PROJECT_ID}/integrations/{INTEGRATION_ID}/documents").mock(
        return_value=httpx.Response(
            200,
            json={
                "documents": [
                    {
                        "id": "drive-doc-1",
                        "name": "invoice.pdf",
                        "mime_type": "application/pdf",
                        "size_bytes": 4096,
                        "modified_at": "2026-05-03T12:00:00Z",
                    }
                ]
            },
        ),
    )
    with _pro_client(api_key) as client:
        response = client.list_integration_documents(
            PROJECT_ID,
            INTEGRATION_ID,
            mime_types="application/pdf",
            folder_id="folder-9",
            limit=50,
            offset=10,
        )

    assert [document.name for document in response.documents] == ["invoice.pdf"]
    assert response.documents[0].mime_type == "application/pdf"
    assert dict(route.calls.last.request.url.params) == {
        "mime_types": "application/pdf",
        "folder_id": "folder-9",
        "limit": "50",
        "offset": "10",
    }


@respx.mock
def test_fetch_integration_document_sync_returns_raw_bytes(api_key: str) -> None:
    respx.get(
        f"{PRO_URL}/v1/projects/{PROJECT_ID}/integrations/{INTEGRATION_ID}/documents/drive-doc-1",
    ).mock(
        return_value=httpx.Response(200, content=b"%PDF-1.7 drive bytes", headers={"Content-Type": "application/pdf"}),
    )
    with _pro_client(api_key) as client:
        assert client.fetch_integration_document(PROJECT_ID, INTEGRATION_ID, "drive-doc-1") == b"%PDF-1.7 drive bytes"


# -- tier gating ---------------------------------------------------------------


@pytest.mark.parametrize(
    ("method_name", "args"),
    [
        ("list_projects", ()),
        ("create_project", ({"name": "Acme"},)),
        ("list_api_keys", (PROJECT_ID,)),
        ("create_api_key", (PROJECT_ID, {"name": "ci"})),
        ("revoke_api_key", (PROJECT_ID, KEY_ID)),
        ("list_integrations", (PROJECT_ID,)),
        ("create_integration", (PROJECT_ID, {"name": "d", "kind": "google_drive", "auth_type": "oauth2"})),
        ("get_integration", (PROJECT_ID, INTEGRATION_ID)),
        ("delete_integration", (PROJECT_ID, INTEGRATION_ID)),
        ("connect_integration", (PROJECT_ID, INTEGRATION_ID)),
        ("disconnect_integration", (PROJECT_ID, INTEGRATION_ID)),
        ("list_integration_documents", (PROJECT_ID, INTEGRATION_ID)),
        ("fetch_integration_document", (PROJECT_ID, INTEGRATION_ID, "drive-doc-1")),
    ],
)
@respx.mock
def test_control_plane_method_rejected_on_enterprise(base_url: str, api_key: str, method_name, args) -> None:
    with (
        XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client,
        pytest.raises(XbergError, match=f"{method_name}\\(\\) is not available on the 'enterprise' tier"),
    ):
        getattr(client, method_name)(*args)


# -- projects — async ----------------------------------------------------------


@pytest.mark.asyncio
@respx.mock
async def test_list_projects_async(api_key: str) -> None:
    route = respx.get(f"{PRO_URL}/v1/projects").mock(
        return_value=httpx.Response(200, json={"projects": [PROJECT], "total": 1, "limit": 5, "offset": 10}),
    )
    async with _async_pro_client(api_key) as client:
        response = await client.list_projects(limit=5, offset=10)

    assert response.offset == 10
    assert [str(project.id) for project in response.projects] == [PROJECT_ID]
    assert dict(route.calls.last.request.url.params) == {"limit": "5", "offset": "10"}


@pytest.mark.asyncio
@respx.mock
async def test_create_project_async(api_key: str) -> None:
    route = respx.post(f"{PRO_URL}/v1/projects").mock(return_value=httpx.Response(201, json=PROJECT))
    async with _async_pro_client(api_key) as client:
        project = await client.create_project(CreateProjectRequest(name="Acme", slug="acme"))

    assert project.name == "Acme"
    assert json.loads(route.calls.last.request.content) == {"name": "Acme", "slug": "acme"}


# -- API keys — async ----------------------------------------------------------


@pytest.mark.asyncio
@respx.mock
async def test_list_api_keys_async(api_key: str) -> None:
    respx.get(f"{PRO_URL}/v1/projects/{PROJECT_ID}/api-keys").mock(
        return_value=httpx.Response(200, json={"api_keys": [API_KEY_ENTRY], "total": 1, "limit": 25, "offset": 0}),
    )
    async with _async_pro_client(api_key) as client:
        response = await client.list_api_keys(PROJECT_ID)

    assert response.api_keys[0].scope == "write"


@pytest.mark.asyncio
@respx.mock
async def test_create_api_key_async(api_key: str) -> None:
    route = respx.post(f"{PRO_URL}/v1/projects/{PROJECT_ID}/api-keys").mock(
        return_value=httpx.Response(
            201,
            json={
                "id": KEY_ID,
                "key": "kz_live_asyncsecret",
                "key_prefix": "kz_live_asyn",
                "scope": "read",
                "created_at": "2026-05-01T09:00:00Z",
            },
        ),
    )
    async with _async_pro_client(api_key) as client:
        created = await client.create_api_key(PROJECT_ID, {"name": "async-ci", "scope": "read"})

    assert created.key == "kz_live_asyncsecret"
    assert json.loads(route.calls.last.request.content) == {"name": "async-ci", "scope": "read"}


@pytest.mark.asyncio
@respx.mock
async def test_revoke_api_key_async(api_key: str) -> None:
    route = respx.delete(f"{PRO_URL}/v1/projects/{PROJECT_ID}/api-keys/{KEY_ID}").mock(
        return_value=httpx.Response(204),
    )
    async with _async_pro_client(api_key) as client:
        assert await client.revoke_api_key(PROJECT_ID, KEY_ID) is None
    assert route.call_count == 1


# -- integrations — async ------------------------------------------------------


@pytest.mark.asyncio
@respx.mock
async def test_list_integrations_async(api_key: str) -> None:
    respx.get(f"{PRO_URL}/v1/projects/{PROJECT_ID}/integrations").mock(
        return_value=httpx.Response(200, json={"integrations": [INTEGRATION], "total": 1, "limit": 25, "offset": 0}),
    )
    async with _async_pro_client(api_key) as client:
        response = await client.list_integrations(PROJECT_ID)

    assert response.integrations[0].auth_type == "oauth2"


@pytest.mark.asyncio
@respx.mock
async def test_create_integration_async(api_key: str) -> None:
    route = respx.post(f"{PRO_URL}/v1/projects/{PROJECT_ID}/integrations").mock(
        return_value=httpx.Response(201, json=INTEGRATION),
    )
    async with _async_pro_client(api_key) as client:
        integration = await client.create_integration(
            PROJECT_ID,
            {"name": "Team Drive", "kind": "google_drive", "auth_type": "oauth2"},
        )

    assert integration.name == "Team Drive"
    assert json.loads(route.calls.last.request.content)["auth_type"] == "oauth2"


@pytest.mark.asyncio
@respx.mock
async def test_get_integration_async(api_key: str) -> None:
    respx.get(f"{PRO_URL}/v1/projects/{PROJECT_ID}/integrations/{INTEGRATION_ID}").mock(
        return_value=httpx.Response(200, json=INTEGRATION),
    )
    async with _async_pro_client(api_key) as client:
        assert str((await client.get_integration(PROJECT_ID, INTEGRATION_ID)).id) == INTEGRATION_ID


@pytest.mark.asyncio
@respx.mock
async def test_delete_integration_async(api_key: str) -> None:
    route = respx.delete(f"{PRO_URL}/v1/projects/{PROJECT_ID}/integrations/{INTEGRATION_ID}").mock(
        return_value=httpx.Response(204),
    )
    async with _async_pro_client(api_key) as client:
        assert await client.delete_integration(PROJECT_ID, INTEGRATION_ID) is None
    assert route.call_count == 1


@pytest.mark.asyncio
@respx.mock
async def test_connect_integration_async(api_key: str) -> None:
    respx.post(f"{PRO_URL}/v1/projects/{PROJECT_ID}/integrations/{INTEGRATION_ID}/connect").mock(
        return_value=httpx.Response(200, json={"authorize_url": "https://accounts.google.com/o/oauth2/auth?x=2"}),
    )
    async with _async_pro_client(api_key) as client:
        begun = await client.connect_integration(PROJECT_ID, INTEGRATION_ID)

    assert begun.authorize_url.endswith("x=2")


@pytest.mark.asyncio
@respx.mock
async def test_disconnect_integration_async(api_key: str) -> None:
    route = respx.post(f"{PRO_URL}/v1/projects/{PROJECT_ID}/integrations/{INTEGRATION_ID}/disconnect").mock(
        return_value=httpx.Response(204),
    )
    async with _async_pro_client(api_key) as client:
        assert await client.disconnect_integration(PROJECT_ID, INTEGRATION_ID) is None
    assert route.call_count == 1


@pytest.mark.asyncio
@respx.mock
async def test_list_integration_documents_async(api_key: str) -> None:
    route = respx.get(f"{PRO_URL}/v1/projects/{PROJECT_ID}/integrations/{INTEGRATION_ID}/documents").mock(
        return_value=httpx.Response(
            200,
            json={"documents": [{"id": "drive-doc-2", "name": "contract.docx", "mime_type": "application/msword"}]},
        ),
    )
    async with _async_pro_client(api_key) as client:
        response = await client.list_integration_documents(PROJECT_ID, INTEGRATION_ID, limit=5)

    assert [document.id for document in response.documents] == ["drive-doc-2"]
    assert dict(route.calls.last.request.url.params) == {"limit": "5"}


@pytest.mark.asyncio
@respx.mock
async def test_fetch_integration_document_async(api_key: str) -> None:
    respx.get(
        f"{PRO_URL}/v1/projects/{PROJECT_ID}/integrations/{INTEGRATION_ID}/documents/drive-doc-2",
    ).mock(return_value=httpx.Response(200, content=b"async drive bytes"))
    async with _async_pro_client(api_key) as client:
        fetched = await client.fetch_integration_document(PROJECT_ID, INTEGRATION_ID, "drive-doc-2")

    assert fetched == b"async drive bytes"


@pytest.mark.asyncio
@respx.mock
async def test_control_plane_rejected_on_enterprise_async(base_url: str, api_key: str) -> None:
    async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        with pytest.raises(XbergError, match="list_projects\\(\\) is not available on the 'enterprise' tier"):
            await client.list_projects()
