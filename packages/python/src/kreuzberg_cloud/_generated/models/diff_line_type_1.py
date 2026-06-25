from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.diff_line_type_1_kind import DiffLineType1Kind, check_diff_line_type_1_kind

T = TypeVar("T", bound="DiffLineType1")


@_attrs_define
class DiffLineType1:
    """Line added in the "after" version.

    Attributes:
        kind (DiffLineType1Kind):
        text (str): Line added in the "after" version.
    """

    kind: DiffLineType1Kind
    text: str
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        kind: str = self.kind

        text = self.text

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "kind": kind,
                "text": text,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        kind = check_diff_line_type_1_kind(d.pop("kind"))

        text = d.pop("text")

        diff_line_type_1 = cls(
            kind=kind,
            text=text,
        )

        diff_line_type_1.additional_properties = d
        return diff_line_type_1

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
