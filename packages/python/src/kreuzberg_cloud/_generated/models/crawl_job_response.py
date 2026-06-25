from __future__ import annotations

import datetime
from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast
from uuid import UUID

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from dateutil.parser import isoparse
from typing_extensions import Self

from ..models.crawl_job_status import CrawlJobStatus, check_crawl_job_status
from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.crawl_child_job import CrawlChildJob
    from ..models.crawl_progress import CrawlProgress
    from ..models.crawled_page import CrawledPage


T = TypeVar("T", bound="CrawlJobResponse")


@_attrs_define
class CrawlJobResponse:
    """Response for crawl job status query

    Example:
        {'id': '660e9400-f39c-51e5-b827-557766551111', 'status': 'extracting', 'seed_urls':
            ['https://example.com/docs'], 'created_at': '2025-12-21T10:00:00Z', 'progress': {'pages_crawled': 42,
            'documents_discovered': 15, 'documents_extracted': 10, 'documents_failed': 0}, 'jobs': []}

    Attributes:
        created_at (datetime.datetime): Creation timestamp (RFC3339) Example: 2025-12-21T10:00:00Z.
        id (UUID): Crawl job ID Example: 660e9400-f39c-51e5-b827-557766551111.
        output_mode (str): Output mode this job was submitted with (scrape, crawl, or extract) Example: extract.
        progress (CrawlProgress): Crawl progress counters
        seed_urls (list[str]): Seed URLs that were submitted Example: ['https://example.com/docs'].
        status (CrawlJobStatus): Crawl job status
        jobs (list[CrawlChildJob] | Unset): Child extraction jobs (populated when output_mode=extract)
        pages (list[CrawledPage] | Unset): Crawled raw pages (populated when output_mode=scrape|crawl)
    """

    created_at: datetime.datetime
    id: UUID
    output_mode: str
    progress: CrawlProgress
    seed_urls: list[str]
    status: CrawlJobStatus
    jobs: list[CrawlChildJob] | Unset = UNSET
    pages: list[CrawledPage] | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        created_at = self.created_at.isoformat()

        id = str(self.id)

        output_mode = self.output_mode

        progress = self.progress.to_dict()

        seed_urls = self.seed_urls

        status: str = self.status

        jobs: list[dict[str, Any]] | Unset = UNSET
        if not isinstance(self.jobs, Unset):
            jobs = []
            for jobs_item_data in self.jobs:
                jobs_item = jobs_item_data.to_dict()
                jobs.append(jobs_item)

        pages: list[dict[str, Any]] | Unset = UNSET
        if not isinstance(self.pages, Unset):
            pages = []
            for pages_item_data in self.pages:
                pages_item = pages_item_data.to_dict()
                pages.append(pages_item)

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "created_at": created_at,
                "id": id,
                "output_mode": output_mode,
                "progress": progress,
                "seed_urls": seed_urls,
                "status": status,
            }
        )
        if jobs is not UNSET:
            field_dict["jobs"] = jobs
        if pages is not UNSET:
            field_dict["pages"] = pages

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.crawl_child_job import CrawlChildJob
        from ..models.crawl_progress import CrawlProgress
        from ..models.crawled_page import CrawledPage

        d = dict(src_dict)
        created_at = isoparse(d.pop("created_at"))

        id = UUID(d.pop("id"))

        output_mode = d.pop("output_mode")

        progress = CrawlProgress.from_dict(d.pop("progress"))

        seed_urls = cast("list[str]", d.pop("seed_urls"))

        status = check_crawl_job_status(d.pop("status"))

        _jobs = d.pop("jobs", UNSET)
        jobs: list[CrawlChildJob] | Unset = UNSET
        if _jobs is not UNSET:
            jobs = []
            for jobs_item_data in _jobs:
                jobs_item = CrawlChildJob.from_dict(jobs_item_data)

                jobs.append(jobs_item)

        _pages = d.pop("pages", UNSET)
        pages: list[CrawledPage] | Unset = UNSET
        if _pages is not UNSET:
            pages = []
            for pages_item_data in _pages:
                pages_item = CrawledPage.from_dict(pages_item_data)

                pages.append(pages_item)

        crawl_job_response = cls(
            created_at=created_at,
            id=id,
            output_mode=output_mode,
            progress=progress,
            seed_urls=seed_urls,
            status=status,
            jobs=jobs,
            pages=pages,
        )

        crawl_job_response.additional_properties = d
        return crawl_job_response

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
