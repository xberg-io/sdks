from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

T = TypeVar("T", bound="CellChange")


@_attrs_define
class CellChange:
    """A single changed cell within a table.

    Defined here (rather than only in `crate::diff`) so `RevisionDelta` can
    reference it unconditionally, without requiring the `diff` Cargo feature.
    `crate::diff` re-exports this type verbatim.

    Attributes:
            col (int): Zero-based column index.
            from_ (str): Value before the change.
            row (int): Zero-based row index.
            to (str): Value after the change.
    """

    col: int
    from_: str
    row: int
    to: str
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        col = self.col

        from_ = self.from_

        row = self.row

        to = self.to

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "col": col,
                "from": from_,
                "row": row,
                "to": to,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        col = d.pop("col")

        from_ = d.pop("from")

        row = d.pop("row")

        to = d.pop("to")

        cell_change = cls(
            col=col,
            from_=from_,
            row=row,
            to=to,
        )

        cell_change.additional_properties = d
        return cell_change

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
