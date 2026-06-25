from typing import Literal, cast

NodeContentType10NodeType = Literal["footnote"]

NODE_CONTENT_TYPE_10_NODE_TYPE_VALUES: set[NodeContentType10NodeType] = {"footnote"}


def check_node_content_type_10_node_type(value: str) -> NodeContentType10NodeType:
    if value in NODE_CONTENT_TYPE_10_NODE_TYPE_VALUES:
        return cast("NodeContentType10NodeType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {NODE_CONTENT_TYPE_10_NODE_TYPE_VALUES!r}")
