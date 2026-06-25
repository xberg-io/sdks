from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="OcrMetadata")


@_attrs_define
class OcrMetadata:
    """OCR processing metadata.

    Captures information about OCR processing configuration and results.

    Attributes:
            language (str): OCR language code(s) used
            output_format (str): Output format (e.g., "text", "hocr")
            psm (int): Tesseract Page Segmentation Mode (PSM)
            table_count (int): Number of tables detected
            table_cols (int | None | Unset):
            table_rows (int | None | Unset):
    """

    language: str
    output_format: str
    psm: int
    table_count: int
    table_cols: int | None | Unset = UNSET
    table_rows: int | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        language = self.language

        output_format = self.output_format

        psm = self.psm

        table_count = self.table_count

        table_cols: int | None | Unset
        if isinstance(self.table_cols, Unset):
            table_cols = UNSET
        else:
            table_cols = self.table_cols

        table_rows: int | None | Unset
        if isinstance(self.table_rows, Unset):
            table_rows = UNSET
        else:
            table_rows = self.table_rows

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "language": language,
                "output_format": output_format,
                "psm": psm,
                "table_count": table_count,
            }
        )
        if table_cols is not UNSET:
            field_dict["table_cols"] = table_cols
        if table_rows is not UNSET:
            field_dict["table_rows"] = table_rows

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        language = d.pop("language")

        output_format = d.pop("output_format")

        psm = d.pop("psm")

        table_count = d.pop("table_count")

        def _parse_table_cols(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        table_cols = _parse_table_cols(d.pop("table_cols", UNSET))

        def _parse_table_rows(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        table_rows = _parse_table_rows(d.pop("table_rows", UNSET))

        ocr_metadata = cls(
            language=language,
            output_format=output_format,
            psm=psm,
            table_count=table_count,
            table_cols=table_cols,
            table_rows=table_rows,
        )

        ocr_metadata.additional_properties = d
        return ocr_metadata

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
