from typing import Literal, cast

RevisionAnchorType0Type = Literal["paragraph"]

REVISION_ANCHOR_TYPE_0_TYPE_VALUES: set[RevisionAnchorType0Type] = {"paragraph"}


def check_revision_anchor_type_0_type(value: str) -> RevisionAnchorType0Type:
    if value in REVISION_ANCHOR_TYPE_0_TYPE_VALUES:
        return cast("RevisionAnchorType0Type", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {REVISION_ANCHOR_TYPE_0_TYPE_VALUES!r}")
