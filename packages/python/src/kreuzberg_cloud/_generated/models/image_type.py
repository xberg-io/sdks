from typing import Literal, cast

ImageType = Literal["data-uri", "external", "inline-svg", "relative"]

IMAGE_TYPE_VALUES: set[ImageType] = {"data-uri", "external", "inline-svg", "relative"}


def check_image_type(value: str) -> ImageType:
    if value in IMAGE_TYPE_VALUES:
        return cast("ImageType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {IMAGE_TYPE_VALUES!r}")
