from typing import Literal, cast

AnnotationKindType6AnnotationType = Literal["superscript"]

ANNOTATION_KIND_TYPE_6_ANNOTATION_TYPE_VALUES: set[AnnotationKindType6AnnotationType] = {"superscript"}


def check_annotation_kind_type_6_annotation_type(value: str) -> AnnotationKindType6AnnotationType:
    if value in ANNOTATION_KIND_TYPE_6_ANNOTATION_TYPE_VALUES:
        return cast("AnnotationKindType6AnnotationType", value)
    raise TypeError(f"Unexpected value {value!r}. Expected one of {ANNOTATION_KIND_TYPE_6_ANNOTATION_TYPE_VALUES!r}")
