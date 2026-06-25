from typing import Literal, cast

OcrBoundingGeometryType0Type = Literal["rectangle"]

OCR_BOUNDING_GEOMETRY_TYPE_0_TYPE_VALUES: set[OcrBoundingGeometryType0Type] = {"rectangle"}


def check_ocr_bounding_geometry_type_0_type(value: str) -> OcrBoundingGeometryType0Type:
    if value in OCR_BOUNDING_GEOMETRY_TYPE_0_TYPE_VALUES:
        return cast("OcrBoundingGeometryType0Type", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {OCR_BOUNDING_GEOMETRY_TYPE_0_TYPE_VALUES!r}")
