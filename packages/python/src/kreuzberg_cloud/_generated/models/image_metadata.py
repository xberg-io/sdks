from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

if TYPE_CHECKING:
    from ..models.image_metadata_exif import ImageMetadataExif


T = TypeVar("T", bound="ImageMetadata")


@_attrs_define
class ImageMetadata:
    """Image metadata extracted from image files.

    Includes dimensions, format, and EXIF data.

    Attributes:
            exif (ImageMetadataExif): EXIF metadata tags
            format_ (str): Image format (e.g., "PNG", "JPEG", "TIFF")
            height (int): Image height in pixels
            width (int): Image width in pixels
    """

    exif: ImageMetadataExif
    format_: str
    height: int
    width: int
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        exif = self.exif.to_dict()

        format_ = self.format_

        height = self.height

        width = self.width

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "exif": exif,
                "format": format_,
                "height": height,
                "width": width,
            }
        )

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.image_metadata_exif import ImageMetadataExif

        d = dict(src_dict)
        exif = ImageMetadataExif.from_dict(d.pop("exif"))

        format_ = d.pop("format")

        height = d.pop("height")

        width = d.pop("width")

        image_metadata = cls(
            exif=exif,
            format_=format_,
            height=height,
            width=width,
        )

        image_metadata.additional_properties = d
        return image_metadata

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
