"""Coverage for client-internal helpers and edge-case control flow.

Targets the small module-level helpers (mime guessing, response-shape
validation, job-failure detail extraction), header merging, transport-level
retry exhaustion, empty/204 response decoding, and the remaining
list/audit/wait_for_jobs paths not exercised by the happy-path test files.
"""

from __future__ import annotations

import httpx
import pytest
import respx

from tests.conftest import make_extract_response, make_job_payload
from xberg_io_sdk import AsyncXbergClient, XbergClient, XbergError

# -- _guess_mime_type / file part preparation -----------------------------------


@respx.mock
def test_extract_md_file_uses_text_markdown_mime_type(tmp_path: object, base_url: str, api_key: str) -> None:
    from pathlib import Path

    target = Path(str(tmp_path)) / "notes.md"
    target.write_text("# hello")

    job_id = "11111111-1111-1111-1111-111111111111"
    route = respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(202, json=make_extract_response(job_ids=[job_id])),
    )
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(200, json=make_job_payload(job_id=job_id)),
    )

    with XbergClient(api_key=api_key, base_url=base_url) as client:
        client.extract(file=target)

    body = route.calls.last.request.content
    assert b'filename="notes.md"' in body
    assert b"Content-Type: text/markdown" in body


# -- response-shape validation ---------------------------------------------------


@respx.mock
def test_extract_response_non_dict_payload_raises_value_error(base_url: str, api_key: str) -> None:
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(202, json=["not", "a", "dict"]),
    )
    with (
        XbergClient(api_key=api_key, base_url=base_url) as client,
        pytest.raises(XbergError, match="unexpected extract response shape"),
    ):
        client.extract(file=b"x")


@respx.mock
def test_get_job_non_dict_payload_raises_value_error(base_url: str, api_key: str) -> None:
    job_id = "22222222-2222-2222-2222-222222222222"
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(200, json=["nope"]),
    )
    with (
        XbergClient(api_key=api_key, base_url=base_url) as client,
        pytest.raises(XbergError, match="unexpected job response shape"),
    ):
        client.get_job(job_id)


# -- _job_failure_detail / _raise_if_failed --------------------------------------


@respx.mock
def test_wait_for_job_failure_detail_prefers_error_key(base_url: str, api_key: str) -> None:
    job_id = "33333333-3333-3333-3333-333333333333"
    payload = make_job_payload(job_id=job_id, status="failed")
    payload["error"] = "ocr engine crashed"
    payload["message"] = "should not be used"
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(return_value=httpx.Response(200, json=payload))

    with XbergClient(api_key=api_key, base_url=base_url) as client, pytest.raises(XbergError) as exc_info:
        client.wait_for_job(job_id, poll_interval=0.01, timeout=1.0)

    assert "ocr engine crashed" in str(exc_info.value)


@respx.mock
def test_wait_for_job_failure_without_detail_key_has_no_suffix(base_url: str, api_key: str) -> None:
    job_id = "44444444-4444-4444-4444-444444444444"
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(200, json=make_job_payload(job_id=job_id, status="cancelled")),
    )

    with XbergClient(api_key=api_key, base_url=base_url) as client, pytest.raises(XbergError) as exc_info:
        client.wait_for_job(job_id, poll_interval=0.01, timeout=1.0)

    assert str(exc_info.value) == f"job {job_id} ended with status 'cancelled'"


# -- header merging ---------------------------------------------------------------


def test_custom_headers_are_merged_with_defaults() -> None:
    with XbergClient(api_key="k", base_url="https://api.example.test", headers={"X-Trace-Id": "abc123"}) as client:
        assert client._headers["X-Trace-Id"] == "abc123"
        assert client._headers["Authorization"] == "Bearer k"
        assert "User-Agent" in client._headers


def test_custom_headers_can_override_default_user_agent() -> None:
    with XbergClient(base_url="https://api.example.test", headers={"User-Agent": "custom-agent/1.0"}) as client:
        assert client._headers["User-Agent"] == "custom-agent/1.0"


# -- transport-level retry exhaustion --------------------------------------------


@respx.mock
def test_sync_transport_error_retries_then_succeeds(
    base_url: str, api_key: str, monkeypatch: pytest.MonkeyPatch
) -> None:
    from xberg_io_sdk import client as client_module

    monkeypatch.setattr(client_module.time, "sleep", lambda _seconds: None)
    route = respx.get(f"{base_url}/v1/rag/collections").mock(
        side_effect=[
            httpx.ConnectError("boom"),
            httpx.Response(200, json={"collections": ["ok"]}),
        ],
    )

    with XbergClient(api_key=api_key, base_url=base_url, retries=1) as client:
        result = client.list_rag_collections()

    assert result == {"collections": ["ok"]}
    assert route.call_count == 2


@respx.mock
def test_sync_transport_error_exhausts_retries_raises_xberg_error(
    base_url: str, api_key: str, monkeypatch: pytest.MonkeyPatch
) -> None:
    from xberg_io_sdk import client as client_module

    monkeypatch.setattr(client_module.time, "sleep", lambda _seconds: None)
    respx.get(f"{base_url}/v1/rag/collections").mock(side_effect=httpx.ConnectError("boom"))

    with (
        XbergClient(api_key=api_key, base_url=base_url, retries=1) as client,
        pytest.raises(XbergError, match="network error contacting"),
    ):
        client.list_rag_collections()


@pytest.mark.asyncio
@respx.mock
async def test_async_transport_error_retries_then_succeeds(
    base_url: str, api_key: str, monkeypatch: pytest.MonkeyPatch
) -> None:
    from xberg_io_sdk import client as client_module

    async def _fake_sleep(_seconds: float) -> None:
        return None

    monkeypatch.setattr(client_module.asyncio, "sleep", _fake_sleep)
    route = respx.get(f"{base_url}/v1/rag/collections").mock(
        side_effect=[
            httpx.ConnectError("boom"),
            httpx.Response(200, json={"collections": ["ok"]}),
        ],
    )

    async with AsyncXbergClient(api_key=api_key, base_url=base_url, retries=1) as client:
        result = await client.list_rag_collections()

    assert result == {"collections": ["ok"]}
    assert route.call_count == 2


@pytest.mark.asyncio
@respx.mock
async def test_async_transport_error_exhausts_retries_raises_xberg_error(
    base_url: str, api_key: str, monkeypatch: pytest.MonkeyPatch
) -> None:
    from xberg_io_sdk import client as client_module

    async def _fake_sleep(_seconds: float) -> None:
        return None

    monkeypatch.setattr(client_module.asyncio, "sleep", _fake_sleep)
    respx.get(f"{base_url}/v1/rag/collections").mock(side_effect=httpx.ConnectError("boom"))

    async with AsyncXbergClient(api_key=api_key, base_url=base_url, retries=0) as client:
        with pytest.raises(XbergError, match="network error contacting"):
            await client.list_rag_collections()


# -- empty / 204 response decoding -----------------------------------------------


@respx.mock
def test_request_json_returns_none_for_204(base_url: str, api_key: str) -> None:
    respx.delete(f"{base_url}/v1/rag/collections/docs").mock(return_value=httpx.Response(204))
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        assert client.delete_rag_collection("docs") is None


@respx.mock
def test_request_json_returns_none_for_empty_body(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}/v1/rag/jobs/aaaaaaaa-0000-4000-8000-000000000001").mock(
        return_value=httpx.Response(200, content=b"")
    )
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        assert client.get_rag_job("aaaaaaaa-0000-4000-8000-000000000001") is None


@pytest.mark.asyncio
@respx.mock
async def test_request_json_returns_none_for_204_async(base_url: str, api_key: str) -> None:
    respx.delete(f"{base_url}/v1/rag/collections/docs").mock(return_value=httpx.Response(204))
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        assert await client.delete_rag_collection("docs") is None


# -- extract_batch guard clause ---------------------------------------------------


def test_extract_batch_sync_with_no_files_raises() -> None:
    with (
        XbergClient(api_key="k", base_url="https://api.example.test") as client,
        pytest.raises(XbergError, match="no files"),
    ):
        client.extract_batch([])


@pytest.mark.asyncio
async def test_extract_batch_async_with_no_files_raises() -> None:
    async with AsyncXbergClient(api_key="k", base_url="https://api.example.test") as client:
        with pytest.raises(XbergError, match="no files"):
            await client.extract_batch([])


# -- list_jobs / audit param forwarding -------------------------------------------


@respx.mock
def test_list_jobs_sync_forwards_limit_and_offset(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}/v1/jobs").mock(return_value=httpx.Response(200, json={"jobs": []}))
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        result = client.list_jobs(limit=10, offset=5)
    assert result == {"jobs": []}
    assert dict(route.calls.last.request.url.params) == {"limit": "10", "offset": "5"}


@respx.mock
def test_list_jobs_sync_omits_params_when_unset(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}/v1/jobs").mock(return_value=httpx.Response(200, json={"jobs": []}))
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        client.list_jobs()
    assert dict(route.calls.last.request.url.params) == {}


@pytest.mark.asyncio
@respx.mock
async def test_list_jobs_async_forwards_limit_and_offset(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}/v1/jobs").mock(return_value=httpx.Response(200, json={"jobs": []}))
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        await client.list_jobs(limit=3, offset=1)
    assert dict(route.calls.last.request.url.params) == {"limit": "3", "offset": "1"}


@respx.mock
def test_audit_sync_forwards_action_limit_offset(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}/v1/audit").mock(return_value=httpx.Response(200, json={"entries": []}))
    with XbergClient(api_key=api_key, base_url=base_url) as client:
        result = client.audit(action="job.created", limit=20, offset=0)
    assert result == {"entries": []}
    assert dict(route.calls.last.request.url.params) == {"action": "job.created", "limit": "20", "offset": "0"}


@pytest.mark.asyncio
@respx.mock
async def test_audit_async_forwards_action_limit_offset(base_url: str, api_key: str) -> None:
    route = respx.get(f"{base_url}/v1/audit").mock(return_value=httpx.Response(200, json={"entries": []}))
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        result = await client.audit(action="job.created")
    assert result == {"entries": []}
    assert dict(route.calls.last.request.url.params) == {"action": "job.created"}


# -- wait_for_jobs (sequential sync path) -----------------------------------------


@respx.mock
def test_wait_for_jobs_sync_runs_sequentially(base_url: str, api_key: str) -> None:
    job_ids = ["aaaaaaaa-0000-0000-0000-aaaaaaaaaaaa", "bbbbbbbb-0000-0000-0000-bbbbbbbbbbbb"]
    for jid in job_ids:
        respx.get(f"{base_url}/v1/jobs/{jid}").mock(
            return_value=httpx.Response(200, json=make_job_payload(job_id=jid, status="completed")),
        )

    with XbergClient(api_key=api_key, base_url=base_url) as client:
        jobs = client.wait_for_jobs(job_ids, poll_interval=0.01, timeout=2.0)

    assert [str(j.id) for j in jobs] == job_ids
    assert all(j.status == "completed" for j in jobs)
