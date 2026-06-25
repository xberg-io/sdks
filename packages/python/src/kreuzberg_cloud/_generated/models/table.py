from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.bounding_box import BoundingBox


T = TypeVar("T", bound="Table")


@_attrs_define
class Table:
    """Extracted table structure.

    Represents a table detected and extracted from a document (PDF, image, etc.).
    Tables are converted to both structured cell data and Markdown format.

    Attributes:
            cells (list[list[str]]): Table cells as a 2D vector (rows × columns)
            markdown (str): Markdown representation of the table
            page_number (int): Page number where the table was found (1-indexed)
            bounding_box (BoundingBox | None | Unset):
    """

    cells: list[list[str]]
    markdown: str
    page_number: int
    bounding_box: BoundingBox | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.bounding_box import BoundingBox

        cells = []
        for cells_item_data in self.cells:
            cells_item = cells_item_data

            cells.append(cells_item)

        markdown = self.markdown

        page_number = self.page_number

        bounding_box: dict[str, Any] | None | Unset
        if isinstance(self.bounding_box, Unset):
            bounding_box = UNSET
        elif isinstance(self.bounding_box, BoundingBox):
            bounding_box = self.bounding_box.to_dict()
        else:
            bounding_box = self.bounding_box

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "cells": cells,
                "markdown": markdown,
                "page_number": page_number,
            }
        )
        if bounding_box is not UNSET:
            field_dict["bounding_box"] = bounding_box

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.bounding_box import BoundingBox

        d = dict(src_dict)
        cells = []
        _cells = d.pop("cells")
        for cells_item_data in _cells:
            cells_item = cast("list[str]", cells_item_data)

            cells.append(cells_item)

        markdown = d.pop("markdown")

        page_number = d.pop("page_number")

        def _parse_bounding_box(data: object) -> BoundingBox | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                bounding_box_type_1 = BoundingBox.from_dict(data)

                return bounding_box_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("BoundingBox | None | Unset", data)

        bounding_box = _parse_bounding_box(d.pop("bounding_box", UNSET))

        table = cls(
            cells=cells,
            markdown=markdown,
            page_number=page_number,
            bounding_box=bounding_box,
        )

        table.additional_properties = d
        return table

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
