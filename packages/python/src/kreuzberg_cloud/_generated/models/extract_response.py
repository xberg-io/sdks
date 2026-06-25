from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.document_submission import DocumentSubmission


T = TypeVar("T", bound="ExtractResponse")


@_attrs_define
class ExtractResponse:
    """Extract response (HTTP 202)

    Attributes:
        status (str): Job status
        crawl_job_ids (list[str] | Unset): Crawl job IDs (one per URL group)
        documents (list[DocumentSubmission] | Unset): Detailed document submissions (new, includes lineage when present)
        job_ids (list[str] | Unset): Job IDs for direct file extractions (backward compat)
    """

    status: str
    crawl_job_ids: list[str] | Unset = UNSET
    documents: list[DocumentSubmission] | Unset = UNSET
    job_ids: list[str] | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        status = self.status

        crawl_job_ids: list[str] | Unset = UNSET
        if not isinstance(self.crawl_job_ids, Unset):
            crawl_job_ids = self.crawl_job_ids

        documents: list[dict[str, Any]] | Unset = UNSET
        if not isinstance(self.documents, Unset):
            documents = []
            for documents_item_data in self.documents:
                documents_item = documents_item_data.to_dict()
                documents.append(documents_item)

        job_ids: list[str] | Unset = UNSET
        if not isinstance(self.job_ids, Unset):
            job_ids = self.job_ids

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "status": status,
            }
        )
        if crawl_job_ids is not UNSET:
            field_dict["crawl_job_ids"] = crawl_job_ids
        if documents is not UNSET:
            field_dict["documents"] = documents
        if job_ids is not UNSET:
            field_dict["job_ids"] = job_ids

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.document_submission import DocumentSubmission

        d = dict(src_dict)
        status = d.pop("status")

        crawl_job_ids = cast("list[str]", d.pop("crawl_job_ids", UNSET))

        _documents = d.pop("documents", UNSET)
        documents: list[DocumentSubmission] | Unset = UNSET
        if _documents is not UNSET:
            documents = []
            for documents_item_data in _documents:
                documents_item = DocumentSubmission.from_dict(documents_item_data)

                documents.append(documents_item)

        job_ids = cast("list[str]", d.pop("job_ids", UNSET))

        extract_response = cls(
            status=status,
            crawl_job_ids=crawl_job_ids,
            documents=documents,
            job_ids=job_ids,
        )

        extract_response.additional_properties = d
        return extract_response

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
