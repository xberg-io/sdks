from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="TokenReductionConfig")


@_attrs_define
class TokenReductionConfig:
    """Token reduction configuration for LLM consumption.

    Attributes:
        mode (None | str | Unset): Reduction mode: "off", "light", "moderate", "aggressive", "maximum"
        preserve_important_words (bool | None | Unset): Preserve capitalized/technical terms
    """

    mode: None | str | Unset = UNSET
    preserve_important_words: bool | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        mode: None | str | Unset
        if isinstance(self.mode, Unset):
            mode = UNSET
        else:
            mode = self.mode

        preserve_important_words: bool | None | Unset
        if isinstance(self.preserve_important_words, Unset):
            preserve_important_words = UNSET
        else:
            preserve_important_words = self.preserve_important_words

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if mode is not UNSET:
            field_dict["mode"] = mode
        if preserve_important_words is not UNSET:
            field_dict["preserve_important_words"] = preserve_important_words

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)

        def _parse_mode(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        mode = _parse_mode(d.pop("mode", UNSET))

        def _parse_preserve_important_words(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        preserve_important_words = _parse_preserve_important_words(d.pop("preserve_important_words", UNSET))

        token_reduction_config = cls(
            mode=mode,
            preserve_important_words=preserve_important_words,
        )

        token_reduction_config.additional_properties = d
        return token_reduction_config

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
