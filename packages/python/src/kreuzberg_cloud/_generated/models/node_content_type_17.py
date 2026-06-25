from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.node_content_type_17_node_type import NodeContentType17NodeType, check_node_content_type_17_node_type
from ..types import UNSET, Unset

T = TypeVar("T", bound="NodeContentType17")


@_attrs_define
class NodeContentType17:
    """Admonition / callout container (note, warning, tip, etc.).

    Children carry the admonition body content.

    Attributes:
            kind (str): Kind of admonition (e.g. "note", "warning", "tip", "danger").
            node_type (NodeContentType17NodeType):
            title (None | str | Unset):
    """

    kind: str
    node_type: NodeContentType17NodeType
    title: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        kind = self.kind

        node_type: str = self.node_type

        title: None | str | Unset
        if isinstance(self.title, Unset):
            title = UNSET
        else:
            title = self.title

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "kind": kind,
                "node_type": node_type,
            }
        )
        if title is not UNSET:
            field_dict["title"] = title

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        kind = d.pop("kind")

        node_type = check_node_content_type_17_node_type(d.pop("node_type"))

        def _parse_title(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        title = _parse_title(d.pop("title", UNSET))

        node_content_type_17 = cls(
            kind=kind,
            node_type=node_type,
            title=title,
        )

        node_content_type_17.additional_properties = d
        return node_content_type_17

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
