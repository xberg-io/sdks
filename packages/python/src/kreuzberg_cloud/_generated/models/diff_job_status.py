from typing import Literal, cast

DiffJobStatus = Literal["failed", "pending", "succeeded"]

DIFF_JOB_STATUS_VALUES: set[DiffJobStatus] = {"failed", "pending", "succeeded"}


def check_diff_job_status(value: str) -> DiffJobStatus:
    if value in DIFF_JOB_STATUS_VALUES:
        return cast("DiffJobStatus", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {DIFF_JOB_STATUS_VALUES!r}")
