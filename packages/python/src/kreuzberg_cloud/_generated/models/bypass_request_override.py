from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.bypass_mode import BypassMode, check_bypass_mode
from ..types import UNSET, Unset

T = TypeVar("T", bound="BypassRequestOverride")


@_attrs_define
class BypassRequestOverride:
    """Per-request bypass override. When set on a crawl request, applies an
    external bypass provider (e.g., Bright Data, Zyte, ScrapingBee) to bypass
    WAF/antibot on the crawl.

    Attributes:
            mode (BypassMode): Bypass mode — determines whether cloud provides credentials (managed) or
                the customer does (bring-your-own).
            vendor (str): Vendor identifier — must be registered in bypass-providers/registry.
                Today: "bright_data" | "zyte" | "scrapingbee".
            credentials (Any | Unset): Per-vendor credentials JSON. Required when mode = byo; ignored for
                managed (cloud uses its own credentials from Secret Manager).
    """

    mode: BypassMode
    vendor: str
    credentials: Any | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        mode: str = self.mode

        vendor = self.vendor

        credentials = self.credentials

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "mode": mode,
                "vendor": vendor,
            }
        )
        if credentials is not UNSET:
            field_dict["credentials"] = credentials

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        mode = check_bypass_mode(d.pop("mode"))

        vendor = d.pop("vendor")

        credentials = d.pop("credentials", UNSET)

        bypass_request_override = cls(
            mode=mode,
            vendor=vendor,
            credentials=credentials,
        )

        bypass_request_override.additional_properties = d
        return bypass_request_override

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
