from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.image_type import ImageType, check_image_type
from ..types import UNSET, Unset

T = TypeVar("T", bound="ImageMetadataType")


@_attrs_define
class ImageMetadataType:
    """Image element metadata.

    Attributes:
        attributes (list[list[str]]): Additional attributes as key-value pairs
        image_type (ImageType): Image type classification.
        src (str): Image source (URL, data URI, or SVG content)
        alt (None | str | Unset): Alternative text from alt attribute
        dimensions (list[int] | None | Unset): Image dimensions as (width, height) if available
        title (None | str | Unset): Title attribute
    """

    attributes: list[list[str]]
    image_type: ImageType
    src: str
    alt: None | str | Unset = UNSET
    dimensions: list[int] | None | Unset = UNSET
    title: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        attributes = []
        for attributes_item_data in self.attributes:
            attributes_item = attributes_item_data

            attributes.append(attributes_item)

        image_type: str = self.image_type

        src = self.src

        alt: None | str | Unset
        if isinstance(self.alt, Unset):
            alt = UNSET
        else:
            alt = self.alt

        dimensions: list[int] | None | Unset
        if isinstance(self.dimensions, Unset):
            dimensions = UNSET
        elif isinstance(self.dimensions, list):
            dimensions = self.dimensions

        else:
            dimensions = self.dimensions

        title: None | str | Unset
        if isinstance(self.title, Unset):
            title = UNSET
        else:
            title = self.title

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "attributes": attributes,
                "image_type": image_type,
                "src": src,
            }
        )
        if alt is not UNSET:
            field_dict["alt"] = alt
        if dimensions is not UNSET:
            field_dict["dimensions"] = dimensions
        if title is not UNSET:
            field_dict["title"] = title

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        attributes = []
        _attributes = d.pop("attributes")
        for attributes_item_data in _attributes:
            attributes_item = cast("list[str]", attributes_item_data)

            attributes.append(attributes_item)

        image_type = check_image_type(d.pop("image_type"))

        src = d.pop("src")

        def _parse_alt(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        alt = _parse_alt(d.pop("alt", UNSET))

        def _parse_dimensions(data: object) -> list[int] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                dimensions_type_0 = cast("list[int]", data)

                return dimensions_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[int] | None | Unset", data)

        dimensions = _parse_dimensions(d.pop("dimensions", UNSET))

        def _parse_title(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        title = _parse_title(d.pop("title", UNSET))

        image_metadata_type = cls(
            attributes=attributes,
            image_type=image_type,
            src=src,
            alt=alt,
            dimensions=dimensions,
            title=title,
        )

        image_metadata_type.additional_properties = d
        return image_metadata_type

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
