from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.annotation_kind_type_2_annotation_type import (
    AnnotationKindType2AnnotationType,
    check_annotation_kind_type_2_annotation_type,
)

T = TypeVar("T", bound="AnnotationKindType2")


@_attrs_define
class AnnotationKindType2:
    """
    Attributes:
        annotation_type (AnnotationKindType2AnnotationType):
    """

    annotation_type: AnnotationKindType2AnnotationType
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        annotation_type: str = self.annotation_type

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "annotation_type": annotation_type,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        annotation_type = check_annotation_kind_type_2_annotation_type(d.pop("annotation_type"))

        annotation_kind_type_2 = cls(
            annotation_type=annotation_type,
        )

        annotation_kind_type_2.additional_properties = d
        return annotation_kind_type_2

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
