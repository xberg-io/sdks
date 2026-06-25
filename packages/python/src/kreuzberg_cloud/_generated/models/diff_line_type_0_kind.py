from typing import Literal, cast

DiffLineType0Kind = Literal["context"]

DIFF_LINE_TYPE_0_KIND_VALUES: set[DiffLineType0Kind] = {"context"}


def check_diff_line_type_0_kind(value: str) -> DiffLineType0Kind:
    if value in DIFF_LINE_TYPE_0_KIND_VALUES:
        return cast("DiffLineType0Kind", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {DIFF_LINE_TYPE_0_KIND_VALUES!r}")
