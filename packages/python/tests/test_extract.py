"""Tests for ``KreuzbergCloud.extract`` / ``AsyncKreuzbergCloud.extract`` and batch variants."""

from __future__ import annotations

import io
import json

import httpx
import pytest
import respx

from kreuzberg_cloud import AsyncKreuzbergCloud, ExtractionOptions, KreuzbergCloud
from tests.conftest import TEST_API_KEY, make_extract_response, make_job_payload


@respx.mock
def test_extract_sync_happy_path_with_bytes(base_url: str, api_key: str) -> None:
    job_id = "11111111-1111-1111-1111-111111111111"
    extract_route = respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(202, json=make_extract_response(job_ids=[job_id])),
    )
    job_route = respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(200, json=make_job_payload(job_id=job_id, status="pending")),
    )

    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        job = client.extract(file=b"%PDF-1.4 fake")

    assert extract_route.called
    assert job_route.called
    assert str(job.id) == job_id
    assert job.status == "pending"


@respx.mock
def test_extract_sync_sends_multipart_with_file_and_webhook_fields(base_url: str, api_key: str) -> None:
    job_id = "22222222-2222-2222-2222-222222222222"
    route = respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(202, json=make_extract_response(job_ids=[job_id])),
    )
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(200, json=make_job_payload(job_id=job_id, status="pending")),
    )

    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        client.extract(file=b"data")

    assert route.called
    request = route.calls.last.request
    content_type = request.headers["content-type"]
    assert content_type.startswith("multipart/form-data")
    body = request.content
    assert b'name="file"' in body
    assert b'name="webhook"' in body
    assert b'{"url": ""}' in body
    assert b"data" in body


@respx.mock
def test_extract_sync_serializes_options_as_json_part(base_url: str, api_key: str) -> None:
    job_id = "33333333-3333-3333-3333-333333333333"
    route = respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(202, json=make_extract_response(job_ids=[job_id])),
    )
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(200, json=make_job_payload(job_id=job_id, status="pending")),
    )

    options = {"extraction_config": {"chunk_content": True}}

    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        client.extract(file=b"data", options=options)

    body = route.calls.last.request.content
    assert b'name="options"' in body
    # The "options" multipart part is the JSON-serialized dict.
    assert b'"chunk_content": true' in body


@respx.mock
def test_extract_sync_accepts_extraction_options_model(base_url: str, api_key: str) -> None:
    job_id = "44444444-4444-4444-4444-444444444444"
    route = respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(202, json=make_extract_response(job_ids=[job_id])),
    )
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(200, json=make_job_payload(job_id=job_id, status="pending")),
    )

    options = ExtractionOptions()

    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        client.extract(file=b"data", options=options)

    body = route.calls.last.request.content
    assert b'name="options"' in body


@respx.mock
def test_extract_sync_accepts_binaryio_input(base_url: str, api_key: str) -> None:
    job_id = "55555555-5555-5555-5555-555555555555"
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(202, json=make_extract_response(job_ids=[job_id])),
    )
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(200, json=make_job_payload(job_id=job_id, status="pending")),
    )

    stream = io.BytesIO(b"hello")
    stream.name = "doc.pdf"

    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        job = client.extract(file=stream)

    assert str(job.id) == job_id


@respx.mock
def test_extract_sync_accepts_path_input(tmp_path: object, base_url: str, api_key: str) -> None:
    from pathlib import Path

    target = Path(str(tmp_path)) / "fixture.txt"
    target.write_bytes(b"hello world")

    job_id = "66666666-6666-6666-6666-666666666666"
    route = respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(202, json=make_extract_response(job_ids=[job_id])),
    )
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(200, json=make_job_payload(job_id=job_id, status="pending")),
    )

    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        client.extract(file=target)

    body = route.calls.last.request.content
    assert b'filename="fixture.txt"' in body
    assert b"Content-Type: text/plain" in body


@respx.mock
def test_extract_sends_authorization_header(base_url: str, api_key: str) -> None:
    job_id = "77777777-7777-7777-7777-777777777777"
    route = respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(202, json=make_extract_response(job_ids=[job_id])),
    )
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(200, json=make_job_payload(job_id=job_id)),
    )

    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        client.extract(file=b"x")

    assert route.calls.last.request.headers["authorization"] == f"Bearer {TEST_API_KEY}"


@respx.mock
def test_extract_batch_sync_issues_one_request_per_file(base_url: str, api_key: str) -> None:
    job_ids = [
        "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
        "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb",
    ]
    extract_route = respx.post(f"{base_url}/v1/extract").mock(
        side_effect=[
            httpx.Response(202, json=make_extract_response(job_ids=[job_ids[0]])),
            httpx.Response(202, json=make_extract_response(job_ids=[job_ids[1]])),
        ],
    )
    for job_id in job_ids:
        respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
            return_value=httpx.Response(200, json=make_job_payload(job_id=job_id, status="pending")),
        )

    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        jobs = client.extract_batch([b"a", b"b"])

    assert extract_route.call_count == 2
    assert [str(j.id) for j in jobs] == job_ids


@pytest.mark.asyncio
@respx.mock
async def test_extract_async_happy_path(base_url: str, api_key: str) -> None:
    job_id = "cccccccc-cccc-cccc-cccc-cccccccccccc"
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(202, json=make_extract_response(job_ids=[job_id])),
    )
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(200, json=make_job_payload(job_id=job_id, status="pending")),
    )

    async with AsyncKreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        job = await client.extract(file=b"data")

    assert str(job.id) == job_id


@pytest.mark.asyncio
@respx.mock
async def test_extract_batch_async_runs_in_parallel(base_url: str, api_key: str) -> None:
    job_ids = [
        "dddddddd-dddd-dddd-dddd-dddddddddddd",
        "eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee",
        "ffffffff-ffff-ffff-ffff-ffffffffffff",
    ]
    extract_route = respx.post(f"{base_url}/v1/extract").mock(
        side_effect=[httpx.Response(202, json=make_extract_response(job_ids=[jid])) for jid in job_ids],
    )
    for jid in job_ids:
        respx.get(f"{base_url}/v1/jobs/{jid}").mock(
            return_value=httpx.Response(200, json=make_job_payload(job_id=jid, status="pending")),
        )

    async with AsyncKreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        jobs = await client.extract_batch([b"a", b"b", b"c"])

    assert extract_route.call_count == 3
    assert {str(j.id) for j in jobs} == set(job_ids)


@respx.mock
def test_extract_response_with_unexpected_shape_raises(base_url: str, api_key: str) -> None:
    respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(202, json={"unexpected": "shape"}),
    )

    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client, pytest.raises(ValueError, match="job_ids"):
        client.extract(file=b"x")


@respx.mock
def test_extract_options_dict_round_trip_is_correct_json(base_url: str, api_key: str) -> None:
    job_id = "abababab-abab-abab-abab-abababababab"
    route = respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(202, json=make_extract_response(job_ids=[job_id])),
    )
    respx.get(f"{base_url}/v1/jobs/{job_id}").mock(
        return_value=httpx.Response(200, json=make_job_payload(job_id=job_id)),
    )

    options = {"extraction_config": {"detect_languages": True, "force_ocr": False}}

    with KreuzbergCloud(api_key=api_key, base_url=base_url) as client:
        client.extract(file=b"x", options=options)

    body = route.calls.last.request.content.decode("utf-8", errors="replace")
    # Find the options JSON inside the multipart body
    marker = 'name="options"'
    assert marker in body
    # The exact serialization is contractual: round-trip via json.loads is the
    # cleanest assertion that nothing got mangled.
    start = body.index("\r\n\r\n", body.index(marker)) + 4
    end = body.index("\r\n", start)
    parsed = json.loads(body[start:end])
    assert parsed == options
