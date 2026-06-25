from typing import Literal, cast

DiffLineType1Kind = Literal["added"]

DIFF_LINE_TYPE_1_KIND_VALUES: set[DiffLineType1Kind] = {"added"}


def check_diff_line_type_1_kind(value: str) -> DiffLineType1Kind:
    if value in DIFF_LINE_TYPE_1_KIND_VALUES:
        return cast("DiffLineType1Kind", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {DIFF_LINE_TYPE_1_KIND_VALUES!r}")
