from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.node_content_type_3_node_type import NodeContentType3NodeType, check_node_content_type_3_node_type

T = TypeVar("T", bound="NodeContentType3")


@_attrs_define
class NodeContentType3:
    """List container — children are `ListItem` nodes.

    Attributes:
        node_type (NodeContentType3NodeType):
        ordered (bool):
    """

    node_type: NodeContentType3NodeType
    ordered: bool
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        node_type: str = self.node_type

        ordered = self.ordered

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "node_type": node_type,
                "ordered": ordered,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        node_type = check_node_content_type_3_node_type(d.pop("node_type"))

        ordered = d.pop("ordered")

        node_content_type_3 = cls(
            node_type=node_type,
            ordered=ordered,
        )

        node_content_type_3.additional_properties = d
        return node_content_type_3

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
