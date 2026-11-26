"""Tests for Pro's keyed extraction, ``POST /v1/extract/keyed``."""

from __future__ import annotations

import json
from typing import TYPE_CHECKING

import httpx
import pytest
import respx

from tests.conftest import make_extract_response, make_job_payload
from xberg_io_sdk import AsyncXbergClient, XbergClient, XbergError

if TYPE_CHECKING:
    from xberg_io_sdk.client import Target

JOB_ID = "44444444-4444-4444-8444-444444444444"
PROJECT = "11111111-1111-4111-8111-111111111111"
KEY = "retry-key-0001"


def _mock_keyed(base_url: str) -> respx.Route:
    route = respx.post(f"{base_url}/v1/extract/keyed").mock(
        return_value=httpx.Response(202, json=make_extract_response(job_ids=[JOB_ID])),
    )
    respx.get(f"{base_url}/v1/jobs/{JOB_ID}").mock(
        return_value=httpx.Response(200, json=make_job_payload(job_id=JOB_ID, status="pending")),
    )
    return route


async def _submit(base_url: str, target: Target, asynchronous: bool, files: list[bytes], key: str) -> None:
    if asynchronous:
        async with AsyncXbergClient(base_url=base_url, target=target) as client:
            await client.extract_keyed(files, idempotency_key=key)
    else:
        with XbergClient(base_url=base_url, target=target) as sync_client:
            sync_client.extract_keyed(files, idempotency_key=key)


@pytest.mark.parametrize("asynchronous", [False, True])
@respx.mock
async def test_extract_keyed_sends_the_idempotency_key_and_a_file_multipart_body(
    base_url: str, api_key: str, asynchronous: bool
) -> None:
    route = _mock_keyed(base_url)
    kwargs = {"idempotency_key": KEY, "options": {"output_format": "markdown"}, "configs": [{"force_ocr": True}]}
    if asynchronous:
        async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="pro") as client:
            jobs = await client.extract_keyed([b"%PDF-1.4 fake"], **kwargs)
    else:
        with XbergClient(api_key=api_key, base_url=base_url, target="pro") as sync_client:
            jobs = sync_client.extract_keyed([b"%PDF-1.4 fake"], **kwargs)

    assert [str(job.id) for job in jobs] == [JOB_ID]
    assert route.call_count == 1
    request = route.calls.last.request
    assert request.headers["Idempotency-Key"] == KEY
    assert request.headers["content-type"].startswith("multipart/form-data")
    assert "X-Project-ID" not in request.headers
    body = request.content.decode("latin-1")
    assert 'name="file"; filename="upload.bin"' in body
    assert 'name="options"' in body
    assert json.dumps({"output_format": "markdown"}) in body
    assert 'name="config-upload.bin"' in body
    assert 'name="webhook"' not in body


@pytest.mark.parametrize("asynchronous", [False, True])
@respx.mock
async def test_extract_keyed_selects_the_pro_project_by_header(base_url: str, asynchronous: bool) -> None:
    route = _mock_keyed(base_url)
    if asynchronous:
        async with AsyncXbergClient(base_url=base_url, target="pro") as client:
            await client.extract_keyed([b"x"], idempotency_key=KEY, project_id=PROJECT)
    else:
        with XbergClient(base_url=base_url, target="pro") as sync_client:
            sync_client.extract_keyed([b"x"], idempotency_key=KEY, project_id=PROJECT)

    request = route.calls.last.request
    assert request.headers["X-Project-ID"] == PROJECT
    assert request.headers["Idempotency-Key"] == KEY
    assert request.url.params == httpx.QueryParams()
    job_request = respx.calls.last.request
    assert job_request.url.path == f"/v1/jobs/{JOB_ID}"
    assert job_request.url.params == httpx.QueryParams({"project_id": PROJECT})


@pytest.mark.parametrize("asynchronous", [False, True])
@pytest.mark.parametrize(("files", "key"), [([b"x"], " "), ([], KEY)])
@respx.mock
async def test_extract_keyed_rejects_a_blank_key_or_no_files_before_any_request(
    base_url: str, asynchronous: bool, files: list[bytes], key: str
) -> None:
    route = _mock_keyed(base_url)
    with pytest.raises(XbergError) as error:
        await _submit(base_url, "pro", asynchronous, files, key)

    assert error.value.status_code is None
    assert route.call_count == 0


@pytest.mark.parametrize("asynchronous", [False, True])
@respx.mock
async def test_extract_keyed_is_refused_on_enterprise_before_any_request(base_url: str, asynchronous: bool) -> None:
    route = _mock_keyed(base_url)
    with pytest.raises(XbergError, match=r"extract_keyed\(\) is not available on the 'enterprise' tier"):
        await _submit(base_url, "enterprise", asynchronous, [b"x"], KEY)

    assert route.call_count == 0
