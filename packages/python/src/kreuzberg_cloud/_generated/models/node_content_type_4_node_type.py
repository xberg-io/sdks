from typing import Literal, cast

NodeContentType4NodeType = Literal["list_item"]

NODE_CONTENT_TYPE_4_NODE_TYPE_VALUES: set[NodeContentType4NodeType] = {"list_item"}


def check_node_content_type_4_node_type(value: str) -> NodeContentType4NodeType:
    if value in NODE_CONTENT_TYPE_4_NODE_TYPE_VALUES:
        return cast("NodeContentType4NodeType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {NODE_CONTENT_TYPE_4_NODE_TYPE_VALUES!r}")
