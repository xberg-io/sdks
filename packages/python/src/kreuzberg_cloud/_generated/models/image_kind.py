from typing import Literal, cast

ImageKind = Literal[
    "chart",
    "decoration",
    "diagram",
    "drawing",
    "icon",
    "logo",
    "mask",
    "page_raster",
    "photograph",
    "text_block",
    "tile_fragment",
    "unknown",
]

IMAGE_KIND_VALUES: set[ImageKind] = {
    "chart",
    "decoration",
    "diagram",
    "drawing",
    "icon",
    "logo",
    "mask",
    "page_raster",
    "photograph",
    "text_block",
    "tile_fragment",
    "unknown",
}


def check_image_kind(value: str) -> ImageKind:
    if value in IMAGE_KIND_VALUES:
        return cast("ImageKind", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {IMAGE_KIND_VALUES!r}")
