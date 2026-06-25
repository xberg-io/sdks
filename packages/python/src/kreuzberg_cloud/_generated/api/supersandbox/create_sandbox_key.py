from http import HTTPStatus
from typing import Any

import httpx

from ... import errors
from ...client import AuthenticatedClient, Client
from ...models.create_sandbox_key_response import CreateSandboxKeyResponse
from ...models.sandbox_error_response import SandboxErrorResponse
from ...types import Response


def _get_kwargs() -> dict[str, Any]:

    _kwargs: dict[str, Any] = {
        "method": "post",
        "url": "/v1/sandbox/key",
    }

    return _kwargs


def _parse_response(
    *, client: AuthenticatedClient | Client, response: httpx.Response
) -> CreateSandboxKeyResponse | SandboxErrorResponse | None:
    if response.status_code == 200:
        response_200 = CreateSandboxKeyResponse.from_dict(response.json())

        return response_200

    if response.status_code == 429:
        response_429 = SandboxErrorResponse.from_dict(response.json())

        return response_429

    if response.status_code == 500:
        response_500 = SandboxErrorResponse.from_dict(response.json())

        return response_500

    if client.raise_on_unexpected_status:
        raise errors.UnexpectedStatus(response.status_code, response.content)
    return None


def _build_response(
    *, client: AuthenticatedClient | Client, response: httpx.Response
) -> Response[CreateSandboxKeyResponse | SandboxErrorResponse]:
    return Response(
        status_code=HTTPStatus(response.status_code),
        content=response.content,
        headers=response.headers,
        parsed=_parse_response(client=client, response=response),
    )


def sync_detailed(
    *,
    client: AuthenticatedClient | Client,
) -> Response[CreateSandboxKeyResponse | SandboxErrorResponse]:
    """Create sandbox API key

     Issues an ephemeral API key valid for 24 hours with a 50-page quota.
    Limited to 10 keys per IP per 24 hours to prevent abuse.

    # Returns
    - `200 OK` with `CreateSandboxKeyResponse` on success
    - `429 Too Many Requests` if IP has issued 10+ keys in past 24 hours
    - `500 Internal Server Error` on database errors

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Response[CreateSandboxKeyResponse | SandboxErrorResponse]
    """
    kwargs = _get_kwargs()

    response = client.get_httpx_client().request(
        **kwargs,
    )

    return _build_response(client=client, response=response)


def sync(
    *,
    client: AuthenticatedClient | Client,
) -> CreateSandboxKeyResponse | SandboxErrorResponse | None:
    """Create sandbox API key

     Issues an ephemeral API key valid for 24 hours with a 50-page quota.
    Limited to 10 keys per IP per 24 hours to prevent abuse.

    # Returns
    - `200 OK` with `CreateSandboxKeyResponse` on success
    - `429 Too Many Requests` if IP has issued 10+ keys in past 24 hours
    - `500 Internal Server Error` on database errors

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        CreateSandboxKeyResponse | SandboxErrorResponse
    """
    return sync_detailed(
        client=client,
    ).parsed


async def asyncio_detailed(
    *,
    client: AuthenticatedClient | Client,
) -> Response[CreateSandboxKeyResponse | SandboxErrorResponse]:
    """Create sandbox API key

     Issues an ephemeral API key valid for 24 hours with a 50-page quota.
    Limited to 10 keys per IP per 24 hours to prevent abuse.

    # Returns
    - `200 OK` with `CreateSandboxKeyResponse` on success
    - `429 Too Many Requests` if IP has issued 10+ keys in past 24 hours
    - `500 Internal Server Error` on database errors

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Response[CreateSandboxKeyResponse | SandboxErrorResponse]
    """
    kwargs = _get_kwargs()

    response = await client.get_async_httpx_client().request(**kwargs)

    return _build_response(client=client, response=response)


async def asyncio(
    *,
    client: AuthenticatedClient | Client,
) -> CreateSandboxKeyResponse | SandboxErrorResponse | None:
    """Create sandbox API key

     Issues an ephemeral API key valid for 24 hours with a 50-page quota.
    Limited to 10 keys per IP per 24 hours to prevent abuse.

    # Returns
    - `200 OK` with `CreateSandboxKeyResponse` on success
    - `429 Too Many Requests` if IP has issued 10+ keys in past 24 hours
    - `500 Internal Server Error` on database errors

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        CreateSandboxKeyResponse | SandboxErrorResponse
    """
    return (
        await asyncio_detailed(
            client=client,
        )
    ).parsed
