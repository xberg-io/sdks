from typing import Literal, cast

DiffLineType2Kind = Literal["removed"]

DIFF_LINE_TYPE_2_KIND_VALUES: set[DiffLineType2Kind] = {"removed"}


def check_diff_line_type_2_kind(value: str) -> DiffLineType2Kind:
    if value in DIFF_LINE_TYPE_2_KIND_VALUES:
        return cast("DiffLineType2Kind", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {DIFF_LINE_TYPE_2_KIND_VALUES!r}")
