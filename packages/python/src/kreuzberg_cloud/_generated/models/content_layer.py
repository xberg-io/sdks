from typing import Literal, cast

ContentLayer = Literal["body", "footer", "footnote", "header"]

CONTENT_LAYER_VALUES: set[ContentLayer] = {"body", "footer", "footnote", "header"}


def check_content_layer(value: str) -> ContentLayer:
    if value in CONTENT_LAYER_VALUES:
        return cast("ContentLayer", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {CONTENT_LAYER_VALUES!r}")
