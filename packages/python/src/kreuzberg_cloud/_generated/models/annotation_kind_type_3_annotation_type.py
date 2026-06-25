from typing import Literal, cast

AnnotationKindType3AnnotationType = Literal["strikethrough"]

ANNOTATION_KIND_TYPE_3_ANNOTATION_TYPE_VALUES: set[AnnotationKindType3AnnotationType] = {"strikethrough"}


def check_annotation_kind_type_3_annotation_type(value: str) -> AnnotationKindType3AnnotationType:
    if value in ANNOTATION_KIND_TYPE_3_ANNOTATION_TYPE_VALUES:
        return cast("AnnotationKindType3AnnotationType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {ANNOTATION_KIND_TYPE_3_ANNOTATION_TYPE_VALUES!r}")
