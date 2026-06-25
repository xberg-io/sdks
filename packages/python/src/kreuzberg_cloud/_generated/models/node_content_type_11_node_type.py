from typing import Literal, cast

NodeContentType11NodeType = Literal["group"]

NODE_CONTENT_TYPE_11_NODE_TYPE_VALUES: set[NodeContentType11NodeType] = {"group"}


def check_node_content_type_11_node_type(value: str) -> NodeContentType11NodeType:
    if value in NODE_CONTENT_TYPE_11_NODE_TYPE_VALUES:
        return cast("NodeContentType11NodeType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {NODE_CONTENT_TYPE_11_NODE_TYPE_VALUES!r}")
