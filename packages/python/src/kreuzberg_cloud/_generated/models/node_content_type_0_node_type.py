from typing import Literal, cast

NodeContentType0NodeType = Literal["title"]

NODE_CONTENT_TYPE_0_NODE_TYPE_VALUES: set[NodeContentType0NodeType] = {"title"}


def check_node_content_type_0_node_type(value: str) -> NodeContentType0NodeType:
    if value in NODE_CONTENT_TYPE_0_NODE_TYPE_VALUES:
        return cast("NodeContentType0NodeType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {NODE_CONTENT_TYPE_0_NODE_TYPE_VALUES!r}")
