from typing import Literal, cast

RelationshipKind = Literal[
    "caption", "citation_reference", "cross_reference", "footnote_reference", "internal_link", "label", "toc_entry"
]

RELATIONSHIP_KIND_VALUES: set[RelationshipKind] = {
    "caption",
    "citation_reference",
    "cross_reference",
    "footnote_reference",
    "internal_link",
    "label",
    "toc_entry",
}


def check_relationship_kind(value: str) -> RelationshipKind:
    if value in RELATIONSHIP_KIND_VALUES:
        return cast("RelationshipKind", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {RELATIONSHIP_KIND_VALUES!r}")
