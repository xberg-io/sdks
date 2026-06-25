from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.bounding_box import BoundingBox
    from ..models.element_metadata_additional import ElementMetadataAdditional


T = TypeVar("T", bound="ElementMetadata")


@_attrs_define
class ElementMetadata:
    """Metadata for a semantic element.

    Attributes:
        additional (ElementMetadataAdditional): Additional custom metadata
        coordinates (BoundingBox | None | Unset):
        element_index (int | None | Unset): Position index in the element sequence
        filename (None | str | Unset): Source filename or document name
        page_number (int | None | Unset): Page number (1-indexed)
    """

    additional: ElementMetadataAdditional
    coordinates: BoundingBox | None | Unset = UNSET
    element_index: int | None | Unset = UNSET
    filename: None | str | Unset = UNSET
    page_number: int | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.bounding_box import BoundingBox

        additional = self.additional.to_dict()

        coordinates: dict[str, Any] | None | Unset
        if isinstance(self.coordinates, Unset):
            coordinates = UNSET
        elif isinstance(self.coordinates, BoundingBox):
            coordinates = self.coordinates.to_dict()
        else:
            coordinates = self.coordinates

        element_index: int | None | Unset
        if isinstance(self.element_index, Unset):
            element_index = UNSET
        else:
            element_index = self.element_index

        filename: None | str | Unset
        if isinstance(self.filename, Unset):
            filename = UNSET
        else:
            filename = self.filename

        page_number: int | None | Unset
        if isinstance(self.page_number, Unset):
            page_number = UNSET
        else:
            page_number = self.page_number

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "additional": additional,
            }
        )
        if coordinates is not UNSET:
            field_dict["coordinates"] = coordinates
        if element_index is not UNSET:
            field_dict["element_index"] = element_index
        if filename is not UNSET:
            field_dict["filename"] = filename
        if page_number is not UNSET:
            field_dict["page_number"] = page_number

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.bounding_box import BoundingBox
        from ..models.element_metadata_additional import ElementMetadataAdditional

        d = dict(src_dict)
        additional = ElementMetadataAdditional.from_dict(d.pop("additional"))

        def _parse_coordinates(data: object) -> BoundingBox | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                coordinates_type_1 = BoundingBox.from_dict(data)

                return coordinates_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("BoundingBox | None | Unset", data)

        coordinates = _parse_coordinates(d.pop("coordinates", UNSET))

        def _parse_element_index(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        element_index = _parse_element_index(d.pop("element_index", UNSET))

        def _parse_filename(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        filename = _parse_filename(d.pop("filename", UNSET))

        def _parse_page_number(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        page_number = _parse_page_number(d.pop("page_number", UNSET))

        element_metadata = cls(
            additional=additional,
            coordinates=coordinates,
            element_index=element_index,
            filename=filename,
            page_number=page_number,
        )

        element_metadata.additional_properties = d
        return element_metadata

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
