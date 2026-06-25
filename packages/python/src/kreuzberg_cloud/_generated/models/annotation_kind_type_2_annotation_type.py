from typing import Literal, cast

AnnotationKindType2AnnotationType = Literal["underline"]

ANNOTATION_KIND_TYPE_2_ANNOTATION_TYPE_VALUES: set[AnnotationKindType2AnnotationType] = {"underline"}


def check_annotation_kind_type_2_annotation_type(value: str) -> AnnotationKindType2AnnotationType:
    if value in ANNOTATION_KIND_TYPE_2_ANNOTATION_TYPE_VALUES:
        return cast("AnnotationKindType2AnnotationType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {ANNOTATION_KIND_TYPE_2_ANNOTATION_TYPE_VALUES!r}")
