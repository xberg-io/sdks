from typing import Literal, cast

ElementType = Literal[
    "block_quote",
    "code_block",
    "footer",
    "header",
    "heading",
    "image",
    "list_item",
    "narrative_text",
    "page_break",
    "table",
    "title",
]

ELEMENT_TYPE_VALUES: set[ElementType] = {
    "block_quote",
    "code_block",
    "footer",
    "header",
    "heading",
    "image",
    "list_item",
    "narrative_text",
    "page_break",
    "table",
    "title",
}


def check_element_type(value: str) -> ElementType:
    if value in ELEMENT_TYPE_VALUES:
        return cast("ElementType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {ELEMENT_TYPE_VALUES!r}")
