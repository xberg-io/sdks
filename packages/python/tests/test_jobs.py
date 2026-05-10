"""Tests for ``get_job`` / ``wait_for_job`` / ``wait_for_jobs`` covering polling and timeouts."""

from __future__ import annotations

import time

import httpx
import pytest
import respx

from kreuzberg_cloud import AsyncKreuzbergCloud, KreuzbergCloud
from kreuzberg_cloud import TimeoutError as ClientTimeoutError
from tests.conftest import make_extraction_result, make_job_payload


@respx.mock
def test_get_job_sync_returns_typed_job(base_url: str, api_key: str) -> None:
    job_id = "11111111-1111-1111-1111-111111111111"
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(200, json=make_job_payload(job_id=job_id, status="processing")),
    )

    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        job = client.get_job(job_id)

    assert str(job.id) == job_id
    assert job.status == "processing"
    assert job.filename == "invoice.pdf"


@respx.mock
def test_wait_for_job_sync_returns_immediately_when_completed(base_url: str, api_key: str) -> None:
    job_id = "22222222-2222-2222-2222-222222222222"
    route = respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(
            200,
            json=make_job_payload(job_id=job_id, status="completed", result=make_extraction_result()),
        ),
    )

    start = time.monotonic()
    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        job = client.wait_for_job(job_id, poll_interval=0.01, timeout=5.0)
    elapsed = time.monotonic() - start

    assert job.status == "completed"
    assert route.call_count == 1
    assert elapsed < 1.0  # no polling beyond the first hit


@respx.mock
def test_wait_for_job_sync_polls_until_terminal(base_url: str, api_key: str) -> None:
    job_id = "33333333-3333-3333-3333-333333333333"
    route = respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        side_effect=[
            httpx.Response(200, json=make_job_payload(job_id=job_id, status="pending")),
            httpx.Response(200, json=make_job_payload(job_id=job_id, status="processing")),
            httpx.Response(
                200,
                json=make_job_payload(job_id=job_id, status="completed", result=make_extraction_result()),
            ),
        ],
    )

    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        job = client.wait_for_job(job_id, poll_interval=0.01, timeout=5.0, backoff="constant")

    assert job.status == "completed"
    assert route.call_count == 3


@respx.mock
def test_wait_for_job_sync_returns_failed_status_without_raising(base_url: str, api_key: str) -> None:
    job_id = "44444444-4444-4444-4444-444444444444"
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(200, json=make_job_payload(job_id=job_id, status="failed")),
    )

    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        job = client.wait_for_job(job_id, poll_interval=0.01, timeout=1.0)

    assert job.status == "failed"


@respx.mock
def test_wait_for_job_sync_times_out_when_never_terminal(base_url: str, api_key: str) -> None:
    job_id = "55555555-5555-5555-5555-555555555555"
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(200, json=make_job_payload(job_id=job_id, status="processing")),
    )

    with (
        KreuzbergCloud(api_key=api_key, base_url=base_url) as client,
        pytest.raises(ClientTimeoutError, match="terminal status"),
    ):
        client.wait_for_job(job_id, poll_interval=0.05, timeout=0.15)


@pytest.mark.asyncio
@respx.mock
async def test_wait_for_job_async_polls_until_terminal(base_url: str, api_key: str) -> None:
    job_id = "66666666-6666-6666-6666-666666666666"
    route = respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        side_effect=[
            httpx.Response(200, json=make_job_payload(job_id=job_id, status="pending")),
            httpx.Response(200, json=make_job_payload(job_id=job_id, status="completed")),
        ],
    )

    async with AsyncKreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        job = await client.wait_for_job(job_id, poll_interval=0.01, timeout=2.0)

    assert job.status == "completed"
    assert route.call_count == 2


@pytest.mark.asyncio
@respx.mock
async def test_wait_for_job_async_times_out(base_url: str, api_key: str) -> None:
    job_id = "77777777-7777-7777-7777-777777777777"
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(200, json=make_job_payload(job_id=job_id, status="processing")),
    )

    async with AsyncKreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        with pytest.raises(ClientTimeoutError):
            await client.wait_for_job(job_id, poll_interval=0.02, timeout=0.1)


@respx.mock
def test_wait_for_job_exponential_backoff_increases_interval(
    monkeypatch: pytest.MonkeyPatch, base_url: str, api_key: str
) -> None:
    """Verify the exponential backoff actually scales the sleep delay each iteration."""
    job_id = "88888888-8888-8888-8888-888888888888"
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        side_effect=[
            httpx.Response(200, json=make_job_payload(job_id=job_id, status="pending")),
            httpx.Response(200, json=make_job_payload(job_id=job_id, status="processing")),
            httpx.Response(200, json=make_job_payload(job_id=job_id, status="completed")),
        ],
    )

    sleeps: list[float] = []

    def _record_sleep(seconds: float) -> None:
        sleeps.append(seconds)

    # Patch the time.sleep used by the sync client (imported as a module symbol).
    from kreuzberg_cloud import client as client_module

    monkeypatch.setattr(client_module.time, "sleep", _record_sleep)

    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        client.wait_for_job(job_id, poll_interval=0.5, timeout=10.0, backoff="exponential")

    # Two sleeps before the third (terminal) response.
    assert len(sleeps) == 2
    assert sleeps[0] == pytest.approx(0.5)
    # Exponential backoff doubles the interval (capped at 30s).
    assert sleeps[1] == pytest.approx(1.0)


@respx.mock
def test_wait_for_job_constant_backoff_keeps_interval_steady(
    monkeypatch: pytest.MonkeyPatch, base_url: str, api_key: str
) -> None:
    job_id = "99999999-9999-9999-9999-999999999999"
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        side_effect=[
            httpx.Response(200, json=make_job_payload(job_id=job_id, status="pending")),
            httpx.Response(200, json=make_job_payload(job_id=job_id, status="pending")),
            httpx.Response(200, json=make_job_payload(job_id=job_id, status="completed")),
        ],
    )

    sleeps: list[float] = []
    from kreuzberg_cloud import client as client_module

    monkeypatch.setattr(client_module.time, "sleep", sleeps.append)

    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        client.wait_for_job(job_id, poll_interval=0.25, timeout=10.0, backoff="constant")

    assert sleeps == [pytest.approx(0.25), pytest.approx(0.25)]


@pytest.mark.asyncio
@respx.mock
async def test_wait_for_jobs_async_runs_in_parallel(base_url: str, api_key: str) -> None:
    job_ids = [
        "aaaaaaaa-1111-1111-1111-aaaaaaaaaaaa",
        "bbbbbbbb-2222-2222-2222-bbbbbbbbbbbb",
    ]
    for jid in job_ids:
        respx.get(f"{base_url}/v1/jobs/{jid}").mock(
            return_value=httpx.Response(
                200,
                json=make_job_payload(job_id=jid, status="completed", result=make_extraction_result()),
            ),
        )

    async with AsyncKreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        jobs = await client.wait_for_jobs(job_ids, poll_interval=0.01, timeout=2.0)

    assert {str(j.id) for j in jobs} == set(job_ids)
    assert all(j.status == "completed" for j in jobs)


@respx.mock
def test_extract_and_wait_sync_returns_completed_job(base_url: str, api_key: str) -> None:
    from tests.conftest import make_extract_response

    job_id = "cccccccc-3333-3333-3333-cccccccccccc"
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(202, json=make_extract_response(job_ids=[job_id])),
    )
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        side_effect=[
            # First call: surfaced by extract() itself (returns pending Job).
            httpx.Response(200, json=make_job_payload(job_id=job_id, status="pending")),
            # Subsequent calls: poll loop inside wait_for_job.
            httpx.Response(200, json=make_job_payload(job_id=job_id, status="pending")),
            httpx.Response(
                200,
                json=make_job_payload(job_id=job_id, status="completed", result=make_extraction_result(content="hi")),
            ),
        ],
    )

    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        job = client.extract_and_wait(file=b"x", poll_interval=0.01, timeout=5.0, backoff="constant")

    assert job.status == "completed"
    assert job.result is not None
    assert job.result.content == "hi"  # type: ignore[union-attr]
