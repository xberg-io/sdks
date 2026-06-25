from typing import Literal, cast

AnnotationKindType7AnnotationType = Literal["link"]

ANNOTATION_KIND_TYPE_7_ANNOTATION_TYPE_VALUES: set[AnnotationKindType7AnnotationType] = {"link"}


def check_annotation_kind_type_7_annotation_type(value: str) -> AnnotationKindType7AnnotationType:
    if value in ANNOTATION_KIND_TYPE_7_ANNOTATION_TYPE_VALUES:
        return cast("AnnotationKindType7AnnotationType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {ANNOTATION_KIND_TYPE_7_ANNOTATION_TYPE_VALUES!r}")
