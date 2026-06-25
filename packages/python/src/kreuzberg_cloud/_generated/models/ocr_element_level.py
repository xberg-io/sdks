from typing import Literal, cast

OcrElementLevel = Literal["block", "line", "page", "word"]

OCR_ELEMENT_LEVEL_VALUES: set[OcrElementLevel] = {"block", "line", "page", "word"}


def check_ocr_element_level(value: str) -> OcrElementLevel:
    if value in OCR_ELEMENT_LEVEL_VALUES:
        return cast("OcrElementLevel", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {OCR_ELEMENT_LEVEL_VALUES!r}")
