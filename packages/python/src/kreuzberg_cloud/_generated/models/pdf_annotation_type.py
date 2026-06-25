from typing import Literal, cast

PdfAnnotationType = Literal["highlight", "link", "other", "stamp", "strike_out", "text", "underline"]

PDF_ANNOTATION_TYPE_VALUES: set[PdfAnnotationType] = {
    "highlight",
    "link",
    "other",
    "stamp",
    "strike_out",
    "text",
    "underline",
}


def check_pdf_annotation_type(value: str) -> PdfAnnotationType:
    if value in PDF_ANNOTATION_TYPE_VALUES:
        return cast("PdfAnnotationType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {PDF_ANNOTATION_TYPE_VALUES!r}")
