from typing import Literal, cast

InlineType = Literal[
    "code",
    "delete",
    "emphasis",
    "footnote_ref",
    "highlight",
    "image",
    "insert",
    "link",
    "math",
    "raw_inline",
    "span",
    "strong",
    "subscript",
    "superscript",
    "symbol",
    "text",
]

INLINE_TYPE_VALUES: set[InlineType] = {
    "code",
    "delete",
    "emphasis",
    "footnote_ref",
    "highlight",
    "image",
    "insert",
    "link",
    "math",
    "raw_inline",
    "span",
    "strong",
    "subscript",
    "superscript",
    "symbol",
    "text",
}


def check_inline_type(value: str) -> InlineType:
    if value in INLINE_TYPE_VALUES:
        return cast("InlineType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {INLINE_TYPE_VALUES!r}")
