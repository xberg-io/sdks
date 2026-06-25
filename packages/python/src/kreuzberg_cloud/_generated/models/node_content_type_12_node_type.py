from typing import Literal, cast

NodeContentType12NodeType = Literal["page_break"]

NODE_CONTENT_TYPE_12_NODE_TYPE_VALUES: set[NodeContentType12NodeType] = {"page_break"}


def check_node_content_type_12_node_type(value: str) -> NodeContentType12NodeType:
    if value in NODE_CONTENT_TYPE_12_NODE_TYPE_VALUES:
        return cast("NodeContentType12NodeType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {NODE_CONTENT_TYPE_12_NODE_TYPE_VALUES!r}")
