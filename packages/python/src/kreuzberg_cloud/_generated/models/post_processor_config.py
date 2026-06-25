from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="PostProcessorConfig")


@_attrs_define
class PostProcessorConfig:
    """Post-processing pipeline configuration.

    Attributes:
        disabled_processors (list[str] | None | Unset): Blacklist of processors to disable (None = none)
        enabled (bool | None | Unset): Enable post-processors
        enabled_processors (list[str] | None | Unset): Whitelist of processors to enable (None = all)
    """

    disabled_processors: list[str] | None | Unset = UNSET
    enabled: bool | None | Unset = UNSET
    enabled_processors: list[str] | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        disabled_processors: list[str] | None | Unset
        if isinstance(self.disabled_processors, Unset):
            disabled_processors = UNSET
        elif isinstance(self.disabled_processors, list):
            disabled_processors = self.disabled_processors

        else:
            disabled_processors = self.disabled_processors

        enabled: bool | None | Unset
        if isinstance(self.enabled, Unset):
            enabled = UNSET
        else:
            enabled = self.enabled

        enabled_processors: list[str] | None | Unset
        if isinstance(self.enabled_processors, Unset):
            enabled_processors = UNSET
        elif isinstance(self.enabled_processors, list):
            enabled_processors = self.enabled_processors

        else:
            enabled_processors = self.enabled_processors

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if disabled_processors is not UNSET:
            field_dict["disabled_processors"] = disabled_processors
        if enabled is not UNSET:
            field_dict["enabled"] = enabled
        if enabled_processors is not UNSET:
            field_dict["enabled_processors"] = enabled_processors

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)

        def _parse_disabled_processors(data: object) -> list[str] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                disabled_processors_type_0 = cast("list[str]", data)

                return disabled_processors_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[str] | None | Unset", data)

        disabled_processors = _parse_disabled_processors(d.pop("disabled_processors", UNSET))

        def _parse_enabled(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        enabled = _parse_enabled(d.pop("enabled", UNSET))

        def _parse_enabled_processors(data: object) -> list[str] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                enabled_processors_type_0 = cast("list[str]", data)

                return enabled_processors_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[str] | None | Unset", data)

        enabled_processors = _parse_enabled_processors(d.pop("enabled_processors", UNSET))

        post_processor_config = cls(
            disabled_processors=disabled_processors,
            enabled=enabled,
            enabled_processors=enabled_processors,
        )

        post_processor_config.additional_properties = d
        return post_processor_config

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
