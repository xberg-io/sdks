from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.node_content_type_11_node_type import NodeContentType11NodeType, check_node_content_type_11_node_type
from ..types import UNSET, Unset

T = TypeVar("T", bound="NodeContentType11")


@_attrs_define
class NodeContentType11:
    """Logical grouping container (section, key-value area).

    `heading_level` + `heading_text` capture the section heading directly
    rather than relying on a first-child positional convention.

    Attributes:
            node_type (NodeContentType11NodeType):
            heading_level (int | None | Unset):
            heading_text (None | str | Unset):
            label (None | str | Unset):
    """

    node_type: NodeContentType11NodeType
    heading_level: int | None | Unset = UNSET
    heading_text: None | str | Unset = UNSET
    label: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        node_type: str = self.node_type

        heading_level: int | None | Unset
        if isinstance(self.heading_level, Unset):
            heading_level = UNSET
        else:
            heading_level = self.heading_level

        heading_text: None | str | Unset
        if isinstance(self.heading_text, Unset):
            heading_text = UNSET
        else:
            heading_text = self.heading_text

        label: None | str | Unset
        if isinstance(self.label, Unset):
            label = UNSET
        else:
            label = self.label

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "node_type": node_type,
            }
        )
        if heading_level is not UNSET:
            field_dict["heading_level"] = heading_level
        if heading_text is not UNSET:
            field_dict["heading_text"] = heading_text
        if label is not UNSET:
            field_dict["label"] = label

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        node_type = check_node_content_type_11_node_type(d.pop("node_type"))

        def _parse_heading_level(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        heading_level = _parse_heading_level(d.pop("heading_level", UNSET))

        def _parse_heading_text(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        heading_text = _parse_heading_text(d.pop("heading_text", UNSET))

        def _parse_label(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        label = _parse_label(d.pop("label", UNSET))

        node_content_type_11 = cls(
            node_type=node_type,
            heading_level=heading_level,
            heading_text=heading_text,
            label=label,
        )

        node_content_type_11.additional_properties = d
        return node_content_type_11

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
