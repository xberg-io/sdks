from typing import Literal, cast

BlockType = Literal[
    "blockquote",
    "bullet_list",
    "code_block",
    "definition_description",
    "definition_list",
    "definition_term",
    "div",
    "heading",
    "list_item",
    "math_display",
    "ordered_list",
    "paragraph",
    "raw_block",
    "section",
    "task_list",
    "thematic_break",
]

BLOCK_TYPE_VALUES: set[BlockType] = {
    "blockquote",
    "bullet_list",
    "code_block",
    "definition_description",
    "definition_list",
    "definition_term",
    "div",
    "heading",
    "list_item",
    "math_display",
    "ordered_list",
    "paragraph",
    "raw_block",
    "section",
    "task_list",
    "thematic_break",
}


def check_block_type(value: str) -> BlockType:
    if value in BLOCK_TYPE_VALUES:
        return cast("BlockType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {BLOCK_TYPE_VALUES!r}")
