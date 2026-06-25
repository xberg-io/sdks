from typing import Literal, cast

AnnotationKindType1AnnotationType = Literal["italic"]

ANNOTATION_KIND_TYPE_1_ANNOTATION_TYPE_VALUES: set[AnnotationKindType1AnnotationType] = {"italic"}


def check_annotation_kind_type_1_annotation_type(value: str) -> AnnotationKindType1AnnotationType:
    if value in ANNOTATION_KIND_TYPE_1_ANNOTATION_TYPE_VALUES:
        return cast("AnnotationKindType1AnnotationType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {ANNOTATION_KIND_TYPE_1_ANNOTATION_TYPE_VALUES!r}")
