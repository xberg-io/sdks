"""Coverage for the data-plane operations only ``spec/api/openapi.yaml`` declares, plus their neighbours.

The latest-document read and the extraction-event feed are absent from the Pro spec, so those
methods are gated to the ``enterprise`` tier and raise before touching the wire on Pro.
Enrichment and the rendered page image are NOT: both specs declare them, so they must reach
the wire on either tier. ``GET /v1/jobs/{id}/pages/{n}`` serves ``image/png`` and therefore
comes back as raw bytes rather than a decoded model.
"""

from __future__ import annotations

import json

import httpx
import pytest
import respx

from xberg_io_sdk import AsyncXbergClient, XbergClient, XbergError
from xberg_io_sdk._generated_api.models.enrich_job_status_type_0 import EnrichJobStatusType0
from xberg_io_sdk._generated_api.models.enrich_job_status_type_1 import EnrichJobStatusType1
from xberg_io_sdk._generated_api.models.enrich_job_status_type_2 import EnrichJobStatusType2
from xberg_io_sdk._generated_api.models.enrich_text_request import EnrichTextRequest

PRO_URL = "https://pro.example.test"
ENRICH_PATH = "/v1/enrich"
EXTRACTIONS_PATH = "/v1/extractions"
DOCUMENT_ID = "88888888-8888-8888-8888-888888888888"
ENRICH_JOB_ID = "99999999-9999-9999-9999-999999999999"
JOB_ID = "job-page-1"
PAGE_NUMBER = 3
PNG_BYTES = b"\x89PNG\r\n\x1a\n rendered page"

DOCUMENT = {"id": DOCUMENT_ID, "version": 4, "content": "# Invoice"}

EXTRACTION_EVENT = {
    "id": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
    "job_id": "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb",
    "preset_id": "invoice-v1",
    "preset_version": "1.0.0",
    "call_mode": "text_only",
    "outcome": "success",
    "page_count": 4,
    "vision_call_count": 0,
    "created_at": "2026-05-04T09:00:00Z",
    "total_cost_usd_cents": 12,
}


# -- enrichment — sync ---------------------------------------------------------


@respx.mock
def test_submit_enrich_sync(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}{ENRICH_PATH}").mock(
        return_value=httpx.Response(202, json={"job_id": ENRICH_JOB_ID}),
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        response = client.submit_enrich(EnrichTextRequest(text="Acme Corp invoiced 42 EUR."))

    assert str(response.job_id) == ENRICH_JOB_ID
    assert route.calls.last.request.method == "POST"
    assert route.calls.last.request.url.path == ENRICH_PATH
    assert json.loads(route.calls.last.request.content) == {"text": "Acme Corp invoiced 42 EUR."}


@respx.mock
def test_submit_enrich_sync_accepts_mapping_body(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}{ENRICH_PATH}").mock(
        return_value=httpx.Response(202, json={"job_id": ENRICH_JOB_ID}),
    )
    body = {"text": "hello", "options": {"keywords": True}}
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        assert str(client.submit_enrich(body).job_id) == ENRICH_JOB_ID

    assert json.loads(route.calls.last.request.content) == body


@respx.mock
def test_get_enrich_status_sync_parses_the_pending_variant(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}{ENRICH_PATH}/{ENRICH_JOB_ID}").mock(
        return_value=httpx.Response(200, json={"status": "pending"}),
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        status = client.get_enrich_status(ENRICH_JOB_ID)

    assert isinstance(status, EnrichJobStatusType0)
    assert status.status == "pending"
    assert route.calls.last.request.method == "GET"
    assert route.calls.last.request.url.path == f"{ENRICH_PATH}/{ENRICH_JOB_ID}"


@respx.mock
def test_get_enrich_status_sync_parses_the_completed_variant(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}{ENRICH_PATH}/{ENRICH_JOB_ID}").mock(
        return_value=httpx.Response(
            200,
            json={"status": "completed", "result": {"keywords": ["invoice", "acme"]}},
        ),
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        status = client.get_enrich_status(ENRICH_JOB_ID)

    assert isinstance(status, EnrichJobStatusType1)
    assert status.result.keywords == ["invoice", "acme"]


@respx.mock
def test_get_enrich_status_sync_parses_the_failed_variant(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}{ENRICH_PATH}/{ENRICH_JOB_ID}").mock(
        return_value=httpx.Response(200, json={"status": "failed", "error": "model unavailable"}),
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        status = client.get_enrich_status(ENRICH_JOB_ID)

    assert isinstance(status, EnrichJobStatusType2)
    assert status.error == "model unavailable"


@respx.mock
def test_get_enrich_status_sync_rejects_an_unknown_status(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}{ENRICH_PATH}/{ENRICH_JOB_ID}").mock(
        return_value=httpx.Response(200, json={"status": "sideways"}),
    )
    with (
        XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client,
        pytest.raises(XbergError, match="unexpected enrich status response shape"),
    ):
        client.get_enrich_status(ENRICH_JOB_ID)


# -- documents, extraction events, page images — sync --------------------------


@respx.mock
def test_get_document_sync_returns_the_decoded_body(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}/v1/documents/{DOCUMENT_ID}").mock(return_value=httpx.Response(200, json=DOCUMENT))
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        assert client.get_document(DOCUMENT_ID) == DOCUMENT

    assert route.calls.last.request.method == "GET"
    assert route.calls.last.request.url.path == f"/v1/documents/{DOCUMENT_ID}"


@respx.mock
def test_list_extraction_events_sync_forwards_days_and_pagination(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}{EXTRACTIONS_PATH}").mock(
        return_value=httpx.Response(200, json={"events": [EXTRACTION_EVENT], "total": 1, "limit": 50, "page": 1}),
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        response = client.list_extraction_events(days=7, limit=50, offset=0)

    assert response.total == 1
    assert response.events[0].outcome == "success"
    assert response.events[0].total_cost_usd_cents == 12
    assert route.calls.last.request.method == "GET"
    assert route.calls.last.request.url.path == EXTRACTIONS_PATH
    assert dict(route.calls.last.request.url.params) == {"days": "7", "limit": "50", "offset": "0"}


@respx.mock
def test_list_extraction_events_sync_omits_unset_params(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}{EXTRACTIONS_PATH}").mock(
        return_value=httpx.Response(200, json={"events": [], "total": 0, "limit": 50, "page": 1}),
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        assert client.list_extraction_events().events == []

    assert dict(route.calls.last.request.url.params) == {}


@respx.mock
def test_get_job_page_sync_returns_raw_png_bytes(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}/v1/jobs/{JOB_ID}/pages/{PAGE_NUMBER}").mock(
        return_value=httpx.Response(200, content=PNG_BYTES, headers={"Content-Type": "image/png"}),
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        assert client.get_job_page(JOB_ID, PAGE_NUMBER) == PNG_BYTES

    assert route.calls.last.request.method == "GET"
    assert route.calls.last.request.url.path == f"/v1/jobs/{JOB_ID}/pages/{PAGE_NUMBER}"


# -- tier gating ---------------------------------------------------------------


@pytest.mark.parametrize(
    ("method_name", "args"),
    [
        ("get_document", (DOCUMENT_ID,)),
        ("list_extraction_events", ()),
    ],
)
def test_enterprise_only_methods_are_rejected_on_pro(api_key: str, method_name: str, args: tuple[object, ...]) -> None:
    with (
        XbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client,
        pytest.raises(XbergError, match="not available on the 'pro' tier"),
    ):
        getattr(client, method_name)(*args)


@respx.mock
def test_submit_enrich_reaches_the_wire_on_pro(api_key: str) -> None:
    # `POST /v1/enrich` is in the Pro spec; the client used to refuse it before any request.
    route = respx.post(f"{PRO_URL}{ENRICH_PATH}").mock(
        return_value=httpx.Response(202, json={"job_id": ENRICH_JOB_ID}),
    )
    with XbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        assert str(client.submit_enrich({"text": "hi"}).job_id) == ENRICH_JOB_ID

    assert route.call_count == 1


@respx.mock
def test_get_enrich_status_reaches_the_wire_on_pro(api_key: str) -> None:
    route = respx.get(f"{PRO_URL}{ENRICH_PATH}/{ENRICH_JOB_ID}").mock(
        return_value=httpx.Response(200, json={"status": "pending"}),
    )
    with XbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        assert isinstance(client.get_enrich_status(ENRICH_JOB_ID), EnrichJobStatusType0)

    assert route.call_count == 1


@respx.mock
def test_get_job_page_reaches_the_wire_on_pro(api_key: str) -> None:
    route = respx.get(f"{PRO_URL}/v1/jobs/{JOB_ID}/pages/{PAGE_NUMBER}").mock(
        return_value=httpx.Response(200, content=PNG_BYTES, headers={"Content-Type": "image/png"}),
    )
    with XbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        assert client.get_job_page(JOB_ID, PAGE_NUMBER) == PNG_BYTES

    assert route.call_count == 1


# -- enrichment, documents, events, page images — async ------------------------


@pytest.mark.asyncio
@respx.mock
async def test_submit_enrich_async(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}{ENRICH_PATH}").mock(
        return_value=httpx.Response(202, json={"job_id": ENRICH_JOB_ID}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        response = await client.submit_enrich({"text": "async text"})

    assert str(response.job_id) == ENRICH_JOB_ID
    assert route.calls.last.request.method == "POST"
    assert route.calls.last.request.url.path == ENRICH_PATH


@pytest.mark.asyncio
@respx.mock
async def test_get_enrich_status_async(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}{ENRICH_PATH}/{ENRICH_JOB_ID}").mock(
        return_value=httpx.Response(200, json={"status": "completed", "result": {"labels": ["invoice"]}}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        status = await client.get_enrich_status(ENRICH_JOB_ID)

    assert isinstance(status, EnrichJobStatusType1)
    assert status.result.labels == ["invoice"]
    assert route.calls.last.request.url.path == f"{ENRICH_PATH}/{ENRICH_JOB_ID}"


@pytest.mark.asyncio
@respx.mock
async def test_get_document_async(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}/v1/documents/{DOCUMENT_ID}").mock(return_value=httpx.Response(200, json=DOCUMENT))
    async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        assert await client.get_document(DOCUMENT_ID) == DOCUMENT

    assert route.calls.last.request.url.path == f"/v1/documents/{DOCUMENT_ID}"


@pytest.mark.asyncio
@respx.mock
async def test_list_extraction_events_async(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}{EXTRACTIONS_PATH}").mock(
        return_value=httpx.Response(200, json={"events": [EXTRACTION_EVENT], "total": 1, "limit": 10, "page": 2}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        response = await client.list_extraction_events(days=30)

    assert response.page == 2
    assert response.events[0].preset_id == "invoice-v1"
    assert route.calls.last.request.url.path == EXTRACTIONS_PATH
    assert dict(route.calls.last.request.url.params) == {"days": "30"}


@pytest.mark.asyncio
@respx.mock
async def test_get_job_page_async_returns_raw_png_bytes(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}/v1/jobs/{JOB_ID}/pages/{PAGE_NUMBER}").mock(
        return_value=httpx.Response(200, content=PNG_BYTES, headers={"Content-Type": "image/png"}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        assert await client.get_job_page(JOB_ID, PAGE_NUMBER) == PNG_BYTES

    assert route.calls.last.request.method == "GET"
    assert route.calls.last.request.url.path == f"/v1/jobs/{JOB_ID}/pages/{PAGE_NUMBER}"


@pytest.mark.asyncio
async def test_enterprise_only_methods_are_rejected_on_pro_async(api_key: str) -> None:
    async with AsyncXbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        with pytest.raises(XbergError, match="not available on the 'pro' tier"):
            await client.get_document(DOCUMENT_ID)
        with pytest.raises(XbergError, match="not available on the 'pro' tier"):
            await client.list_extraction_events()


@pytest.mark.asyncio
@respx.mock
async def test_shared_operations_reach_the_wire_on_pro_async(api_key: str) -> None:
    enrich = respx.post(f"{PRO_URL}{ENRICH_PATH}").mock(
        return_value=httpx.Response(202, json={"job_id": ENRICH_JOB_ID}),
    )
    page = respx.get(f"{PRO_URL}/v1/jobs/{JOB_ID}/pages/{PAGE_NUMBER}").mock(
        return_value=httpx.Response(200, content=PNG_BYTES, headers={"Content-Type": "image/png"}),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        assert str((await client.submit_enrich({"text": "hi"})).job_id) == ENRICH_JOB_ID
        assert await client.get_job_page(JOB_ID, PAGE_NUMBER) == PNG_BYTES

    assert enrich.call_count == 1
    assert page.call_count == 1


# -- GET /v1/webhooks/{id}/deliveries[/{delivery_id}] --------------------------


WEBHOOK_ID = "cccccccc-cccc-cccc-cccc-cccccccccccc"
DELIVERY_ID = "dddddddd-dddd-dddd-dddd-dddddddddddd"

DELIVERY = {
    "id": DELIVERY_ID,
    "event_id": "eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee",
    "event_type": "job.completed",
    "job_id": JOB_ID,
    "attempt_number": 2,
    "success": False,
    "duration_ms": 431,
    "occurred_at": "2026-05-09T10:00:00Z",
    "status_code": 503,
    "error": "endpoint unavailable",
}

DELIVERY_LIST = {"deliveries": [DELIVERY], "total": 1, "limit": 100, "offset": 0}

DELIVERY_DETAIL = {
    "delivery": DELIVERY,
    "request_preview": '{"job_id":"job-page-1"}',
    "request_truncated": False,
    "response_preview": "service unavailable",
    "response_truncated": True,
}


@respx.mock
def test_list_subscription_deliveries_sync_forwards_pagination(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}/v1/webhooks/{WEBHOOK_ID}/deliveries").mock(
        return_value=httpx.Response(200, json=DELIVERY_LIST),
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        response = client.list_subscription_deliveries(WEBHOOK_ID, limit=100, offset=0)

    assert response.total == 1
    assert str(response.deliveries[0].id) == DELIVERY_ID
    assert response.deliveries[0].attempt_number == 2
    assert response.deliveries[0].success is False
    assert route.calls.last.request.method == "GET"
    assert route.calls.last.request.url.path == f"/v1/webhooks/{WEBHOOK_ID}/deliveries"
    assert dict(route.calls.last.request.url.params) == {"limit": "100", "offset": "0"}


@respx.mock
def test_list_subscription_deliveries_sync_omits_unset_pagination(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}/v1/webhooks/{WEBHOOK_ID}/deliveries").mock(
        return_value=httpx.Response(200, json=DELIVERY_LIST),
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        client.list_subscription_deliveries(WEBHOOK_ID)

    assert dict(route.calls.last.request.url.params) == {}


@respx.mock
def test_get_subscription_delivery_sync(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}/v1/webhooks/{WEBHOOK_ID}/deliveries/{DELIVERY_ID}").mock(
        return_value=httpx.Response(200, json=DELIVERY_DETAIL),
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        detail = client.get_subscription_delivery(WEBHOOK_ID, DELIVERY_ID)

    assert detail.request_preview == '{"job_id":"job-page-1"}'
    assert detail.response_truncated is True
    assert str(detail.delivery.id) == DELIVERY_ID
    assert route.calls.last.request.url.path == f"/v1/webhooks/{WEBHOOK_ID}/deliveries/{DELIVERY_ID}"


@pytest.mark.parametrize(
    ("method_name", "args"),
    [
        ("list_subscription_deliveries", (WEBHOOK_ID,)),
        ("get_subscription_delivery", (WEBHOOK_ID, DELIVERY_ID)),
    ],
)
def test_subscription_delivery_reads_are_rejected_on_pro(
    api_key: str, method_name: str, args: tuple[object, ...]
) -> None:
    with (
        XbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client,
        pytest.raises(XbergError, match="not available on the 'pro' tier"),
    ):
        getattr(client, method_name)(*args)


@pytest.mark.asyncio
@respx.mock
async def test_subscription_delivery_reads_async(base_url: str, api_key: str) -> None:
    listing = respx.get(f"{base_url}/v1/webhooks/{WEBHOOK_ID}/deliveries").mock(
        return_value=httpx.Response(200, json=DELIVERY_LIST),
    )
    detail = respx.get(f"{base_url}/v1/webhooks/{WEBHOOK_ID}/deliveries/{DELIVERY_ID}").mock(
        return_value=httpx.Response(200, json=DELIVERY_DETAIL),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        assert (await client.list_subscription_deliveries(WEBHOOK_ID, limit=5)).limit == 100
        assert (await client.get_subscription_delivery(WEBHOOK_ID, DELIVERY_ID)).delivery.status_code == 503

    assert dict(listing.calls.last.request.url.params) == {"limit": "5"}
    assert detail.call_count == 1


@pytest.mark.asyncio
async def test_subscription_delivery_reads_are_rejected_on_pro_async(api_key: str) -> None:
    async with AsyncXbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        with pytest.raises(XbergError, match="not available on the 'pro' tier"):
            await client.list_subscription_deliveries(WEBHOOK_ID)
        with pytest.raises(XbergError, match="not available on the 'pro' tier"):
            await client.get_subscription_delivery(WEBHOOK_ID, DELIVERY_ID)
