from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.revision_anchor_type_1_type import RevisionAnchorType1Type, check_revision_anchor_type_1_type

T = TypeVar("T", bound="RevisionAnchorType1")


@_attrs_define
class RevisionAnchorType1:
    """Cell inside a table.

    Attributes:
        col (int): Zero-based column index within the table.
        row (int): Zero-based row index within the table.
        table_index (int): Zero-based index of the table in document order.
        type_ (RevisionAnchorType1Type):
    """

    col: int
    row: int
    table_index: int
    type_: RevisionAnchorType1Type
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        col = self.col

        row = self.row

        table_index = self.table_index

        type_: str = self.type_

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "col": col,
                "row": row,
                "table_index": table_index,
                "type": type_,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        col = d.pop("col")

        row = d.pop("row")

        table_index = d.pop("table_index")

        type_ = check_revision_anchor_type_1_type(d.pop("type"))

        revision_anchor_type_1 = cls(
            col=col,
            row=row,
            table_index=table_index,
            type_=type_,
        )

        revision_anchor_type_1.additional_properties = d
        return revision_anchor_type_1

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
