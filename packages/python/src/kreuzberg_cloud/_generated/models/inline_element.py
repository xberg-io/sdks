from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.inline_type import InlineType, check_inline_type
from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.attributes import Attributes
    from ..models.inline_element_metadata_type_0 import InlineElementMetadataType0


T = TypeVar("T", bound="InlineElement")


@_attrs_define
class InlineElement:
    """Inline element within a block.

    Represents text with formatting, links, images, etc.

    Attributes:
            content (str): Text content
            element_type (InlineType): Types of inline elements in Djot.
            attributes (Attributes | None | Unset):
            metadata (InlineElementMetadataType0 | None | Unset): Additional metadata (e.g., href for links, src/alt for
                images)
    """

    content: str
    element_type: InlineType
    attributes: Attributes | None | Unset = UNSET
    metadata: InlineElementMetadataType0 | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.attributes import Attributes
        from ..models.inline_element_metadata_type_0 import InlineElementMetadataType0

        content = self.content

        element_type: str = self.element_type

        attributes: dict[str, Any] | None | Unset
        if isinstance(self.attributes, Unset):
            attributes = UNSET
        elif isinstance(self.attributes, Attributes):
            attributes = self.attributes.to_dict()
        else:
            attributes = self.attributes

        metadata: dict[str, Any] | None | Unset
        if isinstance(self.metadata, Unset):
            metadata = UNSET
        elif isinstance(self.metadata, InlineElementMetadataType0):
            metadata = self.metadata.to_dict()
        else:
            metadata = self.metadata

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "content": content,
                "element_type": element_type,
            }
        )
        if attributes is not UNSET:
            field_dict["attributes"] = attributes
        if metadata is not UNSET:
            field_dict["metadata"] = metadata

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.attributes import Attributes
        from ..models.inline_element_metadata_type_0 import InlineElementMetadataType0

        d = dict(src_dict)
        content = d.pop("content")

        element_type = check_inline_type(d.pop("element_type"))

        def _parse_attributes(data: object) -> Attributes | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                attributes_type_1 = Attributes.from_dict(data)

                return attributes_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("Attributes | None | Unset", data)

        attributes = _parse_attributes(d.pop("attributes", UNSET))

        def _parse_metadata(data: object) -> InlineElementMetadataType0 | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                metadata_type_0 = InlineElementMetadataType0.from_dict(data)

                return metadata_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("InlineElementMetadataType0 | None | Unset", data)

        metadata = _parse_metadata(d.pop("metadata", UNSET))

        inline_element = cls(
            content=content,
            element_type=element_type,
            attributes=attributes,
            metadata=metadata,
        )

        inline_element.additional_properties = d
        return inline_element

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
