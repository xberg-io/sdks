from http import HTTPStatus
from typing import Any
from urllib.parse import quote
from uuid import UUID

import httpx

from ... import errors
from ...client import AuthenticatedClient, Client
from ...models.diff_async_accepted import DiffAsyncAccepted
from ...models.diff_response import DiffResponse
from ...types import Response


def _get_kwargs(
    document_id: UUID,
    diff_job_id: UUID,
) -> dict[str, Any]:

    _kwargs: dict[str, Any] = {
        "method": "get",
        "url": "/v1/documents/{document_id}/diff/{diff_job_id}".format(
            document_id=quote(str(document_id), safe=""), diff_job_id=quote(str(diff_job_id), safe="")
        ),
    }

    return _kwargs


def _parse_response(
    *, client: AuthenticatedClient | Client, response: httpx.Response
) -> Any | DiffAsyncAccepted | DiffResponse | None:
    if response.status_code == 200:
        response_200 = DiffResponse.from_dict(response.json())

        return response_200

    if response.status_code == 202:
        response_202 = DiffAsyncAccepted.from_dict(response.json())

        return response_202

    if response.status_code == 404:
        response_404 = response.json()
        return response_404

    if response.status_code == 422:
        response_422 = response.json()
        return response_422

    if client.raise_on_unexpected_status:
        raise errors.UnexpectedStatus(response.status_code, response.content)
    return None


def _build_response(
    *, client: AuthenticatedClient | Client, response: httpx.Response
) -> Response[Any | DiffAsyncAccepted | DiffResponse]:
    return Response(
        status_code=HTTPStatus(response.status_code),
        content=response.content,
        headers=response.headers,
        parsed=_parse_response(client=client, response=response),
    )


def sync_detailed(
    document_id: UUID,
    diff_job_id: UUID,
    *,
    client: AuthenticatedClient,
) -> Response[Any | DiffAsyncAccepted | DiffResponse]:
    """Poll the status of an async diff job.

    Args:
        document_id (UUID):
        diff_job_id (UUID):

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Response[Any | DiffAsyncAccepted | DiffResponse]
    """
    kwargs = _get_kwargs(
        document_id=document_id,
        diff_job_id=diff_job_id,
    )

    response = client.get_httpx_client().request(
        **kwargs,
    )

    return _build_response(client=client, response=response)


def sync(
    document_id: UUID,
    diff_job_id: UUID,
    *,
    client: AuthenticatedClient,
) -> Any | DiffAsyncAccepted | DiffResponse | None:
    """Poll the status of an async diff job.

    Args:
        document_id (UUID):
        diff_job_id (UUID):

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Any | DiffAsyncAccepted | DiffResponse
    """
    return sync_detailed(
        document_id=document_id,
        diff_job_id=diff_job_id,
        client=client,
    ).parsed


async def asyncio_detailed(
    document_id: UUID,
    diff_job_id: UUID,
    *,
    client: AuthenticatedClient,
) -> Response[Any | DiffAsyncAccepted | DiffResponse]:
    """Poll the status of an async diff job.

    Args:
        document_id (UUID):
        diff_job_id (UUID):

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Response[Any | DiffAsyncAccepted | DiffResponse]
    """
    kwargs = _get_kwargs(
        document_id=document_id,
        diff_job_id=diff_job_id,
    )

    response = await client.get_async_httpx_client().request(**kwargs)

    return _build_response(client=client, response=response)


async def asyncio(
    document_id: UUID,
    diff_job_id: UUID,
    *,
    client: AuthenticatedClient,
) -> Any | DiffAsyncAccepted | DiffResponse | None:
    """Poll the status of an async diff job.

    Args:
        document_id (UUID):
        diff_job_id (UUID):

    Raises:
        errors.UnexpectedStatus: If the server returns an undocumented status code and Client.raise_on_unexpected_status is True.
        httpx.TimeoutException: If the request takes longer than Client.timeout.

    Returns:
        Any | DiffAsyncAccepted | DiffResponse
    """
    return (
        await asyncio_detailed(
            document_id=document_id,
            diff_job_id=diff_job_id,
            client=client,
        )
    ).parsed
