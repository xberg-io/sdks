from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.ocr_bounding_geometry_type_0_type import (
    OcrBoundingGeometryType0Type,
    check_ocr_bounding_geometry_type_0_type,
)

T = TypeVar("T", bound="OcrBoundingGeometryType0")


@_attrs_define
class OcrBoundingGeometryType0:
    """Axis-aligned bounding box (typical for Tesseract output).

    Attributes:
        height (int): Height in pixels
        left (int): Left x-coordinate in pixels
        top (int): Top y-coordinate in pixels
        type_ (OcrBoundingGeometryType0Type):
        width (int): Width in pixels
    """

    height: int
    left: int
    top: int
    type_: OcrBoundingGeometryType0Type
    width: int
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        height = self.height

        left = self.left

        top = self.top

        type_: str = self.type_

        width = self.width

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "height": height,
                "left": left,
                "top": top,
                "type": type_,
                "width": width,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        height = d.pop("height")

        left = d.pop("left")

        top = d.pop("top")

        type_ = check_ocr_bounding_geometry_type_0_type(d.pop("type"))

        width = d.pop("width")

        ocr_bounding_geometry_type_0 = cls(
            height=height,
            left=left,
            top=top,
            type_=type_,
            width=width,
        )

        ocr_bounding_geometry_type_0.additional_properties = d
        return ocr_bounding_geometry_type_0

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
