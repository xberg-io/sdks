from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

T = TypeVar("T", bound="XmlMetadata")


@_attrs_define
class XmlMetadata:
    """XML metadata extracted during XML parsing.

    Provides statistics about XML document structure.

    Attributes:
            element_count (int): Total number of XML elements processed
            unique_elements (list[str]): List of unique element tag names (sorted)
    """

    element_count: int
    unique_elements: list[str]
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        element_count = self.element_count

        unique_elements = self.unique_elements

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "element_count": element_count,
                "unique_elements": unique_elements,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        element_count = d.pop("element_count")

        unique_elements = cast("list[str]", d.pop("unique_elements"))

        xml_metadata = cls(
            element_count=element_count,
            unique_elements=unique_elements,
        )

        xml_metadata.additional_properties = d
        return xml_metadata

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
