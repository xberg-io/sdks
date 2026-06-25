from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.ocr_bounding_geometry_type_1_type import (
    OcrBoundingGeometryType1Type,
    check_ocr_bounding_geometry_type_1_type,
)

T = TypeVar("T", bound="OcrBoundingGeometryType1")


@_attrs_define
class OcrBoundingGeometryType1:
    """4-point quadrilateral for rotated/skewed text (PaddleOCR).

    Points are in clockwise order starting from top-left:
    `[top_left, top_right, bottom_right, bottom_left]`

    Attributes:
            points (list[list[int]]): Four corner points as `[[x, y], ...]` in clockwise order
            type_ (OcrBoundingGeometryType1Type):
    """

    points: list[list[int]]
    type_: OcrBoundingGeometryType1Type
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        points = []
        for points_item_data in self.points:
            points_item = points_item_data

            points.append(points_item)

        type_: str = self.type_

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "points": points,
                "type": type_,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        points = []
        _points = d.pop("points")
        for points_item_data in _points:
            points_item = cast("list[int]", points_item_data)

            points.append(points_item)

        type_ = check_ocr_bounding_geometry_type_1_type(d.pop("type"))

        ocr_bounding_geometry_type_1 = cls(
            points=points,
            type_=type_,
        )

        ocr_bounding_geometry_type_1.additional_properties = d
        return ocr_bounding_geometry_type_1

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
