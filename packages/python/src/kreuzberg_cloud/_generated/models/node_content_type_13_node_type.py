from typing import Literal, cast

NodeContentType13NodeType = Literal["slide"]

NODE_CONTENT_TYPE_13_NODE_TYPE_VALUES: set[NodeContentType13NodeType] = {"slide"}


def check_node_content_type_13_node_type(value: str) -> NodeContentType13NodeType:
    if value in NODE_CONTENT_TYPE_13_NODE_TYPE_VALUES:
        return cast("NodeContentType13NodeType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {NODE_CONTENT_TYPE_13_NODE_TYPE_VALUES!r}")
