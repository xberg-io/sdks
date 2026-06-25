from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.annotation_kind_type_7_annotation_type import (
    AnnotationKindType7AnnotationType,
    check_annotation_kind_type_7_annotation_type,
)
from ..types import UNSET, Unset

T = TypeVar("T", bound="AnnotationKindType7")


@_attrs_define
class AnnotationKindType7:
    """
    Attributes:
        annotation_type (AnnotationKindType7AnnotationType):
        url (str):
        title (None | str | Unset):
    """

    annotation_type: AnnotationKindType7AnnotationType
    url: str
    title: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        annotation_type: str = self.annotation_type

        url = self.url

        title: None | str | Unset
        if isinstance(self.title, Unset):
            title = UNSET
        else:
            title = self.title

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "annotation_type": annotation_type,
                "url": url,
            }
        )
        if title is not UNSET:
            field_dict["title"] = title

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        annotation_type = check_annotation_kind_type_7_annotation_type(d.pop("annotation_type"))

        url = d.pop("url")

        def _parse_title(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        title = _parse_title(d.pop("title", UNSET))

        annotation_kind_type_7 = cls(
            annotation_type=annotation_type,
            url=url,
            title=title,
        )

        annotation_kind_type_7.additional_properties = d
        return annotation_kind_type_7

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
