from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="PptxMetadata")


@_attrs_define
class PptxMetadata:
    """PowerPoint presentation metadata.

    Extracted from PPTX files containing slide counts and presentation details.

    Attributes:
            slide_count (int): Total number of slides in the presentation
            slide_names (list[str]): Names of slides (if available)
            image_count (int | None | Unset): Number of embedded images
            table_count (int | None | Unset): Number of tables
    """

    slide_count: int
    slide_names: list[str]
    image_count: int | None | Unset = UNSET
    table_count: int | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        slide_count = self.slide_count

        slide_names = self.slide_names

        image_count: int | None | Unset
        if isinstance(self.image_count, Unset):
            image_count = UNSET
        else:
            image_count = self.image_count

        table_count: int | None | Unset
        if isinstance(self.table_count, Unset):
            table_count = UNSET
        else:
            table_count = self.table_count

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "slide_count": slide_count,
                "slide_names": slide_names,
            }
        )
        if image_count is not UNSET:
            field_dict["image_count"] = image_count
        if table_count is not UNSET:
            field_dict["table_count"] = table_count

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        slide_count = d.pop("slide_count")

        slide_names = cast("list[str]", d.pop("slide_names"))

        def _parse_image_count(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        image_count = _parse_image_count(d.pop("image_count", UNSET))

        def _parse_table_count(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        table_count = _parse_table_count(d.pop("table_count", UNSET))

        pptx_metadata = cls(
            slide_count=slide_count,
            slide_names=slide_names,
            image_count=image_count,
            table_count=table_count,
        )

        pptx_metadata.additional_properties = d
        return pptx_metadata

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
