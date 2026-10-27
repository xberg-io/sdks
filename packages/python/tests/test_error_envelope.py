"""Error-envelope decoding and the status-specific error classes (408, 410, 412, 428, 504)."""

from __future__ import annotations

import httpx
import pytest
import respx

from xberg_io_sdk import (
    AsyncXbergClient,
    GatewayTimeoutError,
    NotFoundError,
    PreconditionFailedError,
    PreconditionRequiredError,
    RequestTimeoutError,
    ResultExpiredError,
    ServerError,
    ValidationError,
    XbergClient,
    XbergError,
)

JOB_ID = "33333333-3333-3333-3333-333333333333"

# Byte-for-byte what the server's request-timeout layer writes: `serde_json::json!` without
# `preserve_order`, so object keys are emitted sorted.  ~keep
GATEWAY_TIMEOUT_BODY = (
    b'{"error":{"code":"gateway_timeout","details":{"limit":"handler","timeout_seconds":30},'
    b'"message":"The server did not produce a response in time"}}'
)
REQUEST_TIMEOUT_BODY = (
    b'{"error":{"code":"request_timeout","details":{"limit":"body_idle","timeout_seconds":60},'
    b'"message":"The request body stopped arriving before the upload completed"}}'
)
JSON_HEADERS = {"Content-Type": "application/json"}


def _get_job_error(base_url: str, api_key: str, response: httpx.Response) -> XbergError:
    respx.get(f"{base_url}/v1/jobs/{JOB_ID}").mock(return_value=response)
    with XbergClient(api_key=api_key, base_url=base_url) as client, pytest.raises(XbergError) as exc_info:
        client.get_job(JOB_ID)
    return exc_info.value


@respx.mock
def test_nested_504_envelope_raises_gateway_timeout_with_server_message(base_url: str, api_key: str) -> None:
    error = _get_job_error(base_url, api_key, httpx.Response(504, content=GATEWAY_TIMEOUT_BODY, headers=JSON_HEADERS))

    assert type(error) is GatewayTimeoutError
    assert isinstance(error, ServerError)
    assert str(error) == "The server did not produce a response in time"
    assert error.message == "The server did not produce a response in time"
    assert error.status == 504
    assert error.status_code == 504
    assert error.code == "gateway_timeout"
    assert error.details == {"limit": "handler", "timeout_seconds": 30}
    assert error.limit == "handler"
    assert error.timeout_seconds == 30


@respx.mock
def test_nested_408_envelope_raises_request_timeout(base_url: str, api_key: str) -> None:
    route = respx.post(f"{base_url}/v1/extract").mock(
        return_value=httpx.Response(408, content=REQUEST_TIMEOUT_BODY, headers=JSON_HEADERS)
    )
    with (
        XbergClient(api_key=api_key, base_url=base_url, retries=3) as client,
        pytest.raises(RequestTimeoutError) as exc_info,
    ):
        client.extract(file=b"x")

    error = exc_info.value
    assert str(error) == "The request body stopped arriving before the upload completed"
    assert error.status == 408
    assert error.code == "request_timeout"
    assert error.details == {"limit": "body_idle", "timeout_seconds": 60}
    assert error.limit == "body_idle"
    assert error.timeout_seconds == 60
    assert route.call_count == 1


@respx.mock
def test_flat_envelope_reads_code_from_error_and_text_from_message(base_url: str, api_key: str) -> None:
    error = _get_job_error(
        base_url, api_key, httpx.Response(404, json={"error": "not_found", "message": "no such job"})
    )

    assert type(error) is NotFoundError
    assert str(error) == "no such job"
    assert error.code == "not_found"
    assert error.details is None


@respx.mock
def test_flat_envelope_with_only_an_error_string_uses_it_as_the_message(base_url: str, api_key: str) -> None:
    error = _get_job_error(base_url, api_key, httpx.Response(400, json={"error": "bad job id"}))

    assert type(error) is ValidationError
    assert str(error) == "bad job id"
    assert error.code is None


@respx.mock
def test_flat_envelope_with_code_and_details_keys(base_url: str, api_key: str) -> None:
    error = _get_job_error(
        base_url,
        api_key,
        httpx.Response(400, json={"code": "validation", "message": "bad", "details": {"field": "job_id"}}),
    )

    assert str(error) == "bad"
    assert error.code == "validation"
    assert error.details == {"field": "job_id"}


@respx.mock
def test_body_without_a_message_falls_back_to_the_status_line(base_url: str, api_key: str) -> None:
    error = _get_job_error(base_url, api_key, httpx.Response(504, content=b"upstream timed out"))

    assert type(error) is GatewayTimeoutError
    assert str(error) == "HTTP 504 Gateway Timeout"
    assert error.code is None
    assert error.limit is None
    assert error.timeout_seconds is None


@pytest.mark.parametrize(
    ("status", "error_type", "code"),
    [
        (410, ResultExpiredError, "result_expired"),
        (412, PreconditionFailedError, "precondition_failed"),
        (428, PreconditionRequiredError, "precondition_required"),
    ],
)
@respx.mock
def test_status_maps_to_its_error_class(
    base_url: str, api_key: str, status: int, error_type: type[XbergError], code: str
) -> None:
    error = _get_job_error(
        base_url, api_key, httpx.Response(status, json={"error": {"code": code, "message": f"{code} happened"}})
    )

    assert type(error) is error_type
    assert str(error) == f"{code} happened"
    assert error.status == status
    assert error.code == code
    assert error.details is None


@pytest.mark.asyncio
@respx.mock
async def test_async_nested_504_envelope_raises_gateway_timeout(base_url: str, api_key: str) -> None:
    respx.get(f"{base_url}/v1/jobs/{JOB_ID}").mock(
        return_value=httpx.Response(504, content=GATEWAY_TIMEOUT_BODY, headers=JSON_HEADERS)
    )
    async with AsyncXbergClient(api_key=api_key, base_url=base_url) as client:
        with pytest.raises(GatewayTimeoutError) as exc_info:
            await client.get_job(JOB_ID)

    assert str(exc_info.value) == "The server did not produce a response in time"
    assert exc_info.value.limit == "handler"
    assert exc_info.value.timeout_seconds == 30
