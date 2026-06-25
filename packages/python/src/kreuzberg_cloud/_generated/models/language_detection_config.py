from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="LanguageDetectionConfig")


@_attrs_define
class LanguageDetectionConfig:
    """Language detection configuration.

    Attributes:
        detect_multiple (bool | None | Unset): Detect multiple languages in document
        enabled (bool | None | Unset): Enable language detection
        min_confidence (float | None | Unset): Minimum confidence threshold (0.0-1.0)
    """

    detect_multiple: bool | None | Unset = UNSET
    enabled: bool | None | Unset = UNSET
    min_confidence: float | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        detect_multiple: bool | None | Unset
        if isinstance(self.detect_multiple, Unset):
            detect_multiple = UNSET
        else:
            detect_multiple = self.detect_multiple

        enabled: bool | None | Unset
        if isinstance(self.enabled, Unset):
            enabled = UNSET
        else:
            enabled = self.enabled

        min_confidence: float | None | Unset
        if isinstance(self.min_confidence, Unset):
            min_confidence = UNSET
        else:
            min_confidence = self.min_confidence

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if detect_multiple is not UNSET:
            field_dict["detect_multiple"] = detect_multiple
        if enabled is not UNSET:
            field_dict["enabled"] = enabled
        if min_confidence is not UNSET:
            field_dict["min_confidence"] = min_confidence

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)

        def _parse_detect_multiple(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        detect_multiple = _parse_detect_multiple(d.pop("detect_multiple", UNSET))

        def _parse_enabled(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        enabled = _parse_enabled(d.pop("enabled", UNSET))

        def _parse_min_confidence(data: object) -> float | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("float | None | Unset", data)

        min_confidence = _parse_min_confidence(d.pop("min_confidence", UNSET))

        language_detection_config = cls(
            detect_multiple=detect_multiple,
            enabled=enabled,
            min_confidence=min_confidence,
        )

        language_detection_config.additional_properties = d
        return language_detection_config

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
