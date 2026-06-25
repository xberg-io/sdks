from typing import Literal, cast

RevisionKind = Literal["comment", "deletion", "format_change", "insertion"]

REVISION_KIND_VALUES: set[RevisionKind] = {"comment", "deletion", "format_change", "insertion"}


def check_revision_kind(value: str) -> RevisionKind:
    if value in REVISION_KIND_VALUES:
        return cast("RevisionKind", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {REVISION_KIND_VALUES!r}")
