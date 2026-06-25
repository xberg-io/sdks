from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.extraction_config import ExtractionConfig


T = TypeVar("T", bound="ExtractionOptions")


@_attrs_define
class ExtractionOptions:
    """Extraction options (shared by JSON and multipart requests)

    Attributes:
        extraction_config (ExtractionConfig | None | Unset):
    """

    extraction_config: ExtractionConfig | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.extraction_config import ExtractionConfig

        extraction_config: dict[str, Any] | None | Unset
        if isinstance(self.extraction_config, Unset):
            extraction_config = UNSET
        elif isinstance(self.extraction_config, ExtractionConfig):
            extraction_config = self.extraction_config.to_dict()
        else:
            extraction_config = self.extraction_config

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if extraction_config is not UNSET:
            field_dict["extraction_config"] = extraction_config

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.extraction_config import ExtractionConfig

        d = dict(src_dict)

        def _parse_extraction_config(data: object) -> ExtractionConfig | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                extraction_config_type_1 = ExtractionConfig.from_dict(data)

                return extraction_config_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("ExtractionConfig | None | Unset", data)

        extraction_config = _parse_extraction_config(d.pop("extraction_config", UNSET))

        extraction_options = cls(
            extraction_config=extraction_config,
        )

        extraction_options.additional_properties = d
        return extraction_options

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
