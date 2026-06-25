from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="DocumentSubmission")


@_attrs_define
class DocumentSubmission:
    """Per-document submission metadata

    Attributes:
        job_id (str): Job ID for the submitted document
        document_id (None | str | Unset): Optional document ID from lineage (None for non-lineage jobs)
        version_sequence (int | None | Unset): Optional version sequence for lineage (None for non-lineage jobs)
    """

    job_id: str
    document_id: None | str | Unset = UNSET
    version_sequence: int | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        job_id = self.job_id

        document_id: None | str | Unset
        if isinstance(self.document_id, Unset):
            document_id = UNSET
        else:
            document_id = self.document_id

        version_sequence: int | None | Unset
        if isinstance(self.version_sequence, Unset):
            version_sequence = UNSET
        else:
            version_sequence = self.version_sequence

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "job_id": job_id,
            }
        )
        if document_id is not UNSET:
            field_dict["document_id"] = document_id
        if version_sequence is not UNSET:
            field_dict["version_sequence"] = version_sequence

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        job_id = d.pop("job_id")

        def _parse_document_id(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        document_id = _parse_document_id(d.pop("document_id", UNSET))

        def _parse_version_sequence(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        version_sequence = _parse_version_sequence(d.pop("version_sequence", UNSET))

        document_submission = cls(
            job_id=job_id,
            document_id=document_id,
            version_sequence=version_sequence,
        )

        document_submission.additional_properties = d
        return document_submission

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
