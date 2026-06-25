from typing import Literal, cast

NodeContentType15NodeType = Literal["definition_item"]

NODE_CONTENT_TYPE_15_NODE_TYPE_VALUES: set[NodeContentType15NodeType] = {"definition_item"}


def check_node_content_type_15_node_type(value: str) -> NodeContentType15NodeType:
    if value in NODE_CONTENT_TYPE_15_NODE_TYPE_VALUES:
        return cast("NodeContentType15NodeType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {NODE_CONTENT_TYPE_15_NODE_TYPE_VALUES!r}")
