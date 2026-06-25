from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.node_content_type_18_node_type import NodeContentType18NodeType, check_node_content_type_18_node_type

T = TypeVar("T", bound="NodeContentType18")


@_attrs_define
class NodeContentType18:
    """Raw block preserved verbatim from the source format.

    Used for content that cannot be mapped to a semantic node type
    (e.g. JSX in MDX, raw LaTeX in markdown, embedded HTML).

    Attributes:
            content (str):
            format_ (str): Source format identifier (e.g. "html", "latex", "jsx").
            node_type (NodeContentType18NodeType):
    """

    content: str
    format_: str
    node_type: NodeContentType18NodeType
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        content = self.content

        format_ = self.format_

        node_type: str = self.node_type

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "content": content,
                "format": format_,
                "node_type": node_type,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        content = d.pop("content")

        format_ = d.pop("format")

        node_type = check_node_content_type_18_node_type(d.pop("node_type"))

        node_content_type_18 = cls(
            content=content,
            format_=format_,
            node_type=node_type,
        )

        node_content_type_18.additional_properties = d
        return node_content_type_18

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
