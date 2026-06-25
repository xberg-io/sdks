from typing import Literal, cast

ExtractionMethod = Literal["mixed", "native", "ocr"]

EXTRACTION_METHOD_VALUES: set[ExtractionMethod] = {"mixed", "native", "ocr"}


def check_extraction_method(value: str) -> ExtractionMethod:
    if value in EXTRACTION_METHOD_VALUES:
        return cast("ExtractionMethod", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {EXTRACTION_METHOD_VALUES!r}")
