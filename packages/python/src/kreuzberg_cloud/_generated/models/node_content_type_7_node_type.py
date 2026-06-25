from typing import Literal, cast

NodeContentType7NodeType = Literal["code"]

NODE_CONTENT_TYPE_7_NODE_TYPE_VALUES: set[NodeContentType7NodeType] = {"code"}


def check_node_content_type_7_node_type(value: str) -> NodeContentType7NodeType:
    if value in NODE_CONTENT_TYPE_7_NODE_TYPE_VALUES:
        return cast("NodeContentType7NodeType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {NODE_CONTENT_TYPE_7_NODE_TYPE_VALUES!r}")
