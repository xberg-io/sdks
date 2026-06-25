from typing import Literal, cast

NodeContentType19NodeType = Literal["metadata_block"]

NODE_CONTENT_TYPE_19_NODE_TYPE_VALUES: set[NodeContentType19NodeType] = {"metadata_block"}


def check_node_content_type_19_node_type(value: str) -> NodeContentType19NodeType:
    if value in NODE_CONTENT_TYPE_19_NODE_TYPE_VALUES:
        return cast("NodeContentType19NodeType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {NODE_CONTENT_TYPE_19_NODE_TYPE_VALUES!r}")
