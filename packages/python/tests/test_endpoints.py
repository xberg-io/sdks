"""Coverage for the thin RAG / Pro-only / Enterprise-only endpoint passthroughs.

Every method here just forwards to ``_request_json`` with a fixed path/verb; the
behavior worth asserting is: the right HTTP verb/path is hit, request bodies and
params are forwarded untouched, and the decoded JSON response comes back as-is.
"""

from __future__ import annotations

import json

import httpx
import pytest
import respx

from xberg_io_sdk import AsyncXbergClient, XbergClient

PRO_URL = "https://pro.example.test"


# -- RAG surface (shared, no tier requirement) — sync --------------------------


@respx.mock
def test_create_rag_collection_sync_sends_body(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}/v1/rag/collections").mock(
        return_value=httpx.Response(201, json={"name": "docs"}),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        result = client.create_rag_collection({"name": "docs"})
    assert result == {"name": "docs"}
    assert json.loads(route.calls.last.request.content) == {"name": "docs"}


@respx.mock
def test_get_rag_collection_sync(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}/v1/rag/collections/docs").mock(
        return_value=httpx.Response(200, json={"name": "docs", "count": 3}),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        assert client.get_rag_collection("docs") == {"name": "docs", "count": 3}


@respx.mock
def test_delete_rag_collection_sync_returns_none_on_204(base_url: str, api_key: str) -> None:
    route = respx.delete(f"{base_url}/v1/rag/collections/docs").mock(return_value=httpx.Response(204))
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        assert client.delete_rag_collection("docs") is None
    assert route.called


@respx.mock
def test_delete_rag_documents_sync_sends_body(base_url: str, api_key: str) -> None:
    route = respx.delete(f"{base_url}/v1/rag/collections/docs/documents").mock(
        return_value=httpx.Response(200, json={"deleted_count": 2}),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        result = client.delete_rag_documents("docs", {"ids": ["a", "b"]})
    assert result == {"deleted_count": 2}
    assert json.loads(route.calls.last.request.content) == {"ids": ["a", "b"]}


def test_rag_document_listing_method_does_not_exist() -> None:
    # Neither spec declares GET /v1/rag/collections/{name}/documents — only POST and DELETE.
    assert not hasattr(XbergClient, "list_rag_documents")
    assert not hasattr(AsyncXbergClient, "list_rag_documents")


@respx.mock
def test_add_rag_documents_sync_sends_body(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}/v1/rag/collections/docs/documents").mock(
        return_value=httpx.Response(202, json={"accepted": 2}),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        result = client.add_rag_documents("docs", {"documents": [{"id": "1"}, {"id": "2"}]})
    assert result == {"accepted": 2}
    assert b'"id":"1"' in route.calls.last.request.content


@respx.mock
def test_reindex_rag_document_sync_without_body(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}/v1/rag/collections/docs/documents/doc-1/reindex").mock(
        return_value=httpx.Response(202, json={"job_id": "reindex-1"}),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        result = client.reindex_rag_document("docs", "doc-1")
    assert result == {"job_id": "reindex-1"}
    assert route.calls.last.request.content == b""


@respx.mock
def test_reindex_rag_document_sync_with_body(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}/v1/rag/collections/docs/documents/doc-1/reindex").mock(
        return_value=httpx.Response(202, json={"job_id": "reindex-2"}),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        client.reindex_rag_document("docs", "doc-1", {"force": True})
    assert json.loads(route.calls.last.request.content) == {"force": True}


@respx.mock
def test_rag_retrieve_sync_sends_body(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}/v1/rag/collections/docs/retrieve").mock(
        return_value=httpx.Response(200, json={"chunks": []}),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        result = client.rag_retrieve("docs", {"query": "invoices", "top_k": 5})
    assert result == {"chunks": []}
    assert b'"query":"invoices"' in route.calls.last.request.content


@respx.mock
def test_migrate_rag_embeddings_sync_sends_body(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}/v1/rag/collections/docs/migrate-embeddings").mock(
        return_value=httpx.Response(202, json={"job_id": "migrate-1"}),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        result = client.migrate_rag_embeddings("docs", {"model": "text-embedding-3"})
    assert result == {"job_id": "migrate-1"}
    assert b"text-embedding-3" in route.calls.last.request.content


@respx.mock
def test_get_rag_migration_job_sync(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}/v1/rag/collections/docs/migrate-embeddings/migrate-1").mock(
        return_value=httpx.Response(200, json={"status": "completed"}),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        assert client.get_rag_migration_job("docs", "migrate-1") == {"status": "completed"}


@respx.mock
def test_get_rag_job_sync(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}/v1/rag/jobs/aaaaaaaa-0000-4000-8000-000000000001").mock(
        return_value=httpx.Response(200, json={"status": "processing"}),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        assert client.get_rag_job("aaaaaaaa-0000-4000-8000-000000000001") == {"status": "processing"}


# -- Pro-only surface — sync ----------------------------------------------------


@respx.mock
def test_auth_config_sync_on_pro(api_key: str) -> None:
    respx.get(f"{PRO_URL}/auth/config").mock(
        return_value=httpx.Response(200, json={"methods": ["oidc"]}),
    )
    with XbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        assert client.auth_config() == {"methods": ["oidc"]}


@respx.mock
def test_get_rag_config_sync_on_pro(api_key: str) -> None:
    respx.get(f"{PRO_URL}/v1/projects/proj-1/rag-config").mock(
        return_value=httpx.Response(200, json={"top_k": 10}),
    )
    with XbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        assert client.get_rag_config("proj-1") == {"top_k": 10}


@respx.mock
def test_set_rag_config_sync_on_pro(api_key: str) -> None:
    route = respx.put(f"{PRO_URL}/v1/projects/proj-1/rag-config").mock(
        return_value=httpx.Response(200, json={"top_k": 20}),
    )
    with XbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        result = client.set_rag_config("proj-1", {"top_k": 20})
    assert result == {"top_k": 20}
    assert json.loads(route.calls.last.request.content) == {"top_k": 20}


# -- Enterprise-only surface — sync ---------------------------------------------


@respx.mock
def test_versions_sync_on_enterprise(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}/v1/documents/doc-1/versions").mock(
        return_value=httpx.Response(200, json={"versions": [1, 2]}),
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        assert client.versions("doc-1") == {"versions": [1, 2]}


@respx.mock
def test_diff_sync_on_enterprise_forwards_params(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}/v1/documents/doc-1/diff").mock(
        return_value=httpx.Response(200, json={"changes": []}),
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        result = client.diff("doc-1", params={"from": "1", "to": "2"})
    assert result == {"changes": []}
    assert dict(route.calls.last.request.url.params) == {"from": "1", "to": "2"}


@respx.mock
def test_get_diff_job_sync_on_enterprise(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}/v1/documents/doc-1/diff/diff-job-1").mock(
        return_value=httpx.Response(200, json={"status": "completed"}),
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        assert client.get_diff_job("doc-1", "diff-job-1") == {"status": "completed"}


@respx.mock
def test_presign_upload_sync_on_enterprise(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}/v1/uploads/presign").mock(
        return_value=httpx.Response(200, json={"url": "https://upload.example/put"}),
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        result = client.presign_upload({"filename": "a.pdf"})
    assert result == {"url": "https://upload.example/put"}
    assert json.loads(route.calls.last.request.content) == {"filename": "a.pdf"}


@respx.mock
def test_confirm_upload_sync_on_enterprise(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}/v1/uploads/confirm").mock(
        return_value=httpx.Response(200, json={"confirmed": True}),
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        result = client.confirm_upload({"upload_id": "upload-1"})
    assert result == {"confirmed": True}
    assert json.loads(route.calls.last.request.content) == {"upload_id": "upload-1"}


# -- RAG surface — async --------------------------------------------------------


@pytest.mark.asyncio
@respx.mock
async def test_create_rag_collection_async_sends_body(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}/v1/rag/collections").mock(
        return_value=httpx.Response(201, json={"name": "docs"}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        result = await client.create_rag_collection({"name": "docs"})
    assert result == {"name": "docs"}
    assert json.loads(route.calls.last.request.content) == {"name": "docs"}


@pytest.mark.asyncio
@respx.mock
async def test_get_rag_collection_async(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}/v1/rag/collections/docs").mock(
        return_value=httpx.Response(200, json={"name": "docs"}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        assert await client.get_rag_collection("docs") == {"name": "docs"}


@pytest.mark.asyncio
@respx.mock
async def test_delete_rag_collection_async_returns_none_on_204(base_url: str, api_key: str) -> None:
    respx.delete(f"{base_url}/v1/rag/collections/docs").mock(return_value=httpx.Response(204))
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        assert await client.delete_rag_collection("docs") is None


@pytest.mark.asyncio
@respx.mock
async def test_delete_rag_documents_async_sends_body(base_url: str, api_key: str) -> None:
    route = respx.delete(f"{base_url}/v1/rag/collections/docs/documents").mock(
        return_value=httpx.Response(200, json={"deleted_count": 1}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        result = await client.delete_rag_documents("docs", {"filter": {"tag": "stale"}})
    assert result == {"deleted_count": 1}
    assert json.loads(route.calls.last.request.content) == {"filter": {"tag": "stale"}}


@pytest.mark.asyncio
@respx.mock
async def test_add_rag_documents_async_sends_body(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}/v1/rag/collections/docs/documents").mock(
        return_value=httpx.Response(202, json={"accepted": 1}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        result = await client.add_rag_documents("docs", {"documents": [{"id": "1"}]})
    assert result == {"accepted": 1}
    assert b'"id":"1"' in route.calls.last.request.content


@pytest.mark.asyncio
@respx.mock
async def test_reindex_rag_document_async_with_body(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}/v1/rag/collections/docs/documents/doc-1/reindex").mock(
        return_value=httpx.Response(202, json={"job_id": "reindex-async"}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        result = await client.reindex_rag_document("docs", "doc-1", {"force": True})
    assert result == {"job_id": "reindex-async"}
    assert json.loads(route.calls.last.request.content) == {"force": True}


@pytest.mark.asyncio
@respx.mock
async def test_rag_retrieve_async_sends_body(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}/v1/rag/collections/docs/retrieve").mock(
        return_value=httpx.Response(200, json={"chunks": ["c1"]}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        result = await client.rag_retrieve("docs", {"query": "q"})
    assert result == {"chunks": ["c1"]}
    assert b'"query":"q"' in route.calls.last.request.content


@pytest.mark.asyncio
@respx.mock
async def test_migrate_rag_embeddings_async_sends_body(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}/v1/rag/collections/docs/migrate-embeddings").mock(
        return_value=httpx.Response(202, json={"job_id": "migrate-async"}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        result = await client.migrate_rag_embeddings("docs", {"model": "m"})
    assert result == {"job_id": "migrate-async"}
    assert json.loads(route.calls.last.request.content) == {"model": "m"}


@pytest.mark.asyncio
@respx.mock
async def test_get_rag_migration_job_async(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}/v1/rag/collections/docs/migrate-embeddings/migrate-1").mock(
        return_value=httpx.Response(200, json={"status": "completed"}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        assert await client.get_rag_migration_job("docs", "migrate-1") == {"status": "completed"}


@pytest.mark.asyncio
@respx.mock
async def test_get_rag_job_async(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}/v1/rag/jobs/aaaaaaaa-0000-4000-8000-000000000001").mock(
        return_value=httpx.Response(200, json={"status": "pending"}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        assert await client.get_rag_job("aaaaaaaa-0000-4000-8000-000000000001") == {"status": "pending"}


# -- Pro-only surface — async ----------------------------------------------------


@pytest.mark.asyncio
@respx.mock
async def test_auth_config_async_on_pro(api_key: str) -> None:
    respx.get(f"{PRO_URL}/auth/config").mock(
        return_value=httpx.Response(200, json={"methods": ["oidc"]}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        assert await client.auth_config() == {"methods": ["oidc"]}


@pytest.mark.asyncio
@respx.mock
async def test_login_async_on_pro(api_key: str) -> None:
    route = respx.post(f"{PRO_URL}/auth/login").mock(
        return_value=httpx.Response(200, json={"token": "async-session-jwt"}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        result = await client.login({"id_token": "verified"})
    assert result == {"token": "async-session-jwt"}
    assert json.loads(route.calls.last.request.content) == {"id_token": "verified"}


@pytest.mark.asyncio
@respx.mock
async def test_get_rag_config_async_on_pro(api_key: str) -> None:
    respx.get(f"{PRO_URL}/v1/projects/proj-1/rag-config").mock(
        return_value=httpx.Response(200, json={"top_k": 10}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        assert await client.get_rag_config("proj-1") == {"top_k": 10}


@pytest.mark.asyncio
@respx.mock
async def test_set_rag_config_async_on_pro(api_key: str) -> None:
    route = respx.put(f"{PRO_URL}/v1/projects/proj-1/rag-config").mock(
        return_value=httpx.Response(200, json={"top_k": 30}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        result = await client.set_rag_config("proj-1", {"top_k": 30})
    assert result == {"top_k": 30}
    assert json.loads(route.calls.last.request.content) == {"top_k": 30}


# -- Enterprise-only surface — async ---------------------------------------------


@pytest.mark.asyncio
@respx.mock
async def test_versions_async_on_enterprise(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}/v1/documents/doc-1/versions").mock(
        return_value=httpx.Response(200, json={"versions": [1]}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        assert await client.versions("doc-1") == {"versions": [1]}


@pytest.mark.asyncio
@respx.mock
async def test_diff_async_on_enterprise_forwards_params(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}/v1/documents/doc-1/diff").mock(
        return_value=httpx.Response(200, json={"changes": ["c1"]}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        result = await client.diff("doc-1", params={"from": "1"})
    assert result == {"changes": ["c1"]}
    assert dict(route.calls.last.request.url.params) == {"from": "1"}


@pytest.mark.asyncio
@respx.mock
async def test_get_diff_job_async_on_enterprise(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}/v1/documents/doc-1/diff/diff-job-1").mock(
        return_value=httpx.Response(200, json={"status": "completed"}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        assert await client.get_diff_job("doc-1", "diff-job-1") == {"status": "completed"}


@pytest.mark.asyncio
@respx.mock
async def test_presign_upload_async_on_enterprise(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}/v1/uploads/presign").mock(
        return_value=httpx.Response(200, json={"url": "https://upload.example/async"}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        result = await client.presign_upload({"filename": "b.pdf"})
    assert result == {"url": "https://upload.example/async"}
    assert json.loads(route.calls.last.request.content) == {"filename": "b.pdf"}


@pytest.mark.asyncio
@respx.mock
async def test_confirm_upload_async_on_enterprise(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}/v1/uploads/confirm").mock(
        return_value=httpx.Response(200, json={"confirmed": True}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        result = await client.confirm_upload({"upload_id": "upload-async"})
    assert result == {"confirmed": True}
    assert json.loads(route.calls.last.request.content) == {"upload_id": "upload-async"}


@pytest.mark.asyncio
@respx.mock
async def test_usage_async_on_enterprise_forwards_params(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}/v1/usage").mock(
        return_value=httpx.Response(200, json={"pages": 99}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        result = await client.usage(params={"from": "2026-01-01"})
    assert result == {"pages": 99}
    assert dict(route.calls.last.request.url.params) == {"from": "2026-01-01"}


@pytest.mark.asyncio
@respx.mock
async def test_pro_only_method_rejected_on_enterprise_async(base_url: str, api_key: str) -> None:
    async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        with pytest.raises(Exception, match="not available on the 'enterprise' tier"):
            await client.login({"id_token": "x"})


@pytest.mark.asyncio
@respx.mock
async def test_capability_probe_async_reads_healthz_tier_and_caches(base_url: str, api_key: str) -> None:
    # `versions` is still Enterprise-only, so it is what forces the probe; `usage` no longer is.
    health = respx.get(f"{base_url}/healthz").mock(
        return_value=httpx.Response(200, json={"status": "ok", "tier": "enterprise"}),
    )
    respx.get(f"{base_url}/v1/documents/doc-1/versions").mock(
        return_value=httpx.Response(200, json={"versions": [1, 2]}),
    )

    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        assert await client.versions("doc-1") == {"versions": [1, 2]}
        assert await client.versions("doc-1") == {"versions": [1, 2]}

    assert health.call_count == 1
