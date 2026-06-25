from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast
from uuid import UUID

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="DocumentVersionEntry")


@_attrs_define
class DocumentVersionEntry:
    """Entry in the document versions list.

    Attributes:
        billable_pages (int): Number of billable pages.
        content_hash (str): SHA-256 hash of the extracted content.
        created_at (str): When the job was created.
        file_size_bytes (int): File size in bytes.
        filename (str): Original filename.
        job_id (UUID): Job ID for this version. Example: 550e8400-e29b-41d4-a716-446655440000.
        mime_type (str): MIME type of the uploaded file.
        pages_extracted (int): Number of pages extracted.
        status (str): Job status.
        version_sequence (int): Version sequence number (incrementing per document).
        processing_completed_at (None | str | Unset): When processing completed (only set for completed/failed jobs).
    """

    billable_pages: int
    content_hash: str
    created_at: str
    file_size_bytes: int
    filename: str
    job_id: UUID
    mime_type: str
    pages_extracted: int
    status: str
    version_sequence: int
    processing_completed_at: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        billable_pages = self.billable_pages

        content_hash = self.content_hash

        created_at = self.created_at

        file_size_bytes = self.file_size_bytes

        filename = self.filename

        job_id = str(self.job_id)

        mime_type = self.mime_type

        pages_extracted = self.pages_extracted

        status = self.status

        version_sequence = self.version_sequence

        processing_completed_at: None | str | Unset
        if isinstance(self.processing_completed_at, Unset):
            processing_completed_at = UNSET
        else:
            processing_completed_at = self.processing_completed_at

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "billable_pages": billable_pages,
                "content_hash": content_hash,
                "created_at": created_at,
                "file_size_bytes": file_size_bytes,
                "filename": filename,
                "job_id": job_id,
                "mime_type": mime_type,
                "pages_extracted": pages_extracted,
                "status": status,
                "version_sequence": version_sequence,
            }
        )
        if processing_completed_at is not UNSET:
            field_dict["processing_completed_at"] = processing_completed_at

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        billable_pages = d.pop("billable_pages")

        content_hash = d.pop("content_hash")

        created_at = d.pop("created_at")

        file_size_bytes = d.pop("file_size_bytes")

        filename = d.pop("filename")

        job_id = UUID(d.pop("job_id"))

        mime_type = d.pop("mime_type")

        pages_extracted = d.pop("pages_extracted")

        status = d.pop("status")

        version_sequence = d.pop("version_sequence")

        def _parse_processing_completed_at(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        processing_completed_at = _parse_processing_completed_at(d.pop("processing_completed_at", UNSET))

        document_version_entry = cls(
            billable_pages=billable_pages,
            content_hash=content_hash,
            created_at=created_at,
            file_size_bytes=file_size_bytes,
            filename=filename,
            job_id=job_id,
            mime_type=mime_type,
            pages_extracted=pages_extracted,
            status=status,
            version_sequence=version_sequence,
            processing_completed_at=processing_completed_at,
        )

        document_version_entry.additional_properties = d
        return document_version_entry

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
