from typing import Literal, cast

NodeContentType14NodeType = Literal["definition_list"]

NODE_CONTENT_TYPE_14_NODE_TYPE_VALUES: set[NodeContentType14NodeType] = {"definition_list"}


def check_node_content_type_14_node_type(value: str) -> NodeContentType14NodeType:
    if value in NODE_CONTENT_TYPE_14_NODE_TYPE_VALUES:
        return cast("NodeContentType14NodeType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {NODE_CONTENT_TYPE_14_NODE_TYPE_VALUES!r}")
