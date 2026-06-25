from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.revision_anchor_type_0_type import RevisionAnchorType0Type, check_revision_anchor_type_0_type

T = TypeVar("T", bound="RevisionAnchorType0")


@_attrs_define
class RevisionAnchorType0:
    """Body paragraph, identified by its zero-based index in the document flow.

    Attributes:
        index (int): Zero-based index of the paragraph in document order.
        type_ (RevisionAnchorType0Type):
    """

    index: int
    type_: RevisionAnchorType0Type
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        index = self.index

        type_: str = self.type_

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "index": index,
                "type": type_,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        index = d.pop("index")

        type_ = check_revision_anchor_type_0_type(d.pop("type"))

        revision_anchor_type_0 = cls(
            index=index,
            type_=type_,
        )

        revision_anchor_type_0.additional_properties = d
        return revision_anchor_type_0

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
