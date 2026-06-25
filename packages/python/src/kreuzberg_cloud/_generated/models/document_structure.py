from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.document_node import DocumentNode
    from ..models.document_relationship import DocumentRelationship


T = TypeVar("T", bound="DocumentStructure")


@_attrs_define
class DocumentStructure:
    """Top-level structured document representation.

    A flat array of nodes with index-based parent/child references forming a tree.
    Root-level nodes have `parent: None`. Use `body_roots()` and `furniture_roots()`
    to iterate over top-level content by layer.

    # Validation

    Call `validate()` after construction to verify all node indices are in bounds
    and parent-child relationships are bidirectionally consistent.

    Attributes:
            nodes (list[DocumentNode]): All nodes in document/reading order.
            node_types (list[str] | Unset): Sorted, deduplicated list of node type names present in this document.

                Each value is the snake_case `node_type` tag of the corresponding
                [`NodeContent`] variant (e.g. `"paragraph"`, `"heading"`, `"table"`, …).

                Computed from [`nodes`] via [`DocumentStructure::finalize_node_types`].
                Empty until that method is called (internal construction paths call it
                at the end of derivation).
            relationships (list[DocumentRelationship] | Unset): Resolved relationships between nodes (footnote refs,
                citations, anchor links, etc.).

                Populated during derivation from the internal document representation.
                Empty when no relationships are detected.
            source_format (None | str | Unset): Origin format identifier (e.g. "docx", "pptx", "html", "pdf").

                Allows renderers to apply format-aware heuristics when converting
                the document tree to output formats.
    """

    nodes: list[DocumentNode]
    node_types: list[str] | Unset = UNSET
    relationships: list[DocumentRelationship] | Unset = UNSET
    source_format: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        nodes = []
        for nodes_item_data in self.nodes:
            nodes_item = nodes_item_data.to_dict()
            nodes.append(nodes_item)

        node_types: list[str] | Unset = UNSET
        if not isinstance(self.node_types, Unset):
            node_types = self.node_types

        relationships: list[dict[str, Any]] | Unset = UNSET
        if not isinstance(self.relationships, Unset):
            relationships = []
            for relationships_item_data in self.relationships:
                relationships_item = relationships_item_data.to_dict()
                relationships.append(relationships_item)

        source_format: None | str | Unset
        if isinstance(self.source_format, Unset):
            source_format = UNSET
        else:
            source_format = self.source_format

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "nodes": nodes,
            }
        )
        if node_types is not UNSET:
            field_dict["node_types"] = node_types
        if relationships is not UNSET:
            field_dict["relationships"] = relationships
        if source_format is not UNSET:
            field_dict["source_format"] = source_format

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.document_node import DocumentNode
        from ..models.document_relationship import DocumentRelationship

        d = dict(src_dict)
        nodes = []
        _nodes = d.pop("nodes")
        for nodes_item_data in _nodes:
            nodes_item = DocumentNode.from_dict(nodes_item_data)

            nodes.append(nodes_item)

        node_types = cast("list[str]", d.pop("node_types", UNSET))

        _relationships = d.pop("relationships", UNSET)
        relationships: list[DocumentRelationship] | Unset = UNSET
        if _relationships is not UNSET:
            relationships = []
            for relationships_item_data in _relationships:
                relationships_item = DocumentRelationship.from_dict(relationships_item_data)

                relationships.append(relationships_item)

        def _parse_source_format(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        source_format = _parse_source_format(d.pop("source_format", UNSET))

        document_structure = cls(
            nodes=nodes,
            node_types=node_types,
            relationships=relationships,
            source_format=source_format,
        )

        document_structure.additional_properties = d
        return document_structure

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
