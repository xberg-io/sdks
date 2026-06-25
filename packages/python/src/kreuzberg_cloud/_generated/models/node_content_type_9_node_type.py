from typing import Literal, cast

NodeContentType9NodeType = Literal["formula"]

NODE_CONTENT_TYPE_9_NODE_TYPE_VALUES: set[NodeContentType9NodeType] = {"formula"}


def check_node_content_type_9_node_type(value: str) -> NodeContentType9NodeType:
    if value in NODE_CONTENT_TYPE_9_NODE_TYPE_VALUES:
        return cast("NodeContentType9NodeType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {NODE_CONTENT_TYPE_9_NODE_TYPE_VALUES!r}")
