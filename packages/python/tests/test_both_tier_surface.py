"""Coverage for operations both specs declare, which must therefore carry no tier gate.

``GET /v1/jobs/{id}/result`` and the three ``GET /v1/presets*`` routes appear in
``spec/api/openapi.yaml`` and ``spec/pro/openapi.yaml`` alike. Each test below runs the
same call against ``target="enterprise"`` and ``target="pro"``, and the ones that omit
``target`` entirely double as proof that no capability probe fires: ``respx`` fails any
request to an unmocked route, so a stray ``GET /healthz`` would break the test.
"""

from __future__ import annotations

import httpx
import pytest
import respx

from tests.conftest import (
    make_extraction_result,
    make_job_result_payload,
    make_preset_detail,
    make_preset_summary,
)
from xberg_io_sdk import AsyncXbergClient, JobResult, XbergClient, XbergError
from xberg_io_sdk._generated_api.models.preset_detail import PresetDetail
from xberg_io_sdk._generated_api.models.preset_summary import PresetSummary

PRO_URL = "https://pro.example.test"


# -- GET /v1/jobs/{id}/result -> JobResult  ~keep


@respx.mock
def test_get_job_result_parses_into_job_result_shape(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}/v1/jobs/aaaaaaaa-0000-4000-8000-000000000001/result").mock(
        return_value=httpx.Response(
            200,
            json=make_job_result_payload(
                job_id="aaaaaaaa-0000-4000-8000-000000000001",
                status="partial_success",
                results=[make_extraction_result(content="page one"), make_extraction_result(content="page two")],
                child_job_ids=["aaaaaaaa-0000-4000-8000-00000000000a"],
                errors=[
                    {
                        "error_type": "unsupported_mime_type",
                        "message": "cannot parse application/x-weird",
                        "code": 415,
                        "index": 2,
                        "source": "extractor",
                    }
                ],
            ),
        ),
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        result = client.get_job_result("aaaaaaaa-0000-4000-8000-000000000001")

    assert isinstance(result, JobResult)
    assert str(result.job_id) == "aaaaaaaa-0000-4000-8000-000000000001"
    assert result.status == "partial_success"
    assert result.completed_at == "2026-05-09T10:05:00Z"
    assert [str(j) for j in result.child_job_ids] == ["aaaaaaaa-0000-4000-8000-00000000000a"]
    assert [document.content for document in result.results] == ["page one", "page two"]
    assert len(result.errors) == 1
    assert result.errors[0].error_type == "unsupported_mime_type"
    assert result.errors[0].message == "cannot parse application/x-weird"
    assert result.errors[0].code == 415
    assert result.errors[0].index == 2
    assert result.errors[0].source == "extractor"


@respx.mock
def test_get_job_result_on_pro_is_not_gated(api_key: str) -> None:
    respx.get(f"{PRO_URL}/v1/jobs/aaaaaaaa-0000-4000-8000-000000000002/result").mock(
        return_value=httpx.Response(200, json=make_job_result_payload(job_id="aaaaaaaa-0000-4000-8000-000000000002")),
    )
    with XbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        result = client.get_job_result("aaaaaaaa-0000-4000-8000-000000000002")

    assert str(result.job_id) == "aaaaaaaa-0000-4000-8000-000000000002"
    assert result.status == "completed"
    assert len(result.results) == 1


@respx.mock
def test_get_job_result_without_target_does_not_probe_healthz(base_url: str, api_key: str) -> None:
    result_route = respx.get(f"{base_url}/v1/jobs/aaaaaaaa-0000-4000-8000-000000000003/result").mock(
        return_value=httpx.Response(200, json=make_job_result_payload(job_id="aaaaaaaa-0000-4000-8000-000000000003")),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        assert (
            str(client.get_job_result("aaaaaaaa-0000-4000-8000-000000000003").job_id)
            == "aaaaaaaa-0000-4000-8000-000000000003"
        )
    assert result_route.call_count == 1


@respx.mock
def test_get_job_result_rejects_non_object_body(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}/v1/jobs/aaaaaaaa-0000-4000-8000-000000000004/result").mock(
        return_value=httpx.Response(200, json=["nope"])
    )
    with (
        XbergClient(api_key=api_key, base_url=base_url, target="pro") as client,
        pytest.raises(XbergError, match="unexpected job result response shape"),
    ):
        client.get_job_result("aaaaaaaa-0000-4000-8000-000000000004")


@pytest.mark.asyncio
@respx.mock
async def test_get_job_result_async_parses_into_job_result_shape(api_key: str) -> None:
    respx.get(f"{PRO_URL}/v1/jobs/aaaaaaaa-0000-4000-8000-000000000005/result").mock(
        return_value=httpx.Response(
            200,
            json=make_job_result_payload(
                job_id="aaaaaaaa-0000-4000-8000-000000000005", results=[make_extraction_result(content="async body")]
            ),
        ),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        result = await client.get_job_result("aaaaaaaa-0000-4000-8000-000000000005")

    assert isinstance(result, JobResult)
    assert str(result.job_id) == "aaaaaaaa-0000-4000-8000-000000000005"
    assert [document.content for document in result.results] == ["async body"]


@pytest.mark.asyncio
@respx.mock
async def test_get_job_result_async_on_enterprise_is_not_gated(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}/v1/jobs/aaaaaaaa-0000-4000-8000-000000000006/result").mock(
        return_value=httpx.Response(200, json=make_job_result_payload(job_id="aaaaaaaa-0000-4000-8000-000000000006")),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        assert (
            str((await client.get_job_result("aaaaaaaa-0000-4000-8000-000000000006")).job_id)
            == "aaaaaaaa-0000-4000-8000-000000000006"
        )


# -- GET /v1/presets, /v1/presets/{id}, /v1/presets/{id}/sample/{name}  ~keep


@respx.mock
def test_presets_on_pro(api_key: str) -> None:
    respx.get(f"{PRO_URL}/v1/presets").mock(
        return_value=httpx.Response(200, json=[make_preset_summary(preset_id="invoice-v1")]),
    )
    with XbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        summaries = client.presets()

    assert len(summaries) == 1
    assert isinstance(summaries[0], PresetSummary)
    assert str(summaries[0].id) == "invoice-v1"
    assert summaries[0].category == "finance"
    assert summaries[0].preferred_call_mode == "text_only"


@respx.mock
def test_presets_on_enterprise(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}/v1/presets").mock(
        return_value=httpx.Response(200, json=[make_preset_summary(preset_id="bol-v2")]),
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        assert [summary.id for summary in client.presets()] == ["bol-v2"]


@respx.mock
def test_presets_rejects_non_array_body(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}/v1/presets").mock(return_value=httpx.Response(200, json={"presets": []}))
    with (
        XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client,
        pytest.raises(XbergError, match="unexpected preset list response shape"),
    ):
        client.presets()


@respx.mock
def test_get_preset_on_pro(api_key: str) -> None:
    respx.get(f"{PRO_URL}/v1/presets/invoice-v1").mock(
        return_value=httpx.Response(200, json=make_preset_detail(preset_id="invoice-v1")),
    )
    with XbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        detail = client.get_preset("invoice-v1")

    assert isinstance(detail, PresetDetail)
    assert str(detail.id) == "invoice-v1"
    assert detail.system_prompt == "Extract the invoice fields."
    assert detail.schema.to_dict() == {"type": "object", "properties": {"total": {"type": "number"}}}


@respx.mock
def test_get_preset_on_enterprise(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}/v1/presets/invoice-v1").mock(
        return_value=httpx.Response(200, json=make_preset_detail()),
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        assert client.get_preset("invoice-v1").schema_name == "Invoice"


@respx.mock
def test_get_preset_sample_returns_raw_bytes(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}/v1/presets/invoice-v1/sample/demo.pdf").mock(
        return_value=httpx.Response(200, content=b"%PDF-1.7 sample", headers={"Content-Type": "application/pdf"}),
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        assert client.get_preset_sample("invoice-v1", "demo.pdf") == b"%PDF-1.7 sample"
    assert route.call_count == 1


@respx.mock
def test_get_preset_sample_on_pro(api_key: str) -> None:
    respx.get(f"{PRO_URL}/v1/presets/invoice-v1/sample/demo.pdf").mock(
        return_value=httpx.Response(200, content=b"pro sample bytes"),
    )
    with XbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        assert client.get_preset_sample("invoice-v1", "demo.pdf") == b"pro sample bytes"


@pytest.mark.asyncio
@respx.mock
async def test_presets_async_on_pro(api_key: str) -> None:
    respx.get(f"{PRO_URL}/v1/presets").mock(
        return_value=httpx.Response(200, json=[make_preset_summary(preset_id="invoice-v1")]),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        summaries = await client.presets()

    assert [summary.id for summary in summaries] == ["invoice-v1"]
    assert isinstance(summaries[0], PresetSummary)


@pytest.mark.asyncio
@respx.mock
async def test_get_preset_async_on_enterprise(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}/v1/presets/invoice-v1").mock(
        return_value=httpx.Response(200, json=make_preset_detail()),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        detail = await client.get_preset("invoice-v1")

    assert isinstance(detail, PresetDetail)
    assert detail.fingerprint == "sha256:0badc0de"


@pytest.mark.asyncio
@respx.mock
async def test_get_preset_sample_async_on_pro(api_key: str) -> None:
    respx.get(f"{PRO_URL}/v1/presets/invoice-v1/sample/demo.pdf").mock(
        return_value=httpx.Response(200, content=b"async sample bytes"),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        assert await client.get_preset_sample("invoice-v1", "demo.pdf") == b"async sample bytes"


# -- GET /v1/rag/embedding-presets  ~keep


EMBEDDING_PRESETS = {
    "presets": [
        {
            "name": "default",
            "embedding_source": "bge-small-en-v1.5",
            "embedding_dim": 384,
            "description": "Balanced English retrieval.",
            "is_default": True,
        }
    ]
}


@respx.mock
def test_list_managed_embedding_presets_on_enterprise(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}/v1/rag/embedding-presets").mock(
        return_value=httpx.Response(200, json=EMBEDDING_PRESETS),
    )
    with XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        response = client.list_managed_embedding_presets()

    assert [preset.name for preset in response.presets] == ["default"]
    assert response.presets[0].embedding_dim == 384
    assert response.presets[0].embedding_source == "bge-small-en-v1.5"
    assert response.presets[0].is_default is True
    assert route.calls.last.request.method == "GET"
    assert route.calls.last.request.url.path == "/v1/rag/embedding-presets"


@respx.mock
def test_list_managed_embedding_presets_on_pro_is_not_gated(api_key: str) -> None:
    route = respx.get(f"{PRO_URL}/v1/rag/embedding-presets").mock(
        return_value=httpx.Response(200, json=EMBEDDING_PRESETS),
    )
    with XbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        assert client.list_managed_embedding_presets().presets[0].name == "default"

    assert route.call_count == 1


@respx.mock
def test_list_managed_embedding_presets_without_target_does_not_probe_healthz(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}/v1/rag/embedding-presets").mock(
        return_value=httpx.Response(200, json={"presets": []}),
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        assert client.list_managed_embedding_presets().presets == []

    assert route.call_count == 1


@respx.mock
def test_list_managed_embedding_presets_rejects_a_non_object_body(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}/v1/rag/embedding-presets").mock(return_value=httpx.Response(200, json=["nope"]))
    with (
        XbergClient(api_key=api_key, base_url=base_url, target="pro") as client,
        pytest.raises(XbergError, match="unexpected embedding preset list response shape"),
    ):
        client.list_managed_embedding_presets()


@pytest.mark.asyncio
@respx.mock
async def test_list_managed_embedding_presets_async_on_pro(api_key: str) -> None:
    route = respx.get(f"{PRO_URL}/v1/rag/embedding-presets").mock(
        return_value=httpx.Response(200, json=EMBEDDING_PRESETS),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        response = await client.list_managed_embedding_presets()

    assert response.presets[0].description == "Balanced English retrieval."
    assert route.calls.last.request.url.path == "/v1/rag/embedding-presets"
