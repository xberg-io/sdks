"""End-to-end tests covering ``extract_and_wait`` for both sync and async clients."""

from __future__ import annotations

import httpx
import pytest
import respx

from kreuzberg_cloud import AsyncKreuzbergCloud, KreuzbergCloud
from kreuzberg_cloud import TimeoutError as ClientTimeoutError
from tests.conftest import make_extract_response, make_extraction_result, make_job_payload


@respx.mock
def test_extract_and_wait_sync_returns_extraction_result(base_url: str, api_key: str) -> None:
    job_id = "11111111-1111-1111-1111-111111111111"
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(202, json=make_extract_response(job_ids=[job_id])),
    )
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        side_effect=[
            httpx.Response(200, json=make_job_payload(job_id=job_id, status="pending")),
            httpx.Response(
                200,
                json=make_job_payload(
                    job_id=job_id,
                    status="completed",
                    result=make_extraction_result(content="extracted text"),
                ),
            ),
        ],
    )

    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        job = client.extract_and_wait(file=b"data", poll_interval=0.01, timeout=2.0, backoff="constant")

    assert job.status == "completed"
    assert job.result is not None
    assert job.result.content == "extracted text"  # type: ignore[union-attr]


@pytest.mark.asyncio
@respx.mock
async def test_extract_and_wait_async_returns_extraction_result(base_url: str, api_key: str) -> None:
    job_id = "22222222-2222-2222-2222-222222222222"
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(202, json=make_extract_response(job_ids=[job_id])),
    )
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(
            200,
            json=make_job_payload(job_id=job_id, status="completed", result=make_extraction_result(content="async ok")),
        ),
    )

    async with AsyncKreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        job = await client.extract_and_wait(file=b"data", poll_interval=0.01, timeout=2.0)

    assert job.status == "completed"
    assert job.result.content == "async ok"  # type: ignore[union-attr]


@pytest.mark.asyncio
@respx.mock
async def test_extract_and_wait_async_propagates_failed_status(base_url: str, api_key: str) -> None:
    job_id = "33333333-3333-3333-3333-333333333333"
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(202, json=make_extract_response(job_ids=[job_id])),
    )
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(200, json=make_job_payload(job_id=job_id, status="failed")),
    )

    async with AsyncKreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        job = await client.extract_and_wait(file=b"data", poll_interval=0.01, timeout=2.0)

    # Failed jobs are returned (not raised) so callers can branch on status.
    assert job.status == "failed"


@pytest.mark.asyncio
@respx.mock
async def test_extract_and_wait_async_times_out(base_url: str, api_key: str) -> None:
    job_id = "44444444-4444-4444-4444-444444444444"
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(202, json=make_extract_response(job_ids=[job_id])),
    )
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(200, json=make_job_payload(job_id=job_id, status="processing")),
    )

    async with AsyncKreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        with pytest.raises(ClientTimeoutError):
            await client.extract_and_wait(file=b"data", poll_interval=0.02, timeout=0.1)


@respx.mock
def test_extract_and_wait_sync_passes_options_through(base_url: str, api_key: str) -> None:
    job_id = "55555555-5555-5555-5555-555555555555"
    extract_route = respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(202, json=make_extract_response(job_ids=[job_id])),
    )
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(200, json=make_job_payload(job_id=job_id, status="completed")),
    )

    options = {"extraction_config": {"chunk_content": True}}

    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        client.extract_and_wait(file=b"data", options=options, poll_interval=0.01, timeout=2.0)

    body = extract_route.calls.last.request.content
    assert b'"chunk_content": true' in body
