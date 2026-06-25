from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.element_type import ElementType, check_element_type

if TYPE_CHECKING:
    from ..models.element_metadata import ElementMetadata


T = TypeVar("T", bound="Element")


@_attrs_define
class Element:
    """Semantic element extracted from document.

    Represents a logical unit of content with semantic classification,
    unique identifier, and metadata for tracking origin and position.

    Attributes:
            element_id (str): Unique identifier for semantic elements.

                Wraps a string identifier that is deterministically generated
                from element type, content, and page number.
            element_type (ElementType): Semantic element type classification.

                Categorizes text content into semantic units for downstream processing.
                Supports the element types commonly found in Unstructured documents.
            metadata (ElementMetadata): Metadata for a semantic element.
            text (str): Text content of the element
    """

    element_id: str
    element_type: ElementType
    metadata: ElementMetadata
    text: str
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        element_id = self.element_id

        element_type: str = self.element_type

        metadata = self.metadata.to_dict()

        text = self.text

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "element_id": element_id,
                "element_type": element_type,
                "metadata": metadata,
                "text": text,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.element_metadata import ElementMetadata

        d = dict(src_dict)
        element_id = d.pop("element_id")

        element_type = check_element_type(d.pop("element_type"))

        metadata = ElementMetadata.from_dict(d.pop("metadata"))

        text = d.pop("text")

        element = cls(
            element_id=element_id,
            element_type=element_type,
            metadata=metadata,
            text=text,
        )

        element.additional_properties = d
        return element

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
