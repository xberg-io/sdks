from typing import Literal, cast

NodeContentType8NodeType = Literal["quote"]

NODE_CONTENT_TYPE_8_NODE_TYPE_VALUES: set[NodeContentType8NodeType] = {"quote"}


def check_node_content_type_8_node_type(value: str) -> NodeContentType8NodeType:
    if value in NODE_CONTENT_TYPE_8_NODE_TYPE_VALUES:
        return cast("NodeContentType8NodeType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {NODE_CONTENT_TYPE_8_NODE_TYPE_VALUES!r}")
