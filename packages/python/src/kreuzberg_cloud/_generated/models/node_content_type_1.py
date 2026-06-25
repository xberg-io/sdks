from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.node_content_type_1_node_type import NodeContentType1NodeType, check_node_content_type_1_node_type

T = TypeVar("T", bound="NodeContentType1")


@_attrs_define
class NodeContentType1:
    """Section heading with level (1-6).

    Attributes:
        level (int):
        node_type (NodeContentType1NodeType):
        text (str):
    """

    level: int
    node_type: NodeContentType1NodeType
    text: str
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        level = self.level

        node_type: str = self.node_type

        text = self.text

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "level": level,
                "node_type": node_type,
                "text": text,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        level = d.pop("level")

        node_type = check_node_content_type_1_node_type(d.pop("node_type"))

        text = d.pop("text")

        node_content_type_1 = cls(
            level=level,
            node_type=node_type,
            text=text,
        )

        node_content_type_1.additional_properties = d
        return node_content_type_1

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
