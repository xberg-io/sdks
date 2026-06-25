from typing import Literal, cast

NodeContentType16NodeType = Literal["citation"]

NODE_CONTENT_TYPE_16_NODE_TYPE_VALUES: set[NodeContentType16NodeType] = {"citation"}


def check_node_content_type_16_node_type(value: str) -> NodeContentType16NodeType:
    if value in NODE_CONTENT_TYPE_16_NODE_TYPE_VALUES:
        return cast("NodeContentType16NodeType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {NODE_CONTENT_TYPE_16_NODE_TYPE_VALUES!r}")
