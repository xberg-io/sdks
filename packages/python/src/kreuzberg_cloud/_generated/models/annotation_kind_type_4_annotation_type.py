from typing import Literal, cast

AnnotationKindType4AnnotationType = Literal["code"]

ANNOTATION_KIND_TYPE_4_ANNOTATION_TYPE_VALUES: set[AnnotationKindType4AnnotationType] = {"code"}


def check_annotation_kind_type_4_annotation_type(value: str) -> AnnotationKindType4AnnotationType:
    if value in ANNOTATION_KIND_TYPE_4_ANNOTATION_TYPE_VALUES:
        return cast("AnnotationKindType4AnnotationType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {ANNOTATION_KIND_TYPE_4_ANNOTATION_TYPE_VALUES!r}")
