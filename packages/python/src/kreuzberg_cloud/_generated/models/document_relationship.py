from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.relationship_kind import RelationshipKind, check_relationship_kind

T = TypeVar("T", bound="DocumentRelationship")


@_attrs_define
class DocumentRelationship:
    """A resolved relationship between two nodes in the document tree.

    Attributes:
        kind (RelationshipKind): Semantic kind of a relationship between document elements.
        source (int): Newtype for node indices into the `DocumentStructure::nodes` array.

            Uses `u32` for cross-platform consistency (WASM is 32-bit) and to avoid
            confusion with page numbers or other `usize` values.
        target (int): Newtype for node indices into the `DocumentStructure::nodes` array.

            Uses `u32` for cross-platform consistency (WASM is 32-bit) and to avoid
            confusion with page numbers or other `usize` values.
    """

    kind: RelationshipKind
    source: int
    target: int
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        kind: str = self.kind

        source = self.source

        target = self.target

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "kind": kind,
                "source": source,
                "target": target,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        kind = check_relationship_kind(d.pop("kind"))

        source = d.pop("source")

        target = d.pop("target")

        document_relationship = cls(
            kind=kind,
            source=source,
            target=target,
        )

        document_relationship.additional_properties = d
        return document_relationship

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
