"""Exercise the data-plane operations added with the latest OpenAPI sync."""

from __future__ import annotations

import json
from typing import TYPE_CHECKING, Any

import httpx
import pytest
import respx

from xberg_io_sdk import AsyncXbergClient, XbergClient

if TYPE_CHECKING:
    from xberg_io_sdk.client import Target

PROJECT = "11111111-1111-4111-8111-111111111111"
CURSOR = "22222222-2222-4222-8222-222222222222"
COLLECTION = "33333333-3333-4333-8333-333333333333"


@pytest.mark.parametrize("asynchronous", [False, True])
@pytest.mark.parametrize("target", ["enterprise", "pro"])
@respx.mock
async def test_list_rag_documents_uses_cursor_and_pro_project_header(
    base_url: str, target: Target, asynchronous: bool
) -> None:
    response = {"documents": [], "limit": 15, "next_cursor": CURSOR}
    route = respx.get(f"{base_url}/v1/rag/collections/reports%2F2026/documents").respond(200, json=response)
    kwargs = {"limit": 15, "cursor": CURSOR, "project_id": PROJECT if target == "pro" else None}
    if asynchronous:
        async with AsyncXbergClient(base_url=base_url, target=target) as client:
            result = await client.list_rag_documents("reports/2026", **kwargs)
    else:
        with XbergClient(base_url=base_url, target=target) as sync_client:
            result = sync_client.list_rag_documents("reports/2026", **kwargs)

    assert result.to_dict() == response
    assert route.call_count == 1
    request = route.calls.last.request
    assert request.url.raw_path.split(b"?", maxsplit=1)[0] == b"/v1/rag/collections/reports%2F2026/documents"
    assert request.url.params == httpx.QueryParams({"limit": "15", "cursor": CURSOR})
    assert request.headers.get("X-Project-ID") == (PROJECT if target == "pro" else None)


@pytest.mark.parametrize("asynchronous", [False, True])
@respx.mock
async def test_job_page_inventory_preserves_sparse_pages(base_url: str, asynchronous: bool) -> None:
    route = respx.get(f"{base_url}/v1/jobs/job%2Fid/pages").respond(200, json={"pages": [1, 4]})
    if asynchronous:
        async with AsyncXbergClient(base_url=base_url, target="pro") as client:
            inventory = await client.get_job_page_inventory("job/id", project_id=PROJECT)
    else:
        with XbergClient(base_url=base_url, target="pro") as sync_client:
            inventory = sync_client.get_job_page_inventory("job/id", project_id=PROJECT)

    assert inventory.pages == [1, 4]
    assert route.call_count == 1
    assert route.calls.last.request.url.params == httpx.QueryParams({"project_id": PROJECT})


@pytest.mark.parametrize("asynchronous", [False, True])
@respx.mock
async def test_bind_integration_rag_target_sends_collection_and_handles_empty_success(
    base_url: str, asynchronous: bool
) -> None:
    route = respx.put(f"{base_url}/v1/projects/{PROJECT}/integrations/s3%2Fid/sync/rag-target").respond(204)
    body: dict[str, Any] = {"collection_id": COLLECTION}
    if asynchronous:
        async with AsyncXbergClient(base_url=base_url, target="pro") as client:
            await client.bind_integration_rag_target(PROJECT, "s3/id", body)
    else:
        with XbergClient(base_url=base_url, target="pro") as sync_client:
            sync_client.bind_integration_rag_target(PROJECT, "s3/id", body)

    assert route.call_count == 1
    assert json.loads(route.calls.last.request.content) == body
