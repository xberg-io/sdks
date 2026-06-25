from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="LayoutDetectionConfig")


@_attrs_define
class LayoutDetectionConfig:
    """Document layout detection configuration.

    Attributes:
        apply_heuristics (bool | None | Unset): Apply postprocessing heuristics
        confidence_threshold (float | None | Unset): Confidence threshold override
        preset (None | str | Unset): Preset: "fast" or "accurate"
    """

    apply_heuristics: bool | None | Unset = UNSET
    confidence_threshold: float | None | Unset = UNSET
    preset: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        apply_heuristics: bool | None | Unset
        if isinstance(self.apply_heuristics, Unset):
            apply_heuristics = UNSET
        else:
            apply_heuristics = self.apply_heuristics

        confidence_threshold: float | None | Unset
        if isinstance(self.confidence_threshold, Unset):
            confidence_threshold = UNSET
        else:
            confidence_threshold = self.confidence_threshold

        preset: None | str | Unset
        if isinstance(self.preset, Unset):
            preset = UNSET
        else:
            preset = self.preset

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if apply_heuristics is not UNSET:
            field_dict["apply_heuristics"] = apply_heuristics
        if confidence_threshold is not UNSET:
            field_dict["confidence_threshold"] = confidence_threshold
        if preset is not UNSET:
            field_dict["preset"] = preset

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)

        def _parse_apply_heuristics(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        apply_heuristics = _parse_apply_heuristics(d.pop("apply_heuristics", UNSET))

        def _parse_confidence_threshold(data: object) -> float | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("float | None | Unset", data)

        confidence_threshold = _parse_confidence_threshold(d.pop("confidence_threshold", UNSET))

        def _parse_preset(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        preset = _parse_preset(d.pop("preset", UNSET))

        layout_detection_config = cls(
            apply_heuristics=apply_heuristics,
            confidence_threshold=confidence_threshold,
            preset=preset,
        )

        layout_detection_config.additional_properties = d
        return layout_detection_config

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
