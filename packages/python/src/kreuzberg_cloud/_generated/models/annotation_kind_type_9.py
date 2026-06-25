from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.annotation_kind_type_9_annotation_type import (
    AnnotationKindType9AnnotationType,
    check_annotation_kind_type_9_annotation_type,
)

T = TypeVar("T", bound="AnnotationKindType9")


@_attrs_define
class AnnotationKindType9:
    """Text color (CSS-compatible value, e.g. "#ff0000", "red").

    Attributes:
        annotation_type (AnnotationKindType9AnnotationType):
        value (str):
    """

    annotation_type: AnnotationKindType9AnnotationType
    value: str
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        annotation_type: str = self.annotation_type

        value = self.value

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "annotation_type": annotation_type,
                "value": value,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        annotation_type = check_annotation_kind_type_9_annotation_type(d.pop("annotation_type"))

        value = d.pop("value")

        annotation_kind_type_9 = cls(
            annotation_type=annotation_type,
            value=value,
        )

        annotation_kind_type_9.additional_properties = d
        return annotation_kind_type_9

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
