from typing import Literal, cast

AnnotationKindType8AnnotationType = Literal["highlight"]

ANNOTATION_KIND_TYPE_8_ANNOTATION_TYPE_VALUES: set[AnnotationKindType8AnnotationType] = {"highlight"}


def check_annotation_kind_type_8_annotation_type(value: str) -> AnnotationKindType8AnnotationType:
    if value in ANNOTATION_KIND_TYPE_8_ANNOTATION_TYPE_VALUES:
        return cast("AnnotationKindType8AnnotationType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {ANNOTATION_KIND_TYPE_8_ANNOTATION_TYPE_VALUES!r}")
