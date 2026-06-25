from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.node_content_type_6_node_type import NodeContentType6NodeType, check_node_content_type_6_node_type
from ..types import UNSET, Unset

T = TypeVar("T", bound="NodeContentType6")


@_attrs_define
class NodeContentType6:
    """Image reference.

    Attributes:
        node_type (NodeContentType6NodeType):
        description (None | str | Unset):
        image_index (int | None | Unset):
        src (None | str | Unset): Source URL or path of the image (from `<img src="...">` or `![](src)`).
    """

    node_type: NodeContentType6NodeType
    description: None | str | Unset = UNSET
    image_index: int | None | Unset = UNSET
    src: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        node_type: str = self.node_type

        description: None | str | Unset
        if isinstance(self.description, Unset):
            description = UNSET
        else:
            description = self.description

        image_index: int | None | Unset
        if isinstance(self.image_index, Unset):
            image_index = UNSET
        else:
            image_index = self.image_index

        src: None | str | Unset
        if isinstance(self.src, Unset):
            src = UNSET
        else:
            src = self.src

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "node_type": node_type,
            }
        )
        if description is not UNSET:
            field_dict["description"] = description
        if image_index is not UNSET:
            field_dict["image_index"] = image_index
        if src is not UNSET:
            field_dict["src"] = src

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        node_type = check_node_content_type_6_node_type(d.pop("node_type"))

        def _parse_description(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        description = _parse_description(d.pop("description", UNSET))

        def _parse_image_index(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        image_index = _parse_image_index(d.pop("image_index", UNSET))

        def _parse_src(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        src = _parse_src(d.pop("src", UNSET))

        node_content_type_6 = cls(
            node_type=node_type,
            description=description,
            image_index=image_index,
            src=src,
        )

        node_content_type_6.additional_properties = d
        return node_content_type_6

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
