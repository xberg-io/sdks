from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.structured_data_type import StructuredDataType, check_structured_data_type
from ..types import UNSET, Unset

T = TypeVar("T", bound="StructuredData")


@_attrs_define
class StructuredData:
    """Structured data (Schema.org, microdata, RDFa) block.

    Attributes:
        data_type (StructuredDataType): Structured data type classification.
        raw_json (str): Raw JSON string representation
        schema_type (None | str | Unset): Schema type if detectable (e.g., "Article", "Event", "Product")
    """

    data_type: StructuredDataType
    raw_json: str
    schema_type: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        data_type: str = self.data_type

        raw_json = self.raw_json

        schema_type: None | str | Unset
        if isinstance(self.schema_type, Unset):
            schema_type = UNSET
        else:
            schema_type = self.schema_type

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "data_type": data_type,
                "raw_json": raw_json,
            }
        )
        if schema_type is not UNSET:
            field_dict["schema_type"] = schema_type

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        data_type = check_structured_data_type(d.pop("data_type"))

        raw_json = d.pop("raw_json")

        def _parse_schema_type(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        schema_type = _parse_schema_type(d.pop("schema_type", UNSET))

        structured_data = cls(
            data_type=data_type,
            raw_json=raw_json,
            schema_type=schema_type,
        )

        structured_data.additional_properties = d
        return structured_data

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
