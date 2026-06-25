from typing import Literal, cast

AnnotationKindType5AnnotationType = Literal["subscript"]

ANNOTATION_KIND_TYPE_5_ANNOTATION_TYPE_VALUES: set[AnnotationKindType5AnnotationType] = {"subscript"}


def check_annotation_kind_type_5_annotation_type(value: str) -> AnnotationKindType5AnnotationType:
    if value in ANNOTATION_KIND_TYPE_5_ANNOTATION_TYPE_VALUES:
        return cast("AnnotationKindType5AnnotationType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {ANNOTATION_KIND_TYPE_5_ANNOTATION_TYPE_VALUES!r}")
