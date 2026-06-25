from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="ArchiveMetadata")


@_attrs_define
class ArchiveMetadata:
    """Archive (ZIP/TAR/7Z) metadata.

    Extracted from compressed archive files containing file lists and size information.

    Attributes:
            file_count (int): Total number of files in the archive
            file_list (list[str]): List of file paths within the archive
            format_ (str): Archive format ("ZIP", "TAR", "7Z", etc.)
            total_size (int): Total uncompressed size in bytes
            compressed_size (int | None | Unset): Compressed size in bytes (if available)
    """

    file_count: int
    file_list: list[str]
    format_: str
    total_size: int
    compressed_size: int | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        file_count = self.file_count

        file_list = self.file_list

        format_ = self.format_

        total_size = self.total_size

        compressed_size: int | None | Unset
        if isinstance(self.compressed_size, Unset):
            compressed_size = UNSET
        else:
            compressed_size = self.compressed_size

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "file_count": file_count,
                "file_list": file_list,
                "format": format_,
                "total_size": total_size,
            }
        )
        if compressed_size is not UNSET:
            field_dict["compressed_size"] = compressed_size

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        file_count = d.pop("file_count")

        file_list = cast("list[str]", d.pop("file_list"))

        format_ = d.pop("format")

        total_size = d.pop("total_size")

        def _parse_compressed_size(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        compressed_size = _parse_compressed_size(d.pop("compressed_size", UNSET))

        archive_metadata = cls(
            file_count=file_count,
            file_list=file_list,
            format_=format_,
            total_size=total_size,
            compressed_size=compressed_size,
        )

        archive_metadata.additional_properties = d
        return archive_metadata

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
