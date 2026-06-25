from typing import Literal, cast

AnnotationKindType0AnnotationType = Literal["bold"]

ANNOTATION_KIND_TYPE_0_ANNOTATION_TYPE_VALUES: set[AnnotationKindType0AnnotationType] = {"bold"}


def check_annotation_kind_type_0_annotation_type(value: str) -> AnnotationKindType0AnnotationType:
    if value in ANNOTATION_KIND_TYPE_0_ANNOTATION_TYPE_VALUES:
        return cast("AnnotationKindType0AnnotationType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {ANNOTATION_KIND_TYPE_0_ANNOTATION_TYPE_VALUES!r}")
