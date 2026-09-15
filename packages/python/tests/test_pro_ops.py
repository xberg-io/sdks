"""Coverage for the data-plane operations only ``spec/pro/openapi.yaml`` declares.

``GET /v1/license`` and ``PUT /v1/uploads/local/{project_id}/{token}`` are absent from the
Enterprise spec, so both are gated to the ``pro`` tier and raise before touching the wire on
Enterprise. The local upload is the one operation in any spec whose request body is
``application/octet-stream`` rather than JSON or multipart, so it asserts the Content-Type too:
the route answers 415 without it and httpx sets none of its own for a bytes body.
"""

from __future__ import annotations

import httpx
import pytest
import respx

from xberg_io_sdk import AsyncXbergClient, XbergClient, XbergError

PRO_URL = "https://pro.example.test"
PROJECT_ID = "11111111-1111-1111-1111-111111111111"
UPLOAD_TOKEN = "cap_abc123"
UPLOAD_BYTES = b"%PDF-1.7 staged bytes"

LICENSE = {
    "state": "licensed",
    "license_id": "lic-42",
    "licensee": "Acme GmbH",
    "plan": "pro",
    "expires_at": "2027-01-01T00:00:00Z",
    "grace_days": 14,
    "days_remaining": 108,
}


# -- GET /v1/license -----------------------------------------------------------


@respx.mock
def test_get_license_info_sync(api_key: str) -> None:
    route = respx.get(f"{PRO_URL}/v1/license").mock(return_value=httpx.Response(200, json=LICENSE))
    with XbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        info = client.get_license_info()

    assert info.state == "licensed"
    assert info.licensee == "Acme GmbH"
    assert info.days_remaining == 108
    assert route.calls.last.request.method == "GET"
    assert route.calls.last.request.url.path == "/v1/license"


@respx.mock
def test_get_license_info_sync_accepts_a_state_only_body(api_key: str) -> None:
    respx.get(f"{PRO_URL}/v1/license").mock(return_value=httpx.Response(200, json={"state": "unlicensed"}))
    with XbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        info = client.get_license_info()

    assert info.state == "unlicensed"
    assert info.to_dict() == {"state": "unlicensed"}


@pytest.mark.asyncio
@respx.mock
async def test_get_license_info_async(api_key: str) -> None:
    route = respx.get(f"{PRO_URL}/v1/license").mock(return_value=httpx.Response(200, json=LICENSE))
    async with AsyncXbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        assert (await client.get_license_info()).license_id == "lic-42"

    assert route.calls.last.request.url.path == "/v1/license"


@respx.mock
def test_put_local_upload_sync_sends_raw_octet_stream(api_key: str) -> None:
    route = respx.put(f"{PRO_URL}/v1/uploads/local/{PROJECT_ID}/{UPLOAD_TOKEN}").mock(
        return_value=httpx.Response(204),
    )
    with XbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        assert client.put_local_upload(PROJECT_ID, UPLOAD_TOKEN, UPLOAD_BYTES) is None

    request = route.calls.last.request
    assert request.method == "PUT"
    assert request.url.path == f"/v1/uploads/local/{PROJECT_ID}/{UPLOAD_TOKEN}"
    assert request.headers["Content-Type"] == "application/octet-stream"
    assert request.content == UPLOAD_BYTES


@respx.mock
def test_put_local_upload_sync_escapes_a_token_that_would_retarget_the_route(api_key: str) -> None:
    route = respx.put(f"{PRO_URL}/v1/uploads/local/{PROJECT_ID}/a%2Fb").mock(return_value=httpx.Response(204))
    with XbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        client.put_local_upload(PROJECT_ID, "a/b", UPLOAD_BYTES)

    assert route.calls.last.request.url.raw_path == f"/v1/uploads/local/{PROJECT_ID}/a%2Fb".encode()


@respx.mock
def test_put_local_upload_sync_propagates_an_expired_capability(api_key: str) -> None:
    respx.put(f"{PRO_URL}/v1/uploads/local/{PROJECT_ID}/{UPLOAD_TOKEN}").mock(
        return_value=httpx.Response(404, json={"error": "capability expired"}),
    )
    with (
        XbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client,
        pytest.raises(XbergError) as error,
    ):
        client.put_local_upload(PROJECT_ID, UPLOAD_TOKEN, UPLOAD_BYTES)

    assert error.value.status_code == 404


@pytest.mark.asyncio
@respx.mock
async def test_put_local_upload_async_sends_raw_octet_stream(api_key: str) -> None:
    route = respx.put(f"{PRO_URL}/v1/uploads/local/{PROJECT_ID}/{UPLOAD_TOKEN}").mock(
        return_value=httpx.Response(204),
    )
    async with AsyncXbergClient(api_key=api_key, base_url=PRO_URL, target="pro") as client:
        assert await client.put_local_upload(PROJECT_ID, UPLOAD_TOKEN, UPLOAD_BYTES) is None

    assert route.calls.last.request.headers["Content-Type"] == "application/octet-stream"
    assert route.calls.last.request.content == UPLOAD_BYTES


# -- tier gating ---------------------------------------------------------------


@pytest.mark.parametrize(
    ("method_name", "args"),
    [
        ("get_license_info", ()),
        ("put_local_upload", (PROJECT_ID, UPLOAD_TOKEN, UPLOAD_BYTES)),
    ],
)
@respx.mock
def test_pro_only_methods_are_rejected_on_enterprise(
    base_url: str, api_key: str, method_name: str, args: tuple[object, ...]
) -> None:
    with (
        XbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client,
        pytest.raises(XbergError, match="not available on the 'enterprise' tier"),
    ):
        getattr(client, method_name)(*args)


@pytest.mark.asyncio
@respx.mock
async def test_pro_only_methods_are_rejected_on_enterprise_async(base_url: str, api_key: str) -> None:
    async with AsyncXbergClient(api_key=api_key, base_url=base_url, target="enterprise") as client:
        with pytest.raises(XbergError, match="not available on the 'enterprise' tier"):
            await client.get_license_info()
        with pytest.raises(XbergError, match="not available on the 'enterprise' tier"):
            await client.put_local_upload(PROJECT_ID, UPLOAD_TOKEN, UPLOAD_BYTES)
