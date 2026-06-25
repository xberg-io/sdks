from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.annotation_kind_type_11_annotation_type import (
    AnnotationKindType11AnnotationType,
    check_annotation_kind_type_11_annotation_type,
)
from ..types import UNSET, Unset

T = TypeVar("T", bound="AnnotationKindType11")


@_attrs_define
class AnnotationKindType11:
    """Extensible annotation for format-specific styling.

    Attributes:
        annotation_type (AnnotationKindType11AnnotationType):
        name (str):
        value (None | str | Unset):
    """

    annotation_type: AnnotationKindType11AnnotationType
    name: str
    value: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        annotation_type: str = self.annotation_type

        name = self.name

        value: None | str | Unset
        if isinstance(self.value, Unset):
            value = UNSET
        else:
            value = self.value

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "annotation_type": annotation_type,
                "name": name,
            }
        )
        if value is not UNSET:
            field_dict["value"] = value

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        annotation_type = check_annotation_kind_type_11_annotation_type(d.pop("annotation_type"))

        name = d.pop("name")

        def _parse_value(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        value = _parse_value(d.pop("value", UNSET))

        annotation_kind_type_11 = cls(
            annotation_type=annotation_type,
            name=name,
            value=value,
        )

        annotation_kind_type_11.additional_properties = d
        return annotation_kind_type_11

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
