from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.pdf_annotation_type import PdfAnnotationType, check_pdf_annotation_type
from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.bounding_box import BoundingBox


T = TypeVar("T", bound="PdfAnnotation")


@_attrs_define
class PdfAnnotation:
    """A PDF annotation extracted from a document page.

    Attributes:
        annotation_type (PdfAnnotationType): Type of PDF annotation.
        page_number (int): Page number where the annotation appears (1-indexed).
        bounding_box (BoundingBox | None | Unset):
        content (None | str | Unset): Text content of the annotation (e.g., comment text, link URL).
    """

    annotation_type: PdfAnnotationType
    page_number: int
    bounding_box: BoundingBox | None | Unset = UNSET
    content: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.bounding_box import BoundingBox

        annotation_type: str = self.annotation_type

        page_number = self.page_number

        bounding_box: dict[str, Any] | None | Unset
        if isinstance(self.bounding_box, Unset):
            bounding_box = UNSET
        elif isinstance(self.bounding_box, BoundingBox):
            bounding_box = self.bounding_box.to_dict()
        else:
            bounding_box = self.bounding_box

        content: None | str | Unset
        if isinstance(self.content, Unset):
            content = UNSET
        else:
            content = self.content

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "annotation_type": annotation_type,
                "page_number": page_number,
            }
        )
        if bounding_box is not UNSET:
            field_dict["bounding_box"] = bounding_box
        if content is not UNSET:
            field_dict["content"] = content

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.bounding_box import BoundingBox

        d = dict(src_dict)
        annotation_type = check_pdf_annotation_type(d.pop("annotation_type"))

        page_number = d.pop("page_number")

        def _parse_bounding_box(data: object) -> BoundingBox | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                bounding_box_type_1 = BoundingBox.from_dict(data)

                return bounding_box_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("BoundingBox | None | Unset", data)

        bounding_box = _parse_bounding_box(d.pop("bounding_box", UNSET))

        def _parse_content(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        content = _parse_content(d.pop("content", UNSET))

        pdf_annotation = cls(
            annotation_type=annotation_type,
            page_number=page_number,
            bounding_box=bounding_box,
            content=content,
        )

        pdf_annotation.additional_properties = d
        return pdf_annotation

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
