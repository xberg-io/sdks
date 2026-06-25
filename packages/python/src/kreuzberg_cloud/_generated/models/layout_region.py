from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

if TYPE_CHECKING:
    from ..models.bounding_box import BoundingBox


T = TypeVar("T", bound="LayoutRegion")


@_attrs_define
class LayoutRegion:
    """A detected layout region on a page.

    When layout detection is enabled, each page may have layout regions
    identifying different content types (text, pictures, tables, etc.)
    with confidence scores and spatial positions.

    Attributes:
            area_fraction (float): Fraction of the page area covered by this region (0.0 to 1.0).
            bounding_box (BoundingBox): Bounding box coordinates for element positioning.
            class_name (str): Layout class name (e.g. "picture", "table", "text", "section_header").
            confidence (float): Confidence score from the layout detection model (0.0 to 1.0).
    """

    area_fraction: float
    bounding_box: BoundingBox
    class_name: str
    confidence: float
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        area_fraction = self.area_fraction

        bounding_box = self.bounding_box.to_dict()

        class_name = self.class_name

        confidence = self.confidence

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "area_fraction": area_fraction,
                "bounding_box": bounding_box,
                "class_name": class_name,
                "confidence": confidence,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.bounding_box import BoundingBox

        d = dict(src_dict)
        area_fraction = d.pop("area_fraction")

        bounding_box = BoundingBox.from_dict(d.pop("bounding_box"))

        class_name = d.pop("class_name")

        confidence = d.pop("confidence")

        layout_region = cls(
            area_fraction=area_fraction,
            bounding_box=bounding_box,
            class_name=class_name,
            confidence=confidence,
        )

        layout_region.additional_properties = d
        return layout_region

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
