from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="CsvMetadata")


@_attrs_define
class CsvMetadata:
    """CSV/TSV file metadata.

    Attributes:
        column_count (int):
        has_header (bool):
        row_count (int):
        column_types (list[str] | None | Unset):
        delimiter (None | str | Unset):
    """

    column_count: int
    has_header: bool
    row_count: int
    column_types: list[str] | None | Unset = UNSET
    delimiter: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        column_count = self.column_count

        has_header = self.has_header

        row_count = self.row_count

        column_types: list[str] | None | Unset
        if isinstance(self.column_types, Unset):
            column_types = UNSET
        elif isinstance(self.column_types, list):
            column_types = self.column_types

        else:
            column_types = self.column_types

        delimiter: None | str | Unset
        if isinstance(self.delimiter, Unset):
            delimiter = UNSET
        else:
            delimiter = self.delimiter

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "column_count": column_count,
                "has_header": has_header,
                "row_count": row_count,
            }
        )
        if column_types is not UNSET:
            field_dict["column_types"] = column_types
        if delimiter is not UNSET:
            field_dict["delimiter"] = delimiter

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        column_count = d.pop("column_count")

        has_header = d.pop("has_header")

        row_count = d.pop("row_count")

        def _parse_column_types(data: object) -> list[str] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                column_types_type_0 = cast("list[str]", data)

                return column_types_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[str] | None | Unset", data)

        column_types = _parse_column_types(d.pop("column_types", UNSET))

        def _parse_delimiter(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        delimiter = _parse_delimiter(d.pop("delimiter", UNSET))

        csv_metadata = cls(
            column_count=column_count,
            has_header=has_header,
            row_count=row_count,
            column_types=column_types,
            delimiter=delimiter,
        )

        csv_metadata.additional_properties = d
        return csv_metadata

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
