from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

if TYPE_CHECKING:
    from ..models.annotation_kind_type_0 import AnnotationKindType0
    from ..models.annotation_kind_type_1 import AnnotationKindType1
    from ..models.annotation_kind_type_2 import AnnotationKindType2
    from ..models.annotation_kind_type_3 import AnnotationKindType3
    from ..models.annotation_kind_type_4 import AnnotationKindType4
    from ..models.annotation_kind_type_5 import AnnotationKindType5
    from ..models.annotation_kind_type_6 import AnnotationKindType6
    from ..models.annotation_kind_type_7 import AnnotationKindType7
    from ..models.annotation_kind_type_8 import AnnotationKindType8
    from ..models.annotation_kind_type_9 import AnnotationKindType9
    from ..models.annotation_kind_type_10 import AnnotationKindType10
    from ..models.annotation_kind_type_11 import AnnotationKindType11


T = TypeVar("T", bound="TextAnnotation")


@_attrs_define
class TextAnnotation:
    """Inline text annotation — byte-range based formatting and links.

    Annotations reference byte offsets into the node's text content,
    enabling precise identification of formatted regions.

    Attributes:
            end (int): End byte offset in the node's text content (exclusive).
            kind (AnnotationKindType0 | AnnotationKindType1 | AnnotationKindType10 | AnnotationKindType11 |
                AnnotationKindType2 | AnnotationKindType3 | AnnotationKindType4 | AnnotationKindType5 | AnnotationKindType6 |
                AnnotationKindType7 | AnnotationKindType8 | AnnotationKindType9): Types of inline text annotations.
            start (int): Start byte offset in the node's text content (inclusive).
    """

    end: int
    kind: (
        AnnotationKindType0
        | AnnotationKindType1
        | AnnotationKindType10
        | AnnotationKindType11
        | AnnotationKindType2
        | AnnotationKindType3
        | AnnotationKindType4
        | AnnotationKindType5
        | AnnotationKindType6
        | AnnotationKindType7
        | AnnotationKindType8
        | AnnotationKindType9
    )
    start: int
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.annotation_kind_type_0 import AnnotationKindType0
        from ..models.annotation_kind_type_1 import AnnotationKindType1
        from ..models.annotation_kind_type_2 import AnnotationKindType2
        from ..models.annotation_kind_type_3 import AnnotationKindType3
        from ..models.annotation_kind_type_4 import AnnotationKindType4
        from ..models.annotation_kind_type_5 import AnnotationKindType5
        from ..models.annotation_kind_type_6 import AnnotationKindType6
        from ..models.annotation_kind_type_7 import AnnotationKindType7
        from ..models.annotation_kind_type_8 import AnnotationKindType8
        from ..models.annotation_kind_type_9 import AnnotationKindType9
        from ..models.annotation_kind_type_10 import AnnotationKindType10

        end = self.end

        kind: dict[str, Any]
        if (
            isinstance(self.kind, AnnotationKindType0)
            or isinstance(self.kind, AnnotationKindType1)
            or isinstance(self.kind, AnnotationKindType2)
            or isinstance(self.kind, AnnotationKindType3)
            or isinstance(self.kind, AnnotationKindType4)
            or isinstance(self.kind, AnnotationKindType5)
            or isinstance(self.kind, AnnotationKindType6)
            or isinstance(self.kind, AnnotationKindType7)
            or isinstance(self.kind, AnnotationKindType8)
            or isinstance(self.kind, AnnotationKindType9)
            or isinstance(self.kind, AnnotationKindType10)
        ):
            kind = self.kind.to_dict()
        else:
            kind = self.kind.to_dict()

        start = self.start

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "end": end,
                "kind": kind,
                "start": start,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.annotation_kind_type_0 import AnnotationKindType0
        from ..models.annotation_kind_type_1 import AnnotationKindType1
        from ..models.annotation_kind_type_2 import AnnotationKindType2
        from ..models.annotation_kind_type_3 import AnnotationKindType3
        from ..models.annotation_kind_type_4 import AnnotationKindType4
        from ..models.annotation_kind_type_5 import AnnotationKindType5
        from ..models.annotation_kind_type_6 import AnnotationKindType6
        from ..models.annotation_kind_type_7 import AnnotationKindType7
        from ..models.annotation_kind_type_8 import AnnotationKindType8
        from ..models.annotation_kind_type_9 import AnnotationKindType9
        from ..models.annotation_kind_type_10 import AnnotationKindType10
        from ..models.annotation_kind_type_11 import AnnotationKindType11

        d = dict(src_dict)
        end = d.pop("end")

        def _parse_kind(
            data: object,
        ) -> (
            AnnotationKindType0
            | AnnotationKindType1
            | AnnotationKindType10
            | AnnotationKindType11
            | AnnotationKindType2
            | AnnotationKindType3
            | AnnotationKindType4
            | AnnotationKindType5
            | AnnotationKindType6
            | AnnotationKindType7
            | AnnotationKindType8
            | AnnotationKindType9
        ):
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_annotation_kind_type_0 = AnnotationKindType0.from_dict(data)

                return componentsschemas_annotation_kind_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_annotation_kind_type_1 = AnnotationKindType1.from_dict(data)

                return componentsschemas_annotation_kind_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_annotation_kind_type_2 = AnnotationKindType2.from_dict(data)

                return componentsschemas_annotation_kind_type_2
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_annotation_kind_type_3 = AnnotationKindType3.from_dict(data)

                return componentsschemas_annotation_kind_type_3
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_annotation_kind_type_4 = AnnotationKindType4.from_dict(data)

                return componentsschemas_annotation_kind_type_4
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_annotation_kind_type_5 = AnnotationKindType5.from_dict(data)

                return componentsschemas_annotation_kind_type_5
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_annotation_kind_type_6 = AnnotationKindType6.from_dict(data)

                return componentsschemas_annotation_kind_type_6
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_annotation_kind_type_7 = AnnotationKindType7.from_dict(data)

                return componentsschemas_annotation_kind_type_7
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_annotation_kind_type_8 = AnnotationKindType8.from_dict(data)

                return componentsschemas_annotation_kind_type_8
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_annotation_kind_type_9 = AnnotationKindType9.from_dict(data)

                return componentsschemas_annotation_kind_type_9
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_annotation_kind_type_10 = AnnotationKindType10.from_dict(data)

                return componentsschemas_annotation_kind_type_10
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            if not isinstance(data, dict):
                raise TypeError
            componentsschemas_annotation_kind_type_11 = AnnotationKindType11.from_dict(data)

            return componentsschemas_annotation_kind_type_11

        kind = _parse_kind(d.pop("kind"))

        start = d.pop("start")

        text_annotation = cls(
            end=end,
            kind=kind,
            start=start,
        )

        text_annotation.additional_properties = d
        return text_annotation

    @property
    def additional_keys(self) -> list[str]:
        return list(self.additional_properties.keys())

    def __getitem__(self, key: str) -> Any:
        return self.additional_properties[key]

    def __setitem__(self, key: str, value: Any) -> None:
        self.additional_properties[key] = value

    def __delitem__(self, key: str) -> None:
        del self.additional_properties[key]

    def __contains__(self, key: str) -> bool:
        return key in self.additional_properties
