from typing import Literal, cast

OcrBoundingGeometryType1Type = Literal["quadrilateral"]

OCR_BOUNDING_GEOMETRY_TYPE_1_TYPE_VALUES: set[OcrBoundingGeometryType1Type] = {"quadrilateral"}


def check_ocr_bounding_geometry_type_1_type(value: str) -> OcrBoundingGeometryType1Type:
    if value in OCR_BOUNDING_GEOMETRY_TYPE_1_TYPE_VALUES:
        return cast("OcrBoundingGeometryType1Type", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {OCR_BOUNDING_GEOMETRY_TYPE_1_TYPE_VALUES!r}")
