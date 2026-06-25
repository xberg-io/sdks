from __future__ import annotations

import datetime
from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast
from uuid import UUID

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from dateutil.parser import isoparse
from typing_extensions import Self

from ..models.job_status import JobStatus, check_job_status
from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.extraction_result import ExtractionResult


T = TypeVar("T", bound="JobResponse")


@_attrs_define
class JobResponse:
    """Response for job status query

    Attributes:
        created_at (datetime.datetime): Job creation timestamp (RFC3339) Example: 2025-12-21T10:00:00Z.
        filename (str): Original filename Example: invoice.pdf.
        id (UUID): Unique job identifier (UUID) Example: 550e8400-e29b-41d4-a716-446655440000.
        status (JobStatus): Job status enumeration (1:1 with domain).
        processing_time_ms (int | None | Unset): Server-side processing duration in milliseconds (only present when
            completed) Example: 1234.
        result (ExtractionResult | None | Unset):
    """

    created_at: datetime.datetime
    filename: str
    id: UUID
    status: JobStatus
    processing_time_ms: int | None | Unset = UNSET
    result: ExtractionResult | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.extraction_result import ExtractionResult

        created_at = self.created_at.isoformat()

        filename = self.filename

        id = str(self.id)

        status: str = self.status

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

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "created_at": created_at,
                "filename": filename,
                "id": id,
                "status": status,
            }
        )
        if processing_time_ms is not UNSET:
            field_dict["processing_time_ms"] = processing_time_ms
        if result is not UNSET:
            field_dict["result"] = result

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.extraction_result import ExtractionResult

        d = dict(src_dict)
        created_at = isoparse(d.pop("created_at"))

        filename = d.pop("filename")

        id = UUID(d.pop("id"))

        status = check_job_status(d.pop("status"))

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

        job_response = cls(
            created_at=created_at,
            filename=filename,
            id=id,
            status=status,
            processing_time_ms=processing_time_ms,
            result=result,
        )

        job_response.additional_properties = d
        return job_response

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
