from typing import Literal, cast

JobStatus = Literal[
    "aggregating",
    "awaiting_upload",
    "cancelled",
    "chunking",
    "completed",
    "failed",
    "partial_success",
    "pending",
    "processing",
]

JOB_STATUS_VALUES: set[JobStatus] = {
    "aggregating",
    "awaiting_upload",
    "cancelled",
    "chunking",
    "completed",
    "failed",
    "partial_success",
    "pending",
    "processing",
}


def check_job_status(value: str) -> JobStatus:
    if value in JOB_STATUS_VALUES:
        return cast("JobStatus", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {JOB_STATUS_VALUES!r}")
