from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.revision_anchor_type_4_type import RevisionAnchorType4Type, check_revision_anchor_type_4_type
from ..types import UNSET, Unset

T = TypeVar("T", bound="RevisionAnchorType4")


@_attrs_define
class RevisionAnchorType4:
    """Spreadsheet cell or range, identified by sheet index and optional name.

    Attributes:
        index (int): Zero-based sheet index.
        type_ (RevisionAnchorType4Type):
        name (None | str | Unset): Sheet display name when available.
    """

    index: int
    type_: RevisionAnchorType4Type
    name: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        index = self.index

        type_: str = self.type_

        name: None | str | Unset
        if isinstance(self.name, Unset):
            name = UNSET
        else:
            name = self.name

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "index": index,
                "type": type_,
            }
        )
        if name is not UNSET:
            field_dict["name"] = name

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        index = d.pop("index")

        type_ = check_revision_anchor_type_4_type(d.pop("type"))

        def _parse_name(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        name = _parse_name(d.pop("name", UNSET))

        revision_anchor_type_4 = cls(
            index=index,
            type_=type_,
            name=name,
        )

        revision_anchor_type_4.additional_properties = d
        return revision_anchor_type_4

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
