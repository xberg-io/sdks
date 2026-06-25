from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="ContentFilterConfig")


@_attrs_define
class ContentFilterConfig:
    """Content filtering configuration (headers, footers, watermarks).

    Attributes:
        include_footers (bool | Unset): Include running footers
        include_headers (bool | Unset): Include running headers
        include_watermarks (bool | Unset): Include watermarks
        strip_repeating_text (bool | Unset): Strip cross-page repeating text
    """

    include_footers: bool | Unset = UNSET
    include_headers: bool | Unset = UNSET
    include_watermarks: bool | Unset = UNSET
    strip_repeating_text: bool | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        include_footers = self.include_footers

        include_headers = self.include_headers

        include_watermarks = self.include_watermarks

        strip_repeating_text = self.strip_repeating_text

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if include_footers is not UNSET:
            field_dict["include_footers"] = include_footers
        if include_headers is not UNSET:
            field_dict["include_headers"] = include_headers
        if include_watermarks is not UNSET:
            field_dict["include_watermarks"] = include_watermarks
        if strip_repeating_text is not UNSET:
            field_dict["strip_repeating_text"] = strip_repeating_text

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        include_footers = d.pop("include_footers", UNSET)

        include_headers = d.pop("include_headers", UNSET)

        include_watermarks = d.pop("include_watermarks", UNSET)

        strip_repeating_text = d.pop("strip_repeating_text", UNSET)

        content_filter_config = cls(
            include_footers=include_footers,
            include_headers=include_headers,
            include_watermarks=include_watermarks,
            strip_repeating_text=strip_repeating_text,
        )

        content_filter_config.additional_properties = d
        return content_filter_config

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
