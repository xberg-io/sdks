from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.bounding_box import BoundingBox


T = TypeVar("T", bound="GridCell")


@_attrs_define
class GridCell:
    """Individual grid cell with position and span metadata.

    Attributes:
        col (int): Zero-indexed column position.
        content (str): Cell text content.
        row (int): Zero-indexed row position.
        bbox (BoundingBox | None | Unset):
        col_span (int | Unset): Number of columns this cell spans.
        is_header (bool | Unset): Whether this is a header cell.
        row_span (int | Unset): Number of rows this cell spans.
    """

    col: int
    content: str
    row: int
    bbox: BoundingBox | None | Unset = UNSET
    col_span: int | Unset = UNSET
    is_header: bool | Unset = UNSET
    row_span: int | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.bounding_box import BoundingBox

        col = self.col

        content = self.content

        row = self.row

        bbox: dict[str, Any] | None | Unset
        if isinstance(self.bbox, Unset):
            bbox = UNSET
        elif isinstance(self.bbox, BoundingBox):
            bbox = self.bbox.to_dict()
        else:
            bbox = self.bbox

        col_span = self.col_span

        is_header = self.is_header

        row_span = self.row_span

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "col": col,
                "content": content,
                "row": row,
            }
        )
        if bbox is not UNSET:
            field_dict["bbox"] = bbox
        if col_span is not UNSET:
            field_dict["col_span"] = col_span
        if is_header is not UNSET:
            field_dict["is_header"] = is_header
        if row_span is not UNSET:
            field_dict["row_span"] = row_span

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.bounding_box import BoundingBox

        d = dict(src_dict)
        col = d.pop("col")

        content = d.pop("content")

        row = d.pop("row")

        def _parse_bbox(data: object) -> BoundingBox | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                bbox_type_1 = BoundingBox.from_dict(data)

                return bbox_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("BoundingBox | None | Unset", data)

        bbox = _parse_bbox(d.pop("bbox", UNSET))

        col_span = d.pop("col_span", UNSET)

        is_header = d.pop("is_header", UNSET)

        row_span = d.pop("row_span", UNSET)

        grid_cell = cls(
            col=col,
            content=content,
            row=row,
            bbox=bbox,
            col_span=col_span,
            is_header=is_header,
            row_span=row_span,
        )

        grid_cell.additional_properties = d
        return grid_cell

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
