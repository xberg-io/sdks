from typing import Literal, cast

RevisionAnchorType4Type = Literal["sheet"]

REVISION_ANCHOR_TYPE_4_TYPE_VALUES: set[RevisionAnchorType4Type] = {"sheet"}


def check_revision_anchor_type_4_type(value: str) -> RevisionAnchorType4Type:
    if value in REVISION_ANCHOR_TYPE_4_TYPE_VALUES:
        return cast("RevisionAnchorType4Type", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {REVISION_ANCHOR_TYPE_4_TYPE_VALUES!r}")
