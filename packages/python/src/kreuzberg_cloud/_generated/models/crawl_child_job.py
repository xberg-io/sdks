from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast
from uuid import UUID

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.extraction_result import ExtractionResult


T = TypeVar("T", bound="CrawlChildJob")


@_attrs_define
class CrawlChildJob:
    """A child extraction job spawned by a crawl job.

    Example:
        {'id': '550e8400-e29b-41d4-a716-446655440000', 'source_url': 'https://example.com/docs/guide.pdf', 'filename':
            'guide.pdf', 'status': 'completed', 'processing_time_ms': 1234}

    Attributes:
        filename (str): Filename Example: guide.pdf.
        id (UUID): Job ID (queryable via GET /v1/jobs/{id}) Example: 550e8400-e29b-41d4-a716-446655440000.
        status (str): Job status Example: completed.
        body_bytes (int | None | Unset): Raw body size in bytes of the source document fed to extraction.
            For HTML pages this is the rendered HTML length; for binary
            documents it is the downloaded file size. Lets callers detect
            suspiciously small responses (e.g. WAF challenge pages captured
            as the "document" — typically 5–30 KB). Example: 18234.
        processing_time_ms (int | None | Unset): Processing time in ms (when completed) Example: 1234.
        result (ExtractionResult | None | Unset):
        source_url (None | str | Unset): Source URL where this document was found Example:
            https://example.com/docs/guide.pdf.
    """

    filename: str
    id: UUID
    status: str
    body_bytes: int | None | Unset = UNSET
    processing_time_ms: int | None | Unset = UNSET
    result: ExtractionResult | None | Unset = UNSET
    source_url: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.extraction_result import ExtractionResult

        filename = self.filename

        id = str(self.id)

        status = self.status

        body_bytes: int | None | Unset
        if isinstance(self.body_bytes, Unset):
            body_bytes = UNSET
        else:
            body_bytes = self.body_bytes

        processing_time_ms: int | None | Unset
        if isinstance(self.processing_time_ms, Unset):
            processing_time_ms = UNSET
        else:
            processing_time_ms = self.processing_time_ms

        result: dict[str, Any] | None | Unset
        if isinstance(self.result, Unset):
            result = UNSET
        elif isinstance(self.result, ExtractionResult):
            result = self.result.to_dict()
        else:
            result = self.result

        source_url: None | str | Unset
        if isinstance(self.source_url, Unset):
            source_url = UNSET
        else:
            source_url = self.source_url

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "filename": filename,
                "id": id,
                "status": status,
            }
        )
        if body_bytes is not UNSET:
            field_dict["body_bytes"] = body_bytes
        if processing_time_ms is not UNSET:
            field_dict["processing_time_ms"] = processing_time_ms
        if result is not UNSET:
            field_dict["result"] = result
        if source_url is not UNSET:
            field_dict["source_url"] = source_url

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.extraction_result import ExtractionResult

        d = dict(src_dict)
        filename = d.pop("filename")

        id = UUID(d.pop("id"))

        status = d.pop("status")

        def _parse_body_bytes(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        body_bytes = _parse_body_bytes(d.pop("body_bytes", UNSET))

        def _parse_processing_time_ms(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        processing_time_ms = _parse_processing_time_ms(d.pop("processing_time_ms", UNSET))

        def _parse_result(data: object) -> ExtractionResult | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                result_type_1 = ExtractionResult.from_dict(data)

                return result_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("ExtractionResult | None | Unset", data)

        result = _parse_result(d.pop("result", UNSET))

        def _parse_source_url(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        source_url = _parse_source_url(d.pop("source_url", UNSET))

        crawl_child_job = cls(
            filename=filename,
            id=id,
            status=status,
            body_bytes=body_bytes,
            processing_time_ms=processing_time_ms,
            result=result,
            source_url=source_url,
        )

        crawl_child_job.additional_properties = d
        return crawl_child_job

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
