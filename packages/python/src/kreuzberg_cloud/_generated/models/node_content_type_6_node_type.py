from typing import Literal, cast

NodeContentType6NodeType = Literal["image"]

NODE_CONTENT_TYPE_6_NODE_TYPE_VALUES: set[NodeContentType6NodeType] = {"image"}


def check_node_content_type_6_node_type(value: str) -> NodeContentType6NodeType:
    if value in NODE_CONTENT_TYPE_6_NODE_TYPE_VALUES:
        return cast("NodeContentType6NodeType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {NODE_CONTENT_TYPE_6_NODE_TYPE_VALUES!r}")
