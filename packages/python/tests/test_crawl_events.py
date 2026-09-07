"""Coverage for ``stream_crawl_events`` — the Enterprise-only SSE feed of a crawl job's progress.

``GET /v1/crawl-jobs/{id}/events`` is the one operation in the Enterprise spec that answers
``text/event-stream`` rather than JSON, so it is also the one that cannot reuse the request
helpers: the retry engine would replay a partly-consumed stream, and the response body has to
be closed on every exit path rather than read to completion. The frames it sends are SSE
frames -- terminated by a blank line, payload spread over any number of ``data:`` lines, with
comment lines carrying the 15s heartbeat -- so the tests below feed exactly those shapes
rather than one compact JSON object per line, which a line-oriented decoder would also pass.
"""

from __future__ import annotations

import json
import uuid
from typing import TYPE_CHECKING, Any

import httpx
import pytest
import respx

from xberg_io_sdk import AsyncXbergClient, XbergClient, XbergError

if TYPE_CHECKING:
    from collections.abc import AsyncIterator, Iterator

PRO_URL = "https://pro.example.test"
CRAWL_JOB_ID = "7c9e6679-7425-40de-944b-e07fc1f90ae7"
EVENTS_PATH = f"/v1/crawl-jobs/{CRAWL_JOB_ID}/events"
TS = "2026-05-09T10:00:00Z"

PAGE_EVENT = {
    "kind": "page",
    "crawl_job_id": CRAWL_JOB_ID,
    "ts": TS,
    "url": "https://example.com/docs",
    "status_code": 200,
    "depth": 1,
}
DISCOVERED_EVENT = {
    "kind": "discovered",
    "crawl_job_id": CRAWL_JOB_ID,
    "ts": TS,
    "url": "https://example.com/docs/api",
    "depth": 2,
}
ERROR_EVENT = {
    "kind": "error",
    "crawl_job_id": CRAWL_JOB_ID,
    "ts": TS,
    "url": "https://example.com/gone",
    "error": "404 Not Found",
}
COMPLETE_EVENT = {
    "kind": "complete",
    "crawl_job_id": CRAWL_JOB_ID,
    "ts": TS,
    "pages_crawled": 12,
}


class RecordingStream(httpx.SyncByteStream, httpx.AsyncByteStream):
    """A response body that records whether the client closed it.

    Serves both transports so one fixture proves the leak-freedom property for
    the sync and async clients alike. ``chunks`` are handed out verbatim, which
    lets a test split a frame across reads.
    """

    def __init__(self, chunks: list[bytes]) -> None:
        self._chunks = chunks
        self.closed = False

    def __iter__(self) -> Iterator[bytes]:
        yield from self._chunks

    async def __aiter__(self) -> AsyncIterator[bytes]:
        for chunk in self._chunks:
            yield chunk

    def close(self) -> None:
        self.closed = True

    async def aclose(self) -> None:
        self.closed = True


def sse(*frames: str) -> bytes:
    """Join pre-rendered SSE frames into a response body."""
    return "".join(frames).encode()


def data_frame(payload: str) -> str:
    """Render one single-line ``data:`` frame, blank-line terminated."""
    return f"data: {payload}\n\n"


def json_frame(event: dict[str, Any]) -> str:
    """Render one compact JSON event as a single-line SSE frame."""
    return data_frame(json.dumps(event))


def stream_response(body: bytes) -> tuple[httpx.Response, RecordingStream]:
    """Build a 200 ``text/event-stream`` response over a close-recording body."""
    stream = RecordingStream([body])
    response = httpx.Response(200, headers={"Content-Type": "text/event-stream"}, stream=stream)
    return response, stream


def enterprise_client(base_url: str, api_key: str, **kwargs: Any) -> XbergClient:
    """Build a sync client pinned to the Enterprise tier so no ``/healthz`` probe is needed."""
    return XbergClient(api_key=api_key, base_url=base_url, target="enterprise", **kwargs)


# -- frame parsing -------------------------------------------------------------


@respx.mock
def test_stream_crawl_events_parses_every_kind(base_url: str, api_key: str) -> None:
    body = sse(
        json_frame(PAGE_EVENT),
        json_frame(DISCOVERED_EVENT),
        json_frame(ERROR_EVENT),
        json_frame(COMPLETE_EVENT),
    )
    response, _ = stream_response(body)
    route = respx.get(f"{base_url}{EVENTS_PATH}").mock(return_value=response)

    with enterprise_client(base_url, api_key) as client:
        events = list(client.stream_crawl_events(CRAWL_JOB_ID))

    assert [event.kind for event in events] == ["page", "discovered", "error", "complete"]
    assert events[0].url == "https://example.com/docs"
    assert events[0].status_code == 200
    assert events[0].depth == 1
    assert str(events[0].crawl_job_id) == CRAWL_JOB_ID
    assert events[1].depth == 2
    assert events[2].error == "404 Not Found"
    assert events[3].pages_crawled == 12
    assert route.calls.last.request.headers["Accept"] == "text/event-stream"
    assert route.calls.last.request.url.path == EVENTS_PATH


@respx.mock
def test_stream_crawl_events_joins_multiline_data_and_skips_comments(base_url: str, api_key: str) -> None:
    """A payload split over several ``data:`` lines is one event, and comments are not frames.

    This is the case a per-line ``json.loads`` gets wrong in both directions: it
    raises on the heartbeat comment, and it sees three broken fragments where
    the server sent one object.
    """
    multiline = (
        ": heartbeat\n"
        "event: message\n"
        "id: 42\n"
        "data: {\n"
        'data:   "kind": "page", "crawl_job_id": "' + CRAWL_JOB_ID + '",\n'
        'data:   "ts": "' + TS + '", "url": "https://example.com/split",\n'
        'data:   "status_code": 201, "depth": 3\n'
        "data: }\n"
        "\n"
        ": heartbeat\n"
        "\n"
    )
    response, _ = stream_response(sse(multiline, json_frame(COMPLETE_EVENT)))
    respx.get(f"{base_url}{EVENTS_PATH}").mock(return_value=response)

    with enterprise_client(base_url, api_key) as client:
        events = list(client.stream_crawl_events(CRAWL_JOB_ID))

    assert [event.kind for event in events] == ["page", "complete"]
    assert events[0].url == "https://example.com/split"
    assert events[0].status_code == 201
    assert events[0].depth == 3


@respx.mock
def test_stream_crawl_events_tolerates_data_without_the_optional_space(base_url: str, api_key: str) -> None:
    """``data:{...}`` and ``data: {...}`` are the same frame — only ONE leading space is framing."""
    frame = "data:" + json.dumps(PAGE_EVENT) + "\n\n"
    response, _ = stream_response(sse(frame))
    respx.get(f"{base_url}{EVENTS_PATH}").mock(return_value=response)

    with enterprise_client(base_url, api_key) as client:
        events = list(client.stream_crawl_events(CRAWL_JOB_ID))

    assert [event.kind for event in events] == ["page"]


@respx.mock
def test_stream_crawl_events_discards_a_frame_the_stream_ended_mid_way(base_url: str, api_key: str) -> None:
    """A trailing frame with no terminating blank line is incomplete, and the spec discards it."""
    body = sse(json_frame(PAGE_EVENT), "data: " + json.dumps(COMPLETE_EVENT) + "\n")
    response, _ = stream_response(body)
    respx.get(f"{base_url}{EVENTS_PATH}").mock(return_value=response)

    with enterprise_client(base_url, api_key) as client:
        events = list(client.stream_crawl_events(CRAWL_JOB_ID))

    assert [event.kind for event in events] == ["page"]


@respx.mock
def test_stream_crawl_events_rejects_an_unrecognized_kind(base_url: str, api_key: str) -> None:
    response, _ = stream_response(sse(json_frame({**PAGE_EVENT, "kind": "teleported"})))
    respx.get(f"{base_url}{EVENTS_PATH}").mock(return_value=response)

    with enterprise_client(base_url, api_key) as client, pytest.raises(XbergError, match="unexpected crawl event kind"):
        list(client.stream_crawl_events(CRAWL_JOB_ID))


# -- cancellation --------------------------------------------------------------


@respx.mock
def test_stream_crawl_events_closes_the_body_when_the_caller_stops_early(base_url: str, api_key: str) -> None:
    """Breaking out of the loop must hang up, not leave the subscription open."""
    body = sse(json_frame(PAGE_EVENT), json_frame(DISCOVERED_EVENT), json_frame(COMPLETE_EVENT))
    response, stream = stream_response(body)
    respx.get(f"{base_url}{EVENTS_PATH}").mock(return_value=response)

    with enterprise_client(base_url, api_key) as client:
        events = client.stream_crawl_events(CRAWL_JOB_ID)
        for event in events:
            assert event.kind == "page"
            break
        assert not stream.closed, "closing happens on generator teardown, not on the first yield"
        events.close()
        assert stream.closed


@respx.mock
def test_stream_crawl_events_closes_the_body_when_the_stream_is_exhausted(base_url: str, api_key: str) -> None:
    response, stream = stream_response(sse(json_frame(COMPLETE_EVENT)))
    respx.get(f"{base_url}{EVENTS_PATH}").mock(return_value=response)

    with enterprise_client(base_url, api_key) as client:
        assert [event.kind for event in client.stream_crawl_events(CRAWL_JOB_ID)] == ["complete"]

    assert stream.closed


# -- retry policy --------------------------------------------------------------


@respx.mock
def test_stream_crawl_events_is_not_retried(base_url: str, api_key: str) -> None:
    """A retryable status must surface, not be replayed: a re-subscribed stream redelivers events."""
    route = respx.get(f"{base_url}{EVENTS_PATH}").mock(return_value=httpx.Response(503, json={"error": "no NATS"}))

    with enterprise_client(base_url, api_key, retries=3) as client, pytest.raises(XbergError) as excinfo:
        list(client.stream_crawl_events(CRAWL_JOB_ID))

    assert excinfo.value.status_code == 503
    assert route.call_count == 1


@respx.mock
def test_stream_crawl_events_raises_the_typed_error_for_a_missing_job(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}{EVENTS_PATH}").mock(return_value=httpx.Response(404, json={"error": "no such crawl job"}))

    with enterprise_client(base_url, api_key) as client, pytest.raises(XbergError) as excinfo:
        list(client.stream_crawl_events(CRAWL_JOB_ID))

    assert excinfo.value.status_code == 404


# -- tier gate -----------------------------------------------------------------


@respx.mock
def test_stream_crawl_events_refuses_on_pro(api_key: str) -> None:
    route = respx.get(f"{PRO_URL}{EVENTS_PATH}")

    with (
        XbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client,
        pytest.raises(XbergError, match="not available on the 'pro' tier"),
    ):
        list(client.stream_crawl_events(CRAWL_JOB_ID))

    assert route.call_count == 0


@respx.mock
async def test_stream_crawl_events_refuses_on_pro_async(api_key: str) -> None:
    route = respx.get(f"{PRO_URL}{EVENTS_PATH}")

    async with AsyncXbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        with pytest.raises(XbergError, match="not available on the 'pro' tier"):
            async for _ in client.stream_crawl_events(CRAWL_JOB_ID):
                pass

    assert route.call_count == 0


# -- the async twin: same framing and teardown, driven by ``async for`` --------


@respx.mock
async def test_stream_crawl_events_async_parses_every_kind(base_url: str, api_key: str) -> None:
    body = sse(
        json_frame(PAGE_EVENT),
        json_frame(DISCOVERED_EVENT),
        json_frame(ERROR_EVENT),
        json_frame(COMPLETE_EVENT),
    )
    response, _ = stream_response(body)
    respx.get(f"{base_url}{EVENTS_PATH}").mock(return_value=response)

    async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        events = [event async for event in client.stream_crawl_events(CRAWL_JOB_ID)]

    assert [event.kind for event in events] == ["page", "discovered", "error", "complete"]
    assert events[3].pages_crawled == 12


@respx.mock
async def test_stream_crawl_events_async_closes_the_body_when_the_caller_stops_early(
    base_url: str,
    api_key: str,
) -> None:
    body = sse(json_frame(PAGE_EVENT), json_frame(DISCOVERED_EVENT), json_frame(COMPLETE_EVENT))
    response, stream = stream_response(body)
    respx.get(f"{base_url}{EVENTS_PATH}").mock(return_value=response)

    async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        events = client.stream_crawl_events(CRAWL_JOB_ID)
        async for event in events:
            assert event.kind == "page"
            break
        await events.aclose()
        assert stream.closed


@respx.mock
async def test_stream_crawl_events_async_joins_multiline_data(base_url: str, api_key: str) -> None:
    multiline = (
        ": heartbeat\n"
        "data: {\n"
        'data:   "kind": "complete", "crawl_job_id": "' + CRAWL_JOB_ID + '",\n'
        'data:   "ts": "' + TS + '", "pages_crawled": 7\n'
        "data: }\n"
        "\n"
    )
    response, _ = stream_response(sse(multiline))
    respx.get(f"{base_url}{EVENTS_PATH}").mock(return_value=response)

    async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        events = [event async for event in client.stream_crawl_events(CRAWL_JOB_ID)]

    assert len(events) == 1
    assert events[0].kind == "complete"
    assert events[0].pages_crawled == 7
    assert events[0].crawl_job_id == uuid.UUID(CRAWL_JOB_ID)


@respx.mock
def test_stream_crawl_events_rejects_a_frame_that_never_closes(base_url: str, api_key: str) -> None:
    """A succession of ``data:`` lines with no terminating blank line is capped, not buffered forever."""
    # 17 x 64 KiB carries the frame past the 1 MiB cap without any one line
    # being unusually long -- the shape a per-line cap alone would miss.
    body = ("data: " + "x" * (64 * 1024) + "\n") * 17
    response, _ = stream_response(body.encode())
    respx.get(f"{base_url}{EVENTS_PATH}").mock(return_value=response)

    with enterprise_client(base_url, api_key) as client, pytest.raises(XbergError, match="exceeded"):
        list(client.stream_crawl_events(CRAWL_JOB_ID))


@pytest.mark.parametrize("asynchronous", [False, True])
@pytest.mark.parametrize("prefix", [b"data: ", b":", b"unknown:"])
@respx.mock
async def test_stream_rejects_unterminated_lines_before_reading_the_remaining_body(
    base_url: str, api_key: str, asynchronous: bool, prefix: bytes
) -> None:
    class EndlessLine(RecordingStream):
        def __init__(self) -> None:
            super().__init__([])
            self.reads = 0

        def __iter__(self) -> Iterator[bytes]:
            yield prefix
            for _ in range(64):
                self.reads += 1
                yield b"x" * (64 * 1024)

        async def __aiter__(self) -> AsyncIterator[bytes]:
            for chunk in self:
                yield chunk

    stream = EndlessLine()
    respx.get(f"{base_url}{EVENTS_PATH}").respond(200, stream=stream)
    if asynchronous:
        async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
            with pytest.raises(XbergError, match="exceeded"):
                _ = [event async for event in client.stream_crawl_events(CRAWL_JOB_ID)]
    else:
        with enterprise_client(base_url, api_key) as sync_client, pytest.raises(XbergError, match="exceeded"):
            list(sync_client.stream_crawl_events(CRAWL_JOB_ID))
    assert stream.reads == 16
    assert stream.closed


@pytest.mark.parametrize("asynchronous", [False, True])
@respx.mock
async def test_stream_caps_multiline_frames_in_utf8_bytes(base_url: str, api_key: str, asynchronous: bool) -> None:
    stream = RecordingStream([("data: " + "é" * (32 * 1024) + "\n").encode()] * 17)
    respx.get(f"{base_url}{EVENTS_PATH}").respond(200, stream=stream)
    if asynchronous:
        async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
            with pytest.raises(XbergError, match="exceeded"):
                _ = [event async for event in client.stream_crawl_events(CRAWL_JOB_ID)]
    else:
        with enterprise_client(base_url, api_key) as sync_client, pytest.raises(XbergError, match="exceeded"):
            list(sync_client.stream_crawl_events(CRAWL_JOB_ID))
    assert stream.closed


@pytest.mark.parametrize("asynchronous", [False, True])
@pytest.mark.parametrize("separator", ["\n", "\r", "\r\n"])
@respx.mock
async def test_stream_preserves_split_utf8_and_line_terminators(
    base_url: str, api_key: str, asynchronous: bool, separator: str
) -> None:
    message = "é\u2028終"
    body = ("data: " + json.dumps({**ERROR_EVENT, "error": message}, ensure_ascii=False) + separator * 2).encode()
    stream = RecordingStream([body[index : index + 1] for index in range(len(body))])
    respx.get(f"{base_url}{EVENTS_PATH}").respond(200, stream=stream)
    if asynchronous:
        async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
            events = [event async for event in client.stream_crawl_events(CRAWL_JOB_ID)]
    else:
        with enterprise_client(base_url, api_key) as sync_client:
            events = list(sync_client.stream_crawl_events(CRAWL_JOB_ID))
    assert len(events) == 1
    assert events[0].error == message
    assert stream.closed


@pytest.mark.parametrize("asynchronous", [False, True])
@respx.mock
async def test_stream_accepts_exact_limit_lines_in_a_larger_chunk(
    base_url: str, api_key: str, asynchronous: bool
) -> None:
    body = b":" + b"x" * ((1 << 20) - 1) + b"\r\n" + sse(json_frame(COMPLETE_EVENT))
    response, stream = stream_response(body)
    respx.get(f"{base_url}{EVENTS_PATH}").mock(return_value=response)
    if asynchronous:
        async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
            events = [event async for event in client.stream_crawl_events(CRAWL_JOB_ID)]
    else:
        with enterprise_client(base_url, api_key) as sync_client:
            events = list(sync_client.stream_crawl_events(CRAWL_JOB_ID))
    assert [event.kind for event in events] == ["complete"]
    assert stream.closed
