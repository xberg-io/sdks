from typing import Literal, cast

RevisionAnchorType3Type = Literal["slide"]

REVISION_ANCHOR_TYPE_3_TYPE_VALUES: set[RevisionAnchorType3Type] = {"slide"}


def check_revision_anchor_type_3_type(value: str) -> RevisionAnchorType3Type:
    if value in REVISION_ANCHOR_TYPE_3_TYPE_VALUES:
        return cast("RevisionAnchorType3Type", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {REVISION_ANCHOR_TYPE_3_TYPE_VALUES!r}")
