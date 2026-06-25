from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

if TYPE_CHECKING:
    from ..models.extraction_result import ExtractionResult


T = TypeVar("T", bound="ArchiveEntry")


@_attrs_define
class ArchiveEntry:
    """A single file extracted from an archive.

    When archives (ZIP, TAR, 7Z, GZIP) are extracted with recursive extraction
    enabled, each processable file produces its own full `ExtractionResult`.

    Attributes:
            mime_type (str): Detected MIME type of the file.
            path (str): Archive-relative file path (e.g. "folder/document.pdf").
            result (ExtractionResult): General extraction result used by the core extraction API.

                This is the main result type returned by all extraction functions.
    """

    mime_type: str
    path: str
    result: ExtractionResult
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        mime_type = self.mime_type

        path = self.path

        result = self.result.to_dict()

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "mime_type": mime_type,
                "path": path,
                "result": result,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.extraction_result import ExtractionResult

        d = dict(src_dict)
        mime_type = d.pop("mime_type")

        path = d.pop("path")

        result = ExtractionResult.from_dict(d.pop("result"))

        archive_entry = cls(
            mime_type=mime_type,
            path=path,
            result=result,
        )

        archive_entry.additional_properties = d
        return archive_entry

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
