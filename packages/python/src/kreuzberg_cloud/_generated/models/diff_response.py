from __future__ import annotations

import datetime
from collections.abc import Mapping
from typing import Any, TypeVar
from uuid import UUID

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from dateutil.parser import isoparse
from typing_extensions import Self

T = TypeVar("T", bound="DiffResponse")


@_attrs_define
class DiffResponse:
    """Response envelope for a computed diff between two extraction results.

    Attributes:
        computed_at (datetime.datetime): Timestamp when the diff was computed.
        diff (Any): The computed diff between the two extraction results.

            Serialized to the wire as the full `kreuzberg::diff::ExtractionDiff`
            shape. The OpenAPI schema declares this as an opaque object because
            the underlying type recurses through `EmbeddedDiff -> Box<ExtractionDiff>`
            and utoipa's schema collector goes into a stack-overflow on inlined
            recursion. SDKs that want a typed surface here should decode the
            JSON manually against kreuzberg's published schema.
        document_id (UUID): Document ID being diffed.
        from_job_id (UUID): Job ID of the "from" (older) version.
        from_version (int): Version sequence number of the "from" version.
        to_job_id (UUID): Job ID of the "to" (newer) version.
        to_version (int): Version sequence number of the "to" version.
    """

    computed_at: datetime.datetime
    diff: Any
    document_id: UUID
    from_job_id: UUID
    from_version: int
    to_job_id: UUID
    to_version: int
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        computed_at = self.computed_at.isoformat()

        diff = self.diff

        document_id = str(self.document_id)

        from_job_id = str(self.from_job_id)

        from_version = self.from_version

        to_job_id = str(self.to_job_id)

        to_version = self.to_version

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "computed_at": computed_at,
                "diff": diff,
                "document_id": document_id,
                "from_job_id": from_job_id,
                "from_version": from_version,
                "to_job_id": to_job_id,
                "to_version": to_version,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        computed_at = isoparse(d.pop("computed_at"))

        diff = d.pop("diff")

        document_id = UUID(d.pop("document_id"))

        from_job_id = UUID(d.pop("from_job_id"))

        from_version = d.pop("from_version")

        to_job_id = UUID(d.pop("to_job_id"))

        to_version = d.pop("to_version")

        diff_response = cls(
            computed_at=computed_at,
            diff=diff,
            document_id=document_id,
            from_job_id=from_job_id,
            from_version=from_version,
            to_job_id=to_job_id,
            to_version=to_version,
        )

        diff_response.additional_properties = d
        return diff_response

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
