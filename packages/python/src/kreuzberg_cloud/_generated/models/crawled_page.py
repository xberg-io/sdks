from __future__ import annotations

import datetime
from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from dateutil.parser import isoparse
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="CrawledPage")


@_attrs_define
class CrawledPage:
    """A raw crawled page persisted for output_mode=scrape|crawl.

    Example:
        {'url': 'https://example.com/docs/index.html', 'status': 'completed', 'mime_type': 'text/html', 'size_bytes':
            12345, 'fetched_at': '2025-12-21T10:00:00Z'}

    Attributes:
        fetched_at (datetime.datetime): Fetch timestamp (RFC3339) Example: 2025-12-21T10:00:00Z.
        status (str): Fetch status: "completed" | "failed" Example: completed.
        url (str): Source URL Example: https://example.com/docs/index.html.
        content_url (None | str | Unset): Presigned URL for downloading the raw content
        error (None | str | Unset): Error message (when status=failed)
        mime_type (None | str | Unset): MIME type Example: text/html.
        size_bytes (int | None | Unset): Size in bytes Example: 12345.
    """

    fetched_at: datetime.datetime
    status: str
    url: str
    content_url: None | str | Unset = UNSET
    error: None | str | Unset = UNSET
    mime_type: None | str | Unset = UNSET
    size_bytes: int | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        fetched_at = self.fetched_at.isoformat()

        status = self.status

        url = self.url

        content_url: None | str | Unset
        if isinstance(self.content_url, Unset):
            content_url = UNSET
        else:
            content_url = self.content_url

        error: None | str | Unset
        if isinstance(self.error, Unset):
            error = UNSET
        else:
            error = self.error

        mime_type: None | str | Unset
        if isinstance(self.mime_type, Unset):
            mime_type = UNSET
        else:
            mime_type = self.mime_type

        size_bytes: int | None | Unset
        if isinstance(self.size_bytes, Unset):
            size_bytes = UNSET
        else:
            size_bytes = self.size_bytes

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "fetched_at": fetched_at,
                "status": status,
                "url": url,
            }
        )
        if content_url is not UNSET:
            field_dict["content_url"] = content_url
        if error is not UNSET:
            field_dict["error"] = error
        if mime_type is not UNSET:
            field_dict["mime_type"] = mime_type
        if size_bytes is not UNSET:
            field_dict["size_bytes"] = size_bytes

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        fetched_at = isoparse(d.pop("fetched_at"))

        status = d.pop("status")

        url = d.pop("url")

        def _parse_content_url(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        content_url = _parse_content_url(d.pop("content_url", UNSET))

        def _parse_error(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        error = _parse_error(d.pop("error", UNSET))

        def _parse_mime_type(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        mime_type = _parse_mime_type(d.pop("mime_type", UNSET))

        def _parse_size_bytes(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        size_bytes = _parse_size_bytes(d.pop("size_bytes", UNSET))

        crawled_page = cls(
            fetched_at=fetched_at,
            status=status,
            url=url,
            content_url=content_url,
            error=error,
            mime_type=mime_type,
            size_bytes=size_bytes,
        )

        crawled_page.additional_properties = d
        return crawled_page

    @property
    def additional_keys(self) -> list[str]:
        return list(self.additional_properties.keys())

    def __getitem__(self, key: str) -> Any:
        return self.additional_properties[key]

    def __setitem__(self, key: str, value: Any) -> None:
        self.additional_properties[key] = value

    def __delitem__(self, key: str) -> None:
        del self.additional_properties[key]

    def __contains__(self, key: str) -> bool:
        return key in self.additional_properties
