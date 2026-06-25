from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.usage_response_by_mime_type import UsageResponseByMimeType


T = TypeVar("T", bound="UsageResponse")


@_attrs_define
class UsageResponse:
    """Current period usage and quota information.

    Attributes:
        by_mime_type (UsageResponseByMimeType): Usage breakdown by MIME type
        period_end (str): End of the reporting period (ISO 8601 date)
        period_start (str): Start of the reporting period (ISO 8601 date)
        total_documents (int): Total documents processed in the period
        total_failed (int): Total failed extractions in the period
        total_pages (int): Total pages extracted in the period
        quota_limit (int | None | Unset): Monthly page quota limit (null = unlimited)
        quota_remaining (int | None | Unset): Remaining pages in monthly quota (null = unlimited)
    """

    by_mime_type: UsageResponseByMimeType
    period_end: str
    period_start: str
    total_documents: int
    total_failed: int
    total_pages: int
    quota_limit: int | None | Unset = UNSET
    quota_remaining: int | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        by_mime_type = self.by_mime_type.to_dict()

        period_end = self.period_end

        period_start = self.period_start

        total_documents = self.total_documents

        total_failed = self.total_failed

        total_pages = self.total_pages

        quota_limit: int | None | Unset
        if isinstance(self.quota_limit, Unset):
            quota_limit = UNSET
        else:
            quota_limit = self.quota_limit

        quota_remaining: int | None | Unset
        if isinstance(self.quota_remaining, Unset):
            quota_remaining = UNSET
        else:
            quota_remaining = self.quota_remaining

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "by_mime_type": by_mime_type,
                "period_end": period_end,
                "period_start": period_start,
                "total_documents": total_documents,
                "total_failed": total_failed,
                "total_pages": total_pages,
            }
        )
        if quota_limit is not UNSET:
            field_dict["quota_limit"] = quota_limit
        if quota_remaining is not UNSET:
            field_dict["quota_remaining"] = quota_remaining

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.usage_response_by_mime_type import UsageResponseByMimeType

        d = dict(src_dict)
        by_mime_type = UsageResponseByMimeType.from_dict(d.pop("by_mime_type"))

        period_end = d.pop("period_end")

        period_start = d.pop("period_start")

        total_documents = d.pop("total_documents")

        total_failed = d.pop("total_failed")

        total_pages = d.pop("total_pages")

        def _parse_quota_limit(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        quota_limit = _parse_quota_limit(d.pop("quota_limit", UNSET))

        def _parse_quota_remaining(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        quota_remaining = _parse_quota_remaining(d.pop("quota_remaining", UNSET))

        usage_response = cls(
            by_mime_type=by_mime_type,
            period_end=period_end,
            period_start=period_start,
            total_documents=total_documents,
            total_failed=total_failed,
            total_pages=total_pages,
            quota_limit=quota_limit,
            quota_remaining=quota_remaining,
        )

        usage_response.additional_properties = d
        return usage_response

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
