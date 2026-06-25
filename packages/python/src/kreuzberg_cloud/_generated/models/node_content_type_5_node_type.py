from typing import Literal, cast

NodeContentType5NodeType = Literal["table"]

NODE_CONTENT_TYPE_5_NODE_TYPE_VALUES: set[NodeContentType5NodeType] = {"table"}


def check_node_content_type_5_node_type(value: str) -> NodeContentType5NodeType:
    if value in NODE_CONTENT_TYPE_5_NODE_TYPE_VALUES:
        return cast("NodeContentType5NodeType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {NODE_CONTENT_TYPE_5_NODE_TYPE_VALUES!r}")
