from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

T = TypeVar("T", bound="PageBoundary")


@_attrs_define
class PageBoundary:
    """Byte offset boundary for a page.

    Tracks where a specific page's content starts and ends in the main content string,
    enabling mapping from byte positions to page numbers. Offsets are guaranteed to be
    at valid UTF-8 character boundaries when using standard String methods (push_str, push, etc.).

    Attributes:
            byte_end (int): Byte offset where this page ends in the content string (UTF-8 valid boundary, exclusive)
            byte_start (int): Byte offset where this page starts in the content string (UTF-8 valid boundary, inclusive)
            page_number (int): Page number (1-indexed)
    """

    byte_end: int
    byte_start: int
    page_number: int
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        byte_end = self.byte_end

        byte_start = self.byte_start

        page_number = self.page_number

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "byte_end": byte_end,
                "byte_start": byte_start,
                "page_number": page_number,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        byte_end = d.pop("byte_end")

        byte_start = d.pop("byte_start")

        page_number = d.pop("page_number")

        page_boundary = cls(
            byte_end=byte_end,
            byte_start=byte_start,
            page_number=page_number,
        )

        page_boundary.additional_properties = d
        return page_boundary

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
