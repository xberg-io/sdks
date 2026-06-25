from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="ImageExtractionConfig")


@_attrs_define
class ImageExtractionConfig:
    """Image extraction and processing configuration.

    Attributes:
        auto_adjust_dpi (bool | None | Unset): Auto-adjust DPI based on content
        extract_images (bool | None | Unset): Extract images from documents
        inject_placeholders (bool | None | Unset): Inject image reference placeholders in markdown output
        max_dpi (int | None | Unset): Maximum DPI threshold
        max_image_dimension (int | None | Unset): Maximum image dimension (width or height)
        min_dpi (int | None | Unset): Minimum DPI threshold
        target_dpi (int | None | Unset): Target DPI for image normalization
    """

    auto_adjust_dpi: bool | None | Unset = UNSET
    extract_images: bool | None | Unset = UNSET
    inject_placeholders: bool | None | Unset = UNSET
    max_dpi: int | None | Unset = UNSET
    max_image_dimension: int | None | Unset = UNSET
    min_dpi: int | None | Unset = UNSET
    target_dpi: int | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        auto_adjust_dpi: bool | None | Unset
        if isinstance(self.auto_adjust_dpi, Unset):
            auto_adjust_dpi = UNSET
        else:
            auto_adjust_dpi = self.auto_adjust_dpi

        extract_images: bool | None | Unset
        if isinstance(self.extract_images, Unset):
            extract_images = UNSET
        else:
            extract_images = self.extract_images

        inject_placeholders: bool | None | Unset
        if isinstance(self.inject_placeholders, Unset):
            inject_placeholders = UNSET
        else:
            inject_placeholders = self.inject_placeholders

        max_dpi: int | None | Unset
        if isinstance(self.max_dpi, Unset):
            max_dpi = UNSET
        else:
            max_dpi = self.max_dpi

        max_image_dimension: int | None | Unset
        if isinstance(self.max_image_dimension, Unset):
            max_image_dimension = UNSET
        else:
            max_image_dimension = self.max_image_dimension

        min_dpi: int | None | Unset
        if isinstance(self.min_dpi, Unset):
            min_dpi = UNSET
        else:
            min_dpi = self.min_dpi

        target_dpi: int | None | Unset
        if isinstance(self.target_dpi, Unset):
            target_dpi = UNSET
        else:
            target_dpi = self.target_dpi

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if auto_adjust_dpi is not UNSET:
            field_dict["auto_adjust_dpi"] = auto_adjust_dpi
        if extract_images is not UNSET:
            field_dict["extract_images"] = extract_images
        if inject_placeholders is not UNSET:
            field_dict["inject_placeholders"] = inject_placeholders
        if max_dpi is not UNSET:
            field_dict["max_dpi"] = max_dpi
        if max_image_dimension is not UNSET:
            field_dict["max_image_dimension"] = max_image_dimension
        if min_dpi is not UNSET:
            field_dict["min_dpi"] = min_dpi
        if target_dpi is not UNSET:
            field_dict["target_dpi"] = target_dpi

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)

        def _parse_auto_adjust_dpi(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        auto_adjust_dpi = _parse_auto_adjust_dpi(d.pop("auto_adjust_dpi", UNSET))

        def _parse_extract_images(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        extract_images = _parse_extract_images(d.pop("extract_images", UNSET))

        def _parse_inject_placeholders(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        inject_placeholders = _parse_inject_placeholders(d.pop("inject_placeholders", UNSET))

        def _parse_max_dpi(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        max_dpi = _parse_max_dpi(d.pop("max_dpi", UNSET))

        def _parse_max_image_dimension(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        max_image_dimension = _parse_max_image_dimension(d.pop("max_image_dimension", UNSET))

        def _parse_min_dpi(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        min_dpi = _parse_min_dpi(d.pop("min_dpi", UNSET))

        def _parse_target_dpi(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        target_dpi = _parse_target_dpi(d.pop("target_dpi", UNSET))

        image_extraction_config = cls(
            auto_adjust_dpi=auto_adjust_dpi,
            extract_images=extract_images,
            inject_placeholders=inject_placeholders,
            max_dpi=max_dpi,
            max_image_dimension=max_image_dimension,
            min_dpi=min_dpi,
            target_dpi=target_dpi,
        )

        image_extraction_config.additional_properties = d
        return image_extraction_config

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
