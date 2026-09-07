"""Document lineage must be validated before uploads and precede multipart files."""

from __future__ import annotations

import io
from uuid import UUID

import httpx
import pytest
import respx

from tests.conftest import make_extract_response, make_job_payload
from xberg_io_sdk import AsyncXbergClient, XbergClient, XbergError

DOCUMENT_ID = "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
JOB_ID = "11111111-1111-1111-1111-111111111111"


@pytest.mark.asyncio
@pytest.mark.parametrize("asynchronous", [False, True])
@respx.mock
async def test_lineage_is_canonical_and_precedes_file(asynchronous: bool, base_url: str) -> None:
    route = respx.post(base_url + "/v1/extract").mock(
        return_value=httpx.Response(202, json=make_extract_response(job_ids=[JOB_ID]))
    )
    respx.get(base_url + "/v1/jobs/" + JOB_ID).mock(
        return_value=httpx.Response(200, json=make_job_payload(job_id=JOB_ID, status="pending"))
    )
    if asynchronous:
        async with AsyncXbergClient(base_url=base_url, target="enterprise") as client:
            await client.extract(file=b"lineage", document_id=UUID(DOCUMENT_ID))
    else:
        with XbergClient(base_url=base_url, target="enterprise") as client:
            client.extract(file=b"lineage", document_id=DOCUMENT_ID.upper())
    body = route.calls.last.request.content
    assert body.index(b'name="document_id-upload.bin"') < body.index(b'name="file"')
    assert DOCUMENT_ID.encode() in body
    assert body.count(b'name="document_id-upload.bin"') == 1


@pytest.mark.asyncio
@pytest.mark.parametrize("asynchronous", [False, True])
@pytest.mark.parametrize("ids, message", [([], "length"), (["invalid"], "UUID"), ([DOCUMENT_ID, None], "length")])
@respx.mock
async def test_lineage_invalid_inputs_do_not_read_upload(asynchronous: bool, ids, message: str) -> None:
    stream = io.BytesIO(b"unchanged")
    if asynchronous:
        async with AsyncXbergClient(target="enterprise") as client:
            with pytest.raises(XbergError, match=message):
                await client.extract_batch([stream], document_ids=ids)
    else:
        with XbergClient(target="enterprise") as client:
            with pytest.raises(XbergError, match=message):
                client.extract_batch([stream], document_ids=ids)
    assert stream.tell() == 0
    assert len(respx.calls) == 0


@pytest.mark.asyncio
@pytest.mark.parametrize("asynchronous", [False, True])
@pytest.mark.parametrize("ids", [[DOCUMENT_ID, None], [DOCUMENT_ID, JOB_ID]])
@respx.mock
async def test_conflicting_duplicate_filenames_are_rejected(asynchronous: bool, ids) -> None:
    if asynchronous:
        async with AsyncXbergClient(target="enterprise") as client:
            with pytest.raises(XbergError, match="filename"):
                await client.extract_batch([b"a", b"b"], document_ids=ids)
    else:
        with XbergClient(target="enterprise") as client:
            with pytest.raises(XbergError, match="filename"):
                client.extract_batch([b"a", b"b"], document_ids=ids)
    assert len(respx.calls) == 0


@pytest.mark.asyncio
@pytest.mark.parametrize("asynchronous", [False, True])
@respx.mock
async def test_pro_rejects_lineage_before_reading_or_sending(asynchronous: bool) -> None:
    stream = io.BytesIO(b"unchanged")
    if asynchronous:
        async with AsyncXbergClient(target="pro", base_url="https://pro.test") as client:
            with pytest.raises(XbergError, match="enterprise"):
                await client.extract(file=stream, document_id=DOCUMENT_ID)
    else:
        with XbergClient(target="pro", base_url="https://pro.test") as client:
            with pytest.raises(XbergError, match="enterprise"):
                client.extract(file=stream, document_id=DOCUMENT_ID)
    assert stream.tell() == 0
    assert len(respx.calls) == 0


@pytest.mark.asyncio
@pytest.mark.parametrize("asynchronous", [False, True])
@pytest.mark.parametrize("ids", [[None, None], [DOCUMENT_ID, DOCUMENT_ID]])
@respx.mock
async def test_matching_duplicate_names_emit_at_most_one_lineage_part(asynchronous: bool, ids, base_url: str) -> None:
    route = respx.post(base_url + "/v1/extract").mock(
        return_value=httpx.Response(202, json=make_extract_response(job_ids=[JOB_ID]))
    )
    respx.get(base_url + "/v1/jobs/" + JOB_ID).mock(
        return_value=httpx.Response(200, json=make_job_payload(job_id=JOB_ID, status="pending"))
    )
    target = "enterprise" if ids[0] else "auto"
    if asynchronous:
        async with AsyncXbergClient(base_url=base_url, target=target) as client:
            await client.extract_batch([b"a", b"b"], document_ids=ids)
    else:
        with XbergClient(base_url=base_url, target=target) as client:
            client.extract_batch([b"a", b"b"], document_ids=ids)
    assert route.calls.last.request.content.count(b'name="document_id-upload.bin"') == (1 if ids[0] else 0)
    assert len(respx.calls) == 2


@pytest.mark.asyncio
@pytest.mark.parametrize("asynchronous", [False, True])
@respx.mock
async def test_extract_and_wait_preserves_document_id(asynchronous: bool, base_url: str) -> None:
    route = respx.post(base_url + "/v1/extract").mock(
        return_value=httpx.Response(202, json=make_extract_response(job_ids=[JOB_ID]))
    )
    respx.get(base_url + "/v1/jobs/" + JOB_ID).mock(
        return_value=httpx.Response(200, json=make_job_payload(job_id=JOB_ID, status="completed"))
    )
    if asynchronous:
        async with AsyncXbergClient(base_url=base_url, target="enterprise") as client:
            await client.extract_and_wait(file=b"a", document_id=DOCUMENT_ID)
    else:
        with XbergClient(base_url=base_url, target="enterprise") as client:
            client.extract_and_wait(file=b"a", document_id=DOCUMENT_ID)
    assert DOCUMENT_ID.encode() in route.calls.last.request.content
