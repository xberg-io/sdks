from typing import Literal, cast

NodeContentType18NodeType = Literal["raw_block"]

NODE_CONTENT_TYPE_18_NODE_TYPE_VALUES: set[NodeContentType18NodeType] = {"raw_block"}


def check_node_content_type_18_node_type(value: str) -> NodeContentType18NodeType:
    if value in NODE_CONTENT_TYPE_18_NODE_TYPE_VALUES:
        return cast("NodeContentType18NodeType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {NODE_CONTENT_TYPE_18_NODE_TYPE_VALUES!r}")
