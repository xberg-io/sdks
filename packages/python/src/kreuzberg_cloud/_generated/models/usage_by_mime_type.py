from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

T = TypeVar("T", bound="UsageByMimeType")


@_attrs_define
class UsageByMimeType:
    """Usage statistics broken down by MIME type.

    Attributes:
        documents (int): Number of documents of this MIME type processed
        failed (int): Number of failed extractions for this MIME type
        pages (int): Total pages extracted from documents of this MIME type
    """

    documents: int
    failed: int
    pages: int
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        documents = self.documents

        failed = self.failed

        pages = self.pages

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "documents": documents,
                "failed": failed,
                "pages": pages,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        documents = d.pop("documents")

        failed = d.pop("failed")

        pages = d.pop("pages")

        usage_by_mime_type = cls(
            documents=documents,
            failed=failed,
            pages=pages,
        )

        usage_by_mime_type.additional_properties = d
        return usage_by_mime_type

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
