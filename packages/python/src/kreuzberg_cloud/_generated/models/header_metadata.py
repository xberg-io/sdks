from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="HeaderMetadata")


@_attrs_define
class HeaderMetadata:
    """Header/heading element metadata.

    Attributes:
        depth (int): Document tree depth at the header element
        html_offset (int): Byte offset in original HTML document
        level (int): Header level: 1 (h1) through 6 (h6)
        text (str): Normalized text content of the header
        id (None | str | Unset): HTML id attribute if present
    """

    depth: int
    html_offset: int
    level: int
    text: str
    id: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        depth = self.depth

        html_offset = self.html_offset

        level = self.level

        text = self.text

        id: None | str | Unset
        if isinstance(self.id, Unset):
            id = UNSET
        else:
            id = self.id

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "depth": depth,
                "html_offset": html_offset,
                "level": level,
                "text": text,
            }
        )
        if id is not UNSET:
            field_dict["id"] = id

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        depth = d.pop("depth")

        html_offset = d.pop("html_offset")

        level = d.pop("level")

        text = d.pop("text")

        def _parse_id(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        id = _parse_id(d.pop("id", UNSET))

        header_metadata = cls(
            depth=depth,
            html_offset=html_offset,
            level=level,
            text=text,
            id=id,
        )

        header_metadata.additional_properties = d
        return header_metadata

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
