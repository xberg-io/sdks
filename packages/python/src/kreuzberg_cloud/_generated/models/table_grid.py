from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

if TYPE_CHECKING:
    from ..models.grid_cell import GridCell


T = TypeVar("T", bound="TableGrid")


@_attrs_define
class TableGrid:
    """Structured table grid with cell-level metadata.

    Stores row/column dimensions and a flat list of cells with position info.

    Attributes:
            cells (list[GridCell]): All cells in row-major order.
            cols (int): Number of columns in the table.
            rows (int): Number of rows in the table.
    """

    cells: list[GridCell]
    cols: int
    rows: int
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        cells = []
        for cells_item_data in self.cells:
            cells_item = cells_item_data.to_dict()
            cells.append(cells_item)

        cols = self.cols

        rows = self.rows

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "cells": cells,
                "cols": cols,
                "rows": rows,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.grid_cell import GridCell

        d = dict(src_dict)
        cells = []
        _cells = d.pop("cells")
        for cells_item_data in _cells:
            cells_item = GridCell.from_dict(cells_item_data)

            cells.append(cells_item)

        cols = d.pop("cols")

        rows = d.pop("rows")

        table_grid = cls(
            cells=cells,
            cols=cols,
            rows=rows,
        )

        table_grid.additional_properties = d
        return table_grid

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
