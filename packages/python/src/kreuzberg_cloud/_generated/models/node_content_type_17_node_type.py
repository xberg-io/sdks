from typing import Literal, cast

NodeContentType17NodeType = Literal["admonition"]

NODE_CONTENT_TYPE_17_NODE_TYPE_VALUES: set[NodeContentType17NodeType] = {"admonition"}


def check_node_content_type_17_node_type(value: str) -> NodeContentType17NodeType:
    if value in NODE_CONTENT_TYPE_17_NODE_TYPE_VALUES:
        return cast("NodeContentType17NodeType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {NODE_CONTENT_TYPE_17_NODE_TYPE_VALUES!r}")
