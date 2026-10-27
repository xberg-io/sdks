"""Method-aware retries: 502/503/504 replay only idempotent methods unless the caller opts in."""

from __future__ import annotations

import httpx
import pytest
import respx

from tests.conftest import make_extract_response, make_job_payload
from xberg_io_sdk import AsyncXbergClient, GatewayTimeoutError, RequestTimeoutError, XbergClient, XbergError
from xberg_io_sdk import client as client_module

JOB_ID = "44444444-4444-4444-4444-444444444444"
GATEWAY_TIMEOUT = {"error": {"code": "gateway_timeout", "message": "The server did not produce a response in time"}}


@pytest.fixture
def sleeps(monkeypatch: pytest.MonkeyPatch) -> list[float]:
    recorded: list[float] = []
    monkeypatch.setattr(client_module.time, "sleep", recorded.append)
    return recorded


@pytest.fixture
def no_async_sleep(monkeypatch: pytest.MonkeyPatch) -> None:
    async def _no_sleep(_seconds: float) -> None:
        return None

    monkeypatch.setattr(client_module.asyncio, "sleep", _no_sleep)


@respx.mock
def test_post_is_not_retried_on_504_by_default(base_url: str, api_key: str, sleeps: list[float]) -> None:
    route = respx.post(f"{base_url}/v1/extract").mock(return_value=httpx.Response(504, json=GATEWAY_TIMEOUT))

    with XbergClient(api_key=api_key, base_url=base_url, retries=3) as client, pytest.raises(GatewayTimeoutError):
        client.extract(file=b"x")

    assert route.call_count == 1
    assert sleeps == []


@pytest.mark.parametrize("status", [502, 503])
@respx.mock
def test_post_is_not_retried_on_other_gateway_statuses(
    base_url: str, api_key: str, sleeps: list[float], status: int
) -> None:
    route = respx.post(f"{base_url}/v1/rag/collections").mock(return_value=httpx.Response(status, json={}))

    with XbergClient(api_key=api_key, base_url=base_url, retries=3) as client, pytest.raises(XbergError):
        client.create_rag_collection({"name": "docs"})

    assert route.call_count == 1
    assert sleeps == []


@respx.mock
def test_get_is_retried_on_504(base_url: str, api_key: str, sleeps: list[float]) -> None:
    route = respx.get(f"{base_url}/v1/rag/collections").mock(
        side_effect=[httpx.Response(504, json=GATEWAY_TIMEOUT), httpx.Response(200, json={"collections": []})]
    )

    with XbergClient(api_key=api_key, base_url=base_url, retries=3) as client:
        assert client.list_rag_collections() == {"collections": []}

    assert route.call_count == 2
    assert sleeps == [pytest.approx(0.2)]


@respx.mock
def test_put_and_delete_are_retried_on_503(base_url: str, api_key: str, sleeps: list[float]) -> None:
    put = respx.put(f"{base_url}/v1/projects/p1/rag-config").mock(
        side_effect=[httpx.Response(503, json={}), httpx.Response(200, json={"enabled": True})]
    )
    delete = respx.delete(f"{base_url}/v1/rag/collections/docs").mock(
        side_effect=[httpx.Response(503, json={}), httpx.Response(204)]
    )

    with XbergClient(api_key=api_key, base_url=base_url, retries=1, target="pro") as client:
        assert client.set_rag_config("p1", {"enabled": True}) == {"enabled": True}
        client.delete_rag_collection("docs")

    assert put.call_count == 2
    assert delete.call_count == 2


@respx.mock
def test_post_is_retried_on_429_honouring_retry_after(base_url: str, api_key: str, sleeps: list[float]) -> None:
    route = respx.post(f"{base_url}/v1/extract").mock(
        side_effect=[
            httpx.Response(429, headers={"Retry-After": "3"}, json={"error": {"code": "rate_limited", "message": "x"}}),
            httpx.Response(202, json=make_extract_response(job_ids=[JOB_ID])),
        ]
    )
    respx.get(f"{base_url}/v1/jobs/{JOB_ID}").mock(
        return_value=httpx.Response(200, json=make_job_payload(job_id=JOB_ID))
    )

    with XbergClient(api_key=api_key, base_url=base_url, retries=2) as client:
        job = client.extract(file=b"x")

    assert str(job.id) == JOB_ID
    assert route.call_count == 2
    assert sleeps == [pytest.approx(3.0)]


@respx.mock
def test_post_is_retried_on_504_when_the_client_opts_in(base_url: str, api_key: str, sleeps: list[float]) -> None:
    route = respx.post(f"{base_url}/v1/rag/collections").mock(
        side_effect=[httpx.Response(504, json=GATEWAY_TIMEOUT), httpx.Response(201, json={"name": "docs"})]
    )

    with XbergClient(api_key=api_key, base_url=base_url, retries=2, retry_non_idempotent=True) as client:
        assert client.create_rag_collection({"name": "docs"}) == {"name": "docs"}

    assert route.call_count == 2
    assert sleeps == [pytest.approx(0.2)]


@respx.mock
def test_408_is_not_retried_by_default_even_for_get(base_url: str, api_key: str, sleeps: list[float]) -> None:
    route = respx.get(f"{base_url}/v1/rag/collections").mock(return_value=httpx.Response(408, json={}))

    with XbergClient(api_key=api_key, base_url=base_url, retries=3) as client, pytest.raises(RequestTimeoutError):
        client.list_rag_collections()

    assert route.call_count == 1


@respx.mock
def test_retry_on_override_still_gates_non_idempotent_methods(base_url: str, api_key: str, sleeps: list[float]) -> None:
    get = respx.get(f"{base_url}/v1/rag/collections").mock(
        side_effect=[httpx.Response(500, json={}), httpx.Response(200, json={"collections": []})]
    )
    post = respx.post(f"{base_url}/v1/rag/collections").mock(return_value=httpx.Response(500, json={}))

    with XbergClient(api_key=api_key, base_url=base_url, retries=1, retry_on=[500]) as client:
        assert client.list_rag_collections() == {"collections": []}
        with pytest.raises(XbergError):
            client.create_rag_collection({"name": "docs"})

    assert get.call_count == 2
    assert post.call_count == 1


@pytest.mark.asyncio
@pytest.mark.usefixtures("no_async_sleep")
@respx.mock
async def test_async_post_not_retried_on_504_but_get_is(base_url: str, api_key: str) -> None:
    post = respx.post(f"{base_url}/v1/extract").mock(return_value=httpx.Response(504, json=GATEWAY_TIMEOUT))
    get = respx.get(f"{base_url}/v1/rag/collections").mock(
        side_effect=[httpx.Response(504, json=GATEWAY_TIMEOUT), httpx.Response(200, json={"collections": []})]
    )

    async with AsyncXbergClient(api_key=api_key, base_url=base_url, retries=3) as client:
        with pytest.raises(GatewayTimeoutError):
            await client.extract(file=b"x")
        assert await client.list_rag_collections() == {"collections": []}

    assert post.call_count == 1
    assert get.call_count == 2


@pytest.mark.asyncio
@pytest.mark.usefixtures("no_async_sleep")
@respx.mock
async def test_async_post_retried_on_429_and_on_504_when_opted_in(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}/v1/rag/collections").mock(
        side_effect=[
            httpx.Response(429, json={}),
            httpx.Response(504, json=GATEWAY_TIMEOUT),
            httpx.Response(201, json={"name": "docs"}),
        ]
    )

    async with AsyncXbergClient(api_key=api_key, base_url=base_url, retries=2, retry_non_idempotent=True) as client:
        assert await client.create_rag_collection({"name": "docs"}) == {"name": "docs"}

    assert route.call_count == 3
