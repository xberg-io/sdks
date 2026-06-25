from typing import Literal, cast

AnnotationKindType11AnnotationType = Literal["custom"]

ANNOTATION_KIND_TYPE_11_ANNOTATION_TYPE_VALUES: set[AnnotationKindType11AnnotationType] = {"custom"}


def check_annotation_kind_type_11_annotation_type(value: str) -> AnnotationKindType11AnnotationType:
    if value in ANNOTATION_KIND_TYPE_11_ANNOTATION_TYPE_VALUES:
        return cast("AnnotationKindType11AnnotationType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {ANNOTATION_KIND_TYPE_11_ANNOTATION_TYPE_VALUES!r}")
