from http import HTTPStatus
from typing import Any

import httpx

from ... import errors
from ...client import AuthenticatedClient, Client
from ...models.extract_json_request import ExtractJsonRequest
from ...models.extract_response import ExtractResponse
from ...types import Response


def _get_kwargs(
    *,
    body: ExtractJsonRequest,
) -> dict[str, Any]:
    headers: dict[str, Any] = {}

    _kwargs: dict[str, Any] = {
        "method": "post",
        "url": "/v1/extract",
    }

    _kwargs["json"] = body.to_dict()

    headers["Content-Type"] = "application/json"

    _kwargs["headers"] = headers
    return _kwargs


def _parse_response(*, client: AuthenticatedClient | Client, response: httpx.Response) -> Any | ExtractResponse | None:
    if response.status_code == 202:
        response_202 = ExtractResponse.from_dict(response.json())

        return response_202

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
) -> Response[Any | ExtractResponse]:
    return Response(
        status_code=HTTPStatus(response.status_code),
        content=response.content,
        headers=response.headers,
        parsed=_parse_response(client=client, response=response),
    )


def sync_detailed(
    *,
    client: AuthenticatedClient,
    body: ExtractJsonRequest,
) -> Response[Any | ExtractResponse]:
    r"""`POST /v1/extract` — Submit documents for extraction

     Accepts `application/json` or `multipart/form-data`.

    **JSON body**: `{\"documents\": [...], \"options\": {...}, \"webhook\": {\"url\": \"...\",
    \"secret\": \"...\", \"metadata\": {...}}}`

    **Multipart**: file parts (binary) + `webhook` part (JSON string) + optional `options` part (JSON
    string)

    Returns 202 Accepted with job IDs. Results are delivered via the configured webhook.

    Args:
        body (ExtractJsonRequest): JSON body for `POST /v1/extract`

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Response[Any | ExtractResponse]
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
    body: ExtractJsonRequest,
) -> Any | ExtractResponse | None:
    r"""`POST /v1/extract` — Submit documents for extraction

     Accepts `application/json` or `multipart/form-data`.

    **JSON body**: `{\"documents\": [...], \"options\": {...}, \"webhook\": {\"url\": \"...\",
    \"secret\": \"...\", \"metadata\": {...}}}`

    **Multipart**: file parts (binary) + `webhook` part (JSON string) + optional `options` part (JSON
    string)

    Returns 202 Accepted with job IDs. Results are delivered via the configured webhook.

    Args:
        body (ExtractJsonRequest): JSON body for `POST /v1/extract`

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Any | ExtractResponse
    """
    return sync_detailed(
        client=client,
        body=body,
    ).parsed


async def asyncio_detailed(
    *,
    client: AuthenticatedClient,
    body: ExtractJsonRequest,
) -> Response[Any | ExtractResponse]:
    r"""`POST /v1/extract` — Submit documents for extraction

     Accepts `application/json` or `multipart/form-data`.

    **JSON body**: `{\"documents\": [...], \"options\": {...}, \"webhook\": {\"url\": \"...\",
    \"secret\": \"...\", \"metadata\": {...}}}`

    **Multipart**: file parts (binary) + `webhook` part (JSON string) + optional `options` part (JSON
    string)

    Returns 202 Accepted with job IDs. Results are delivered via the configured webhook.

    Args:
        body (ExtractJsonRequest): JSON body for `POST /v1/extract`

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Response[Any | ExtractResponse]
    """
    kwargs = _get_kwargs(
        body=body,
    )

    response = await client.get_async_httpx_client().request(**kwargs)

    return _build_response(client=client, response=response)


async def asyncio(
    *,
    client: AuthenticatedClient,
    body: ExtractJsonRequest,
) -> Any | ExtractResponse | None:
    r"""`POST /v1/extract` — Submit documents for extraction

     Accepts `application/json` or `multipart/form-data`.

    **JSON body**: `{\"documents\": [...], \"options\": {...}, \"webhook\": {\"url\": \"...\",
    \"secret\": \"...\", \"metadata\": {...}}}`

    **Multipart**: file parts (binary) + `webhook` part (JSON string) + optional `options` part (JSON
    string)

    Returns 202 Accepted with job IDs. Results are delivered via the configured webhook.

    Args:
        body (ExtractJsonRequest): JSON body for `POST /v1/extract`

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Any | ExtractResponse
    """
    return (
        await asyncio_detailed(
            client=client,
            body=body,
        )
    ).parsed
