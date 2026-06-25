from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="ImagePreprocessingMetadata")


@_attrs_define
class ImagePreprocessingMetadata:
    """Image preprocessing metadata.

    Tracks the transformations applied to an image during OCR preprocessing,
    including DPI normalization, resizing, and resampling.

    Attributes:
            auto_adjusted (bool): Whether DPI was auto-adjusted based on content
            dimension_clamped (bool): Whether dimensions were clamped to max_image_dimension
            final_dpi (int): Final DPI after processing
            original_dimensions (list[int]): Original image dimensions (width, height) in pixels
            original_dpi (list[float]): Original image DPI (horizontal, vertical)
            resample_method (str): Resampling algorithm used ("LANCZOS3", "CATMULLROM", etc.)
            scale_factor (float): Scaling factor applied to the image
            skipped_resize (bool): Whether resize was skipped (dimensions already optimal)
            target_dpi (int): Target DPI from configuration
            calculated_dpi (int | None | Unset): Calculated optimal DPI (if auto_adjust_dpi enabled)
            new_dimensions (list[int] | None | Unset): New dimensions after resizing (if resized)
            resize_error (None | str | Unset): Error message if resize failed
    """

    auto_adjusted: bool
    dimension_clamped: bool
    final_dpi: int
    original_dimensions: list[int]
    original_dpi: list[float]
    resample_method: str
    scale_factor: float
    skipped_resize: bool
    target_dpi: int
    calculated_dpi: int | None | Unset = UNSET
    new_dimensions: list[int] | None | Unset = UNSET
    resize_error: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        auto_adjusted = self.auto_adjusted

        dimension_clamped = self.dimension_clamped

        final_dpi = self.final_dpi

        original_dimensions = self.original_dimensions

        original_dpi = self.original_dpi

        resample_method = self.resample_method

        scale_factor = self.scale_factor

        skipped_resize = self.skipped_resize

        target_dpi = self.target_dpi

        calculated_dpi: int | None | Unset
        if isinstance(self.calculated_dpi, Unset):
            calculated_dpi = UNSET
        else:
            calculated_dpi = self.calculated_dpi

        new_dimensions: list[int] | None | Unset
        if isinstance(self.new_dimensions, Unset):
            new_dimensions = UNSET
        elif isinstance(self.new_dimensions, list):
            new_dimensions = self.new_dimensions

        else:
            new_dimensions = self.new_dimensions

        resize_error: None | str | Unset
        if isinstance(self.resize_error, Unset):
            resize_error = UNSET
        else:
            resize_error = self.resize_error

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "auto_adjusted": auto_adjusted,
                "dimension_clamped": dimension_clamped,
                "final_dpi": final_dpi,
                "original_dimensions": original_dimensions,
                "original_dpi": original_dpi,
                "resample_method": resample_method,
                "scale_factor": scale_factor,
                "skipped_resize": skipped_resize,
                "target_dpi": target_dpi,
            }
        )
        if calculated_dpi is not UNSET:
            field_dict["calculated_dpi"] = calculated_dpi
        if new_dimensions is not UNSET:
            field_dict["new_dimensions"] = new_dimensions
        if resize_error is not UNSET:
            field_dict["resize_error"] = resize_error

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        auto_adjusted = d.pop("auto_adjusted")

        dimension_clamped = d.pop("dimension_clamped")

        final_dpi = d.pop("final_dpi")

        original_dimensions = cast("list[int]", d.pop("original_dimensions"))

        original_dpi = cast("list[float]", d.pop("original_dpi"))

        resample_method = d.pop("resample_method")

        scale_factor = d.pop("scale_factor")

        skipped_resize = d.pop("skipped_resize")

        target_dpi = d.pop("target_dpi")

        def _parse_calculated_dpi(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        calculated_dpi = _parse_calculated_dpi(d.pop("calculated_dpi", UNSET))

        def _parse_new_dimensions(data: object) -> list[int] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                new_dimensions_type_0 = cast("list[int]", data)

                return new_dimensions_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[int] | None | Unset", data)

        new_dimensions = _parse_new_dimensions(d.pop("new_dimensions", UNSET))

        def _parse_resize_error(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        resize_error = _parse_resize_error(d.pop("resize_error", UNSET))

        image_preprocessing_metadata = cls(
            auto_adjusted=auto_adjusted,
            dimension_clamped=dimension_clamped,
            final_dpi=final_dpi,
            original_dimensions=original_dimensions,
            original_dpi=original_dpi,
            resample_method=resample_method,
            scale_factor=scale_factor,
            skipped_resize=skipped_resize,
            target_dpi=target_dpi,
            calculated_dpi=calculated_dpi,
            new_dimensions=new_dimensions,
            resize_error=resize_error,
        )

        image_preprocessing_metadata.additional_properties = d
        return image_preprocessing_metadata

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
