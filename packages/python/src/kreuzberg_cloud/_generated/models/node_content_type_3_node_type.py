from typing import Literal, cast

NodeContentType3NodeType = Literal["list"]

NODE_CONTENT_TYPE_3_NODE_TYPE_VALUES: set[NodeContentType3NodeType] = {"list"}


def check_node_content_type_3_node_type(value: str) -> NodeContentType3NodeType:
    if value in NODE_CONTENT_TYPE_3_NODE_TYPE_VALUES:
        return cast("NodeContentType3NodeType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {NODE_CONTENT_TYPE_3_NODE_TYPE_VALUES!r}")
