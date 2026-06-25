from typing import Literal, cast

CrawlJobStatus = Literal["cancelled", "completed", "crawling", "extracting", "failed", "partial_success", "pending"]

CRAWL_JOB_STATUS_VALUES: set[CrawlJobStatus] = {
    "cancelled",
    "completed",
    "crawling",
    "extracting",
    "failed",
    "partial_success",
    "pending",
}


def check_crawl_job_status(value: str) -> CrawlJobStatus:
    if value in CRAWL_JOB_STATUS_VALUES:
        return cast("CrawlJobStatus", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {CRAWL_JOB_STATUS_VALUES!r}")
