from http import HTTPStatus
from typing import Any

import httpx

from ... import errors
from ...client import AuthenticatedClient, Client
from ...models.presign_upload_request import PresignUploadRequest
from ...models.presign_upload_response import PresignUploadResponse
from ...types import Response


def _get_kwargs(
    *,
    body: PresignUploadRequest,
) -> dict[str, Any]:
    headers: dict[str, Any] = {}

    _kwargs: dict[str, Any] = {
        "method": "post",
        "url": "/v1/uploads/presign",
    }

    _kwargs["json"] = body.to_dict()

    headers["Content-Type"] = "application/json"

    _kwargs["headers"] = headers
    return _kwargs


def _parse_response(
    *, client: AuthenticatedClient | Client, response: httpx.Response
) -> Any | PresignUploadResponse | None:
    if response.status_code == 200:
        response_200 = PresignUploadResponse.from_dict(response.json())

        return response_200

    if response.status_code == 400:
        response_400 = response.json()
        return response_400

    if response.status_code == 401:
        response_401 = response.json()
        return response_401

    if client.raise_on_unexpected_status:
        raise errors.UnexpectedStatus(response.status_code, response.content)
    return None


def _build_response(
    *, client: AuthenticatedClient | Client, response: httpx.Response
) -> Response[Any | PresignUploadResponse]:
    return Response(
        status_code=HTTPStatus(response.status_code),
        content=response.content,
        headers=response.headers,
        parsed=_parse_response(client=client, response=response),
    )


def sync_detailed(
    *,
    client: AuthenticatedClient,
    body: PresignUploadRequest,
) -> Response[Any | PresignUploadResponse]:
    """Generate presigned upload URLs

     Returns upload URLs for each document. The client uploads files directly
    to storage, then calls `/v1/uploads/confirm` to trigger processing.

    Args:
        body (PresignUploadRequest): Request body for presigning upload URLs

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Response[Any | PresignUploadResponse]
    """
    kwargs = _get_kwargs(
        body=body,
    )

    response = client.get_httpx_client().request(
        **kwargs,
    )

    return _build_response(client=client, response=response)


def sync(
    *,
    client: AuthenticatedClient,
    body: PresignUploadRequest,
) -> Any | PresignUploadResponse | None:
    """Generate presigned upload URLs

     Returns upload URLs for each document. The client uploads files directly
    to storage, then calls `/v1/uploads/confirm` to trigger processing.

    Args:
        body (PresignUploadRequest): Request body for presigning upload URLs

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Any | PresignUploadResponse
    """
    return sync_detailed(
        client=client,
        body=body,
    ).parsed


async def asyncio_detailed(
    *,
    client: AuthenticatedClient,
    body: PresignUploadRequest,
) -> Response[Any | PresignUploadResponse]:
    """Generate presigned upload URLs

     Returns upload URLs for each document. The client uploads files directly
    to storage, then calls `/v1/uploads/confirm` to trigger processing.

    Args:
        body (PresignUploadRequest): Request body for presigning upload URLs

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Response[Any | PresignUploadResponse]
    """
    kwargs = _get_kwargs(
        body=body,
    )

    response = await client.get_async_httpx_client().request(**kwargs)

    return _build_response(client=client, response=response)


async def asyncio(
    *,
    client: AuthenticatedClient,
    body: PresignUploadRequest,
) -> Any | PresignUploadResponse | None:
    """Generate presigned upload URLs

     Returns upload URLs for each document. The client uploads files directly
    to storage, then calls `/v1/uploads/confirm` to trigger processing.

    Args:
        body (PresignUploadRequest): Request body for presigning upload URLs

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Any | PresignUploadResponse
    """
    return (
        await asyncio_detailed(
            client=client,
            body=body,
        )
    ).parsed
