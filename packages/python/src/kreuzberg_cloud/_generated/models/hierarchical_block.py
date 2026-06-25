from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="HierarchicalBlock")


@_attrs_define
class HierarchicalBlock:
    """A text block with hierarchy level assignment.

    Represents a block of text with semantic heading information extracted from
    font size clustering and hierarchical analysis.

    Attributes:
            font_size (float): The font size of the text in this block
            level (str): The hierarchy level of this block (H1-H6 or Body)

                Levels correspond to HTML heading tags:
                - "h1": Top-level heading
                - "h2": Secondary heading
                - "h3": Tertiary heading
                - "h4": Quaternary heading
                - "h5": Quinary heading
                - "h6": Senary heading
                - "body": Body text (no heading level)
            text (str): The text content of this block
            bbox (list[float] | None | Unset): Bounding box information for the block

                Contains coordinates as (left, top, right, bottom) in PDF units.
    """

    font_size: float
    level: str
    text: str
    bbox: list[float] | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        font_size = self.font_size

        level = self.level

        text = self.text

        bbox: list[float] | None | Unset
        if isinstance(self.bbox, Unset):
            bbox = UNSET
        elif isinstance(self.bbox, list):
            bbox = self.bbox

        else:
            bbox = self.bbox

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "font_size": font_size,
                "level": level,
                "text": text,
            }
        )
        if bbox is not UNSET:
            field_dict["bbox"] = bbox

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        font_size = d.pop("font_size")

        level = d.pop("level")

        text = d.pop("text")

        def _parse_bbox(data: object) -> list[float] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                bbox_type_0 = cast("list[float]", data)

                return bbox_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[float] | None | Unset", data)

        bbox = _parse_bbox(d.pop("bbox", UNSET))

        hierarchical_block = cls(
            font_size=font_size,
            level=level,
            text=text,
            bbox=bbox,
        )

        hierarchical_block.additional_properties = d
        return hierarchical_block

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
