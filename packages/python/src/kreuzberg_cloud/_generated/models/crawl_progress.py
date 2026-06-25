from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

T = TypeVar("T", bound="CrawlProgress")


@_attrs_define
class CrawlProgress:
    """Crawl progress counters

    Attributes:
        documents_discovered (int):
        documents_extracted (int):
        documents_failed (int):
        pages_crawled (int):
    """

    documents_discovered: int
    documents_extracted: int
    documents_failed: int
    pages_crawled: int
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        documents_discovered = self.documents_discovered

        documents_extracted = self.documents_extracted

        documents_failed = self.documents_failed

        pages_crawled = self.pages_crawled

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "documents_discovered": documents_discovered,
                "documents_extracted": documents_extracted,
                "documents_failed": documents_failed,
                "pages_crawled": pages_crawled,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        documents_discovered = d.pop("documents_discovered")

        documents_extracted = d.pop("documents_extracted")

        documents_failed = d.pop("documents_failed")

        pages_crawled = d.pop("pages_crawled")

        crawl_progress = cls(
            documents_discovered=documents_discovered,
            documents_extracted=documents_extracted,
            documents_failed=documents_failed,
            pages_crawled=pages_crawled,
        )

        crawl_progress.additional_properties = d
        return crawl_progress

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
