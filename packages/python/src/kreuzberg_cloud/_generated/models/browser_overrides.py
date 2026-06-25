from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="BrowserOverrides")


@_attrs_define
class BrowserOverrides:
    """Browser rendering overrides for a specific crawl request.
    Allows per-request override of browser backend, mode, and stealth settings.

    Attributes:
            backend (None | str | Unset): Browser backend: "native" (lightweight Rust-based) or "chromiumoxide" (Chrome-
                based) Example: native.
            mode (None | str | Unset): Browser mode: "auto" (default, use browser if needed), "always" (always use), or
                "never" (never use) Example: auto.
            stealth (bool | None | Unset): Enable browser stealth mode (TLS fingerprint + UA spoof) — only honored by native
                backend
    """

    backend: None | str | Unset = UNSET
    mode: None | str | Unset = UNSET
    stealth: bool | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        backend: None | str | Unset
        if isinstance(self.backend, Unset):
            backend = UNSET
        else:
            backend = self.backend

        mode: None | str | Unset
        if isinstance(self.mode, Unset):
            mode = UNSET
        else:
            mode = self.mode

        stealth: bool | None | Unset
        if isinstance(self.stealth, Unset):
            stealth = UNSET
        else:
            stealth = self.stealth

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if backend is not UNSET:
            field_dict["backend"] = backend
        if mode is not UNSET:
            field_dict["mode"] = mode
        if stealth is not UNSET:
            field_dict["stealth"] = stealth

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)

        def _parse_backend(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        backend = _parse_backend(d.pop("backend", UNSET))

        def _parse_mode(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        mode = _parse_mode(d.pop("mode", UNSET))

        def _parse_stealth(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        stealth = _parse_stealth(d.pop("stealth", UNSET))

        browser_overrides = cls(
            backend=backend,
            mode=mode,
            stealth=stealth,
        )

        browser_overrides.additional_properties = d
        return browser_overrides

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
