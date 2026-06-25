from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="Attributes")


@_attrs_define
class Attributes:
    """Element attributes in Djot.

    Represents the attributes attached to elements using {.class #id key="value"} syntax.

    Attributes:
            classes (list[str] | Unset): CSS classes (.class1 .class2)
            id (None | str | Unset): Element ID (#identifier)
            key_values (list[list[str]] | Unset): Key-value pairs (key="value")
    """

    classes: list[str] | Unset = UNSET
    id: None | str | Unset = UNSET
    key_values: list[list[str]] | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        classes: list[str] | Unset = UNSET
        if not isinstance(self.classes, Unset):
            classes = self.classes

        id: None | str | Unset
        if isinstance(self.id, Unset):
            id = UNSET
        else:
            id = self.id

        key_values: list[list[str]] | Unset = UNSET
        if not isinstance(self.key_values, Unset):
            key_values = []
            for key_values_item_data in self.key_values:
                key_values_item = key_values_item_data

                key_values.append(key_values_item)

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if classes is not UNSET:
            field_dict["classes"] = classes
        if id is not UNSET:
            field_dict["id"] = id
        if key_values is not UNSET:
            field_dict["key_values"] = key_values

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        classes = cast("list[str]", d.pop("classes", UNSET))

        def _parse_id(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        id = _parse_id(d.pop("id", UNSET))

        _key_values = d.pop("key_values", UNSET)
        key_values: list[list[str]] | Unset = UNSET
        if _key_values is not UNSET:
            key_values = []
            for key_values_item_data in _key_values:
                key_values_item = cast("list[str]", key_values_item_data)

                key_values.append(key_values_item)

        attributes = cls(
            classes=classes,
            id=id,
            key_values=key_values,
        )

        attributes.additional_properties = d
        return attributes

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
