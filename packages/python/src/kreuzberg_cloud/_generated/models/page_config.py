from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="PageConfig")


@_attrs_define
class PageConfig:
    r"""Page extraction configuration.

    Attributes:
        extract_pages (bool | Unset): Extract pages as separate array in result
        insert_page_markers (bool | Unset): Insert page markers in content text
        marker_format (None | str | Unset): Page marker format template (e.g., "\n\n<!-- PAGE {page_num} -->\n\n")
    """

    extract_pages: bool | Unset = UNSET
    insert_page_markers: bool | Unset = UNSET
    marker_format: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        extract_pages = self.extract_pages

        insert_page_markers = self.insert_page_markers

        marker_format: None | str | Unset
        if isinstance(self.marker_format, Unset):
            marker_format = UNSET
        else:
            marker_format = self.marker_format

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if extract_pages is not UNSET:
            field_dict["extract_pages"] = extract_pages
        if insert_page_markers is not UNSET:
            field_dict["insert_page_markers"] = insert_page_markers
        if marker_format is not UNSET:
            field_dict["marker_format"] = marker_format

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        extract_pages = d.pop("extract_pages", UNSET)

        insert_page_markers = d.pop("insert_page_markers", UNSET)

        def _parse_marker_format(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        marker_format = _parse_marker_format(d.pop("marker_format", UNSET))

        page_config = cls(
            extract_pages=extract_pages,
            insert_page_markers=insert_page_markers,
            marker_format=marker_format,
        )

        page_config.additional_properties = d
        return page_config

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
