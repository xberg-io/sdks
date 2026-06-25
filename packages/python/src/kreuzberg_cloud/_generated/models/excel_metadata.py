from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="ExcelMetadata")


@_attrs_define
class ExcelMetadata:
    """Excel/spreadsheet format metadata.

    Identifies the document as a spreadsheet source via the `FormatMetadata::Excel`
    discriminant. Sheet count and sheet names are stored inside this struct.

    Attributes:
            sheet_count (int | None | Unset): Number of sheets in the workbook.
            sheet_names (list[str] | None | Unset): Names of all sheets in the workbook.
    """

    sheet_count: int | None | Unset = UNSET
    sheet_names: list[str] | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        sheet_count: int | None | Unset
        if isinstance(self.sheet_count, Unset):
            sheet_count = UNSET
        else:
            sheet_count = self.sheet_count

        sheet_names: list[str] | None | Unset
        if isinstance(self.sheet_names, Unset):
            sheet_names = UNSET
        elif isinstance(self.sheet_names, list):
            sheet_names = self.sheet_names

        else:
            sheet_names = self.sheet_names

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if sheet_count is not UNSET:
            field_dict["sheet_count"] = sheet_count
        if sheet_names is not UNSET:
            field_dict["sheet_names"] = sheet_names

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)

        def _parse_sheet_count(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        sheet_count = _parse_sheet_count(d.pop("sheet_count", UNSET))

        def _parse_sheet_names(data: object) -> list[str] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                sheet_names_type_0 = cast("list[str]", data)

                return sheet_names_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[str] | None | Unset", data)

        sheet_names = _parse_sheet_names(d.pop("sheet_names", UNSET))

        excel_metadata = cls(
            sheet_count=sheet_count,
            sheet_names=sheet_names,
        )

        excel_metadata.additional_properties = d
        return excel_metadata

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
