"""High-level wrappers around the generated kreuzberg-cloud client.

The generated client (under :mod:`kreuzberg_cloud._generated`) is produced by
``openapi-python-client`` and exposes one function per OpenAPI operation. The
classes in this module wrap it in an idiomatic, ergonomic shape — handling
authentication, base URL configuration, and resource lifecycle — without
hiding the underlying typed models.
"""

from __future__ import annotations

import sys
from typing import TYPE_CHECKING

import httpx

if sys.version_info >= (3, 11):
    from typing import Self
else:
    from typing_extensions import Self

if TYPE_CHECKING:
    from collections.abc import Mapping
    from types import TracebackType

DEFAULT_BASE_URL = "https://api.kreuzberg.cloud"
DEFAULT_TIMEOUT_SECONDS = 30.0


class _BaseClient:
    """Shared configuration for the sync and async clients."""

    def __init__(
        self,
        *,
        api_key: str | None = None,
        base_url: str = DEFAULT_BASE_URL,
        timeout: float = DEFAULT_TIMEOUT_SECONDS,
        headers: Mapping[str, str] | None = None,
    ) -> None:
        self._api_key = api_key
        self._base_url = base_url.rstrip("/")
        self._timeout = timeout
        self._headers: dict[str, str] = {"User-Agent": "kreuzberg-cloud-python/0.0.1"}
        if headers:
            self._headers.update(headers)
        if api_key is not None:
            self._headers["Authorization"] = f"Bearer {api_key}"


class KreuzbergCloud(_BaseClient):
    """Synchronous client for the Kreuzberg Cloud API.

    This is a placeholder shell — endpoint methods are wired up after the
    generated client lands under ``kreuzberg_cloud._generated``.
    """

    def __init__(
        self,
        *,
        api_key: str | None = None,
        base_url: str = DEFAULT_BASE_URL,
        timeout: float = DEFAULT_TIMEOUT_SECONDS,
        headers: Mapping[str, str] | None = None,
    ) -> None:
        super().__init__(api_key=api_key, base_url=base_url, timeout=timeout, headers=headers)
        self._http = httpx.Client(base_url=self._base_url, timeout=self._timeout, headers=self._headers)

    def __enter__(self) -> Self:
        """Enter the context manager."""
        return self

    def __exit__(
        self,
        exc_type: type[BaseException] | None,
        exc_val: BaseException | None,
        exc_tb: TracebackType | None,
    ) -> None:
        """Exit the context manager and close the underlying HTTP transport."""
        self.close()

    def close(self) -> None:
        """Close the underlying HTTP transport, releasing connections."""
        self._http.close()


class AsyncKreuzbergCloud(_BaseClient):
    """Asynchronous client for the Kreuzberg Cloud API.

    This is a placeholder shell — endpoint methods are wired up after the
    generated client lands under ``kreuzberg_cloud._generated``.
    """

    def __init__(
        self,
        *,
        api_key: str | None = None,
        base_url: str = DEFAULT_BASE_URL,
        timeout: float = DEFAULT_TIMEOUT_SECONDS,
        headers: Mapping[str, str] | None = None,
    ) -> None:
        super().__init__(api_key=api_key, base_url=base_url, timeout=timeout, headers=headers)
        self._http = httpx.AsyncClient(base_url=self._base_url, timeout=self._timeout, headers=self._headers)

    async def __aenter__(self) -> Self:
        """Enter the async context manager."""
        return self

    async def __aexit__(
        self,
        exc_type: type[BaseException] | None,
        exc_val: BaseException | None,
        exc_tb: TracebackType | None,
    ) -> None:
        """Exit the async context manager and close the underlying HTTP transport."""
        await self.aclose()

    async def aclose(self) -> None:
        """Close the underlying async HTTP transport, releasing connections."""
        await self._http.aclose()
