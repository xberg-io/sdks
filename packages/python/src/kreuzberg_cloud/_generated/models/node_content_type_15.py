from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.node_content_type_15_node_type import NodeContentType15NodeType, check_node_content_type_15_node_type

T = TypeVar("T", bound="NodeContentType15")


@_attrs_define
class NodeContentType15:
    """Individual definition list entry with term and definition.

    Attributes:
        definition (str):
        node_type (NodeContentType15NodeType):
        term (str):
    """

    definition: str
    node_type: NodeContentType15NodeType
    term: str
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        definition = self.definition

        node_type: str = self.node_type

        term = self.term

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "definition": definition,
                "node_type": node_type,
                "term": term,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        definition = d.pop("definition")

        node_type = check_node_content_type_15_node_type(d.pop("node_type"))

        term = d.pop("term")

        node_content_type_15 = cls(
            definition=definition,
            node_type=node_type,
            term=term,
        )

        node_content_type_15.additional_properties = d
        return node_content_type_15

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
