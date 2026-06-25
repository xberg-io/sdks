from typing import Literal, cast

RevisionAnchorType1Type = Literal["table_cell"]

REVISION_ANCHOR_TYPE_1_TYPE_VALUES: set[RevisionAnchorType1Type] = {"table_cell"}


def check_revision_anchor_type_1_type(value: str) -> RevisionAnchorType1Type:
    if value in REVISION_ANCHOR_TYPE_1_TYPE_VALUES:
        return cast("RevisionAnchorType1Type", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {REVISION_ANCHOR_TYPE_1_TYPE_VALUES!r}")
