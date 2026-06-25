from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.node_content_type_16_node_type import NodeContentType16NodeType, check_node_content_type_16_node_type

T = TypeVar("T", bound="NodeContentType16")


@_attrs_define
class NodeContentType16:
    """Citation or bibliographic reference.

    Attributes:
        key (str):
        node_type (NodeContentType16NodeType):
        text (str):
    """

    key: str
    node_type: NodeContentType16NodeType
    text: str
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        key = self.key

        node_type: str = self.node_type

        text = self.text

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "key": key,
                "node_type": node_type,
                "text": text,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        key = d.pop("key")

        node_type = check_node_content_type_16_node_type(d.pop("node_type"))

        text = d.pop("text")

        node_content_type_16 = cls(
            key=key,
            node_type=node_type,
            text=text,
        )

        node_content_type_16.additional_properties = d
        return node_content_type_16

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
