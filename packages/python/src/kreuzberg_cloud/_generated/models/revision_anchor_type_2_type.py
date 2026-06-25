from typing import Literal, cast

RevisionAnchorType2Type = Literal["page"]

REVISION_ANCHOR_TYPE_2_TYPE_VALUES: set[RevisionAnchorType2Type] = {"page"}


def check_revision_anchor_type_2_type(value: str) -> RevisionAnchorType2Type:
    if value in REVISION_ANCHOR_TYPE_2_TYPE_VALUES:
        return cast("RevisionAnchorType2Type", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {REVISION_ANCHOR_TYPE_2_TYPE_VALUES!r}")
