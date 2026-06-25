from typing import Literal, cast

NodeContentType1NodeType = Literal["heading"]

NODE_CONTENT_TYPE_1_NODE_TYPE_VALUES: set[NodeContentType1NodeType] = {"heading"}


def check_node_content_type_1_node_type(value: str) -> NodeContentType1NodeType:
    if value in NODE_CONTENT_TYPE_1_NODE_TYPE_VALUES:
        return cast("NodeContentType1NodeType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {NODE_CONTENT_TYPE_1_NODE_TYPE_VALUES!r}")
