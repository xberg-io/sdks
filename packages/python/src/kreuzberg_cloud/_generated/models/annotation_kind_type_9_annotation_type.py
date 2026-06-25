from typing import Literal, cast

AnnotationKindType9AnnotationType = Literal["color"]

ANNOTATION_KIND_TYPE_9_ANNOTATION_TYPE_VALUES: set[AnnotationKindType9AnnotationType] = {"color"}


def check_annotation_kind_type_9_annotation_type(value: str) -> AnnotationKindType9AnnotationType:
    if value in ANNOTATION_KIND_TYPE_9_ANNOTATION_TYPE_VALUES:
        return cast("AnnotationKindType9AnnotationType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {ANNOTATION_KIND_TYPE_9_ANNOTATION_TYPE_VALUES!r}")
