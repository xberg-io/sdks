from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="OcrElementConfig")


@_attrs_define
class OcrElementConfig:
    """Structured OCR element extraction configuration.

    Attributes:
        build_hierarchy (bool | Unset): Build parent-child relationships
        include_elements (bool | Unset): Include OCR elements in result
        min_confidence (float | None | Unset): Minimum recognition confidence (0.0-1.0)
        min_level (None | str | Unset): Minimum hierarchical level: "word", "line", "block", "page"
    """

    build_hierarchy: bool | Unset = UNSET
    include_elements: bool | Unset = UNSET
    min_confidence: float | None | Unset = UNSET
    min_level: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        build_hierarchy = self.build_hierarchy

        include_elements = self.include_elements

        min_confidence: float | None | Unset
        if isinstance(self.min_confidence, Unset):
            min_confidence = UNSET
        else:
            min_confidence = self.min_confidence

        min_level: None | str | Unset
        if isinstance(self.min_level, Unset):
            min_level = UNSET
        else:
            min_level = self.min_level

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if build_hierarchy is not UNSET:
            field_dict["build_hierarchy"] = build_hierarchy
        if include_elements is not UNSET:
            field_dict["include_elements"] = include_elements
        if min_confidence is not UNSET:
            field_dict["min_confidence"] = min_confidence
        if min_level is not UNSET:
            field_dict["min_level"] = min_level

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        build_hierarchy = d.pop("build_hierarchy", UNSET)

        include_elements = d.pop("include_elements", UNSET)

        def _parse_min_confidence(data: object) -> float | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("float | None | Unset", data)

        min_confidence = _parse_min_confidence(d.pop("min_confidence", UNSET))

        def _parse_min_level(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        min_level = _parse_min_level(d.pop("min_level", UNSET))

        ocr_element_config = cls(
            build_hierarchy=build_hierarchy,
            include_elements=include_elements,
            min_confidence=min_confidence,
            min_level=min_level,
        )

        ocr_element_config.additional_properties = d
        return ocr_element_config

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
