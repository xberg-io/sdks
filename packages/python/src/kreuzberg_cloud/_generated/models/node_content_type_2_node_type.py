from typing import Literal, cast

NodeContentType2NodeType = Literal["paragraph"]

NODE_CONTENT_TYPE_2_NODE_TYPE_VALUES: set[NodeContentType2NodeType] = {"paragraph"}


def check_node_content_type_2_node_type(value: str) -> NodeContentType2NodeType:
    if value in NODE_CONTENT_TYPE_2_NODE_TYPE_VALUES:
        return cast("NodeContentType2NodeType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {NODE_CONTENT_TYPE_2_NODE_TYPE_VALUES!r}")
