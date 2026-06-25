from typing import Literal, cast

AnnotationKindType10AnnotationType = Literal["font_size"]

ANNOTATION_KIND_TYPE_10_ANNOTATION_TYPE_VALUES: set[AnnotationKindType10AnnotationType] = {"font_size"}


def check_annotation_kind_type_10_annotation_type(value: str) -> AnnotationKindType10AnnotationType:
    if value in ANNOTATION_KIND_TYPE_10_ANNOTATION_TYPE_VALUES:
        return cast("AnnotationKindType10AnnotationType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {ANNOTATION_KIND_TYPE_10_ANNOTATION_TYPE_VALUES!r}")
