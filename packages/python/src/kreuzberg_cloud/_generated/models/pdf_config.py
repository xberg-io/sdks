from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.hierarchy_config import HierarchyConfig


T = TypeVar("T", bound="PdfConfig")


@_attrs_define
class PdfConfig:
    """PDF-specific extraction options.

    Attributes:
        bottom_margin_fraction (float | None | Unset): Bottom margin fraction to skip (0.0-1.0)
        extract_annotations (bool | None | Unset): Extract PDF annotations
        extract_images (bool | None | Unset): Extract images from PDF
        extract_metadata (bool | None | Unset): Extract PDF metadata
        hierarchy (HierarchyConfig | None | Unset):
        passwords (list[str] | None | Unset): PDF passwords to try
        top_margin_fraction (float | None | Unset): Top margin fraction to skip (0.0-1.0)
    """

    bottom_margin_fraction: float | None | Unset = UNSET
    extract_annotations: bool | None | Unset = UNSET
    extract_images: bool | None | Unset = UNSET
    extract_metadata: bool | None | Unset = UNSET
    hierarchy: HierarchyConfig | None | Unset = UNSET
    passwords: list[str] | None | Unset = UNSET
    top_margin_fraction: float | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.hierarchy_config import HierarchyConfig

        bottom_margin_fraction: float | None | Unset
        if isinstance(self.bottom_margin_fraction, Unset):
            bottom_margin_fraction = UNSET
        else:
            bottom_margin_fraction = self.bottom_margin_fraction

        extract_annotations: bool | None | Unset
        if isinstance(self.extract_annotations, Unset):
            extract_annotations = UNSET
        else:
            extract_annotations = self.extract_annotations

        extract_images: bool | None | Unset
        if isinstance(self.extract_images, Unset):
            extract_images = UNSET
        else:
            extract_images = self.extract_images

        extract_metadata: bool | None | Unset
        if isinstance(self.extract_metadata, Unset):
            extract_metadata = UNSET
        else:
            extract_metadata = self.extract_metadata

        hierarchy: dict[str, Any] | None | Unset
        if isinstance(self.hierarchy, Unset):
            hierarchy = UNSET
        elif isinstance(self.hierarchy, HierarchyConfig):
            hierarchy = self.hierarchy.to_dict()
        else:
            hierarchy = self.hierarchy

        passwords: list[str] | None | Unset
        if isinstance(self.passwords, Unset):
            passwords = UNSET
        elif isinstance(self.passwords, list):
            passwords = self.passwords

        else:
            passwords = self.passwords

        top_margin_fraction: float | None | Unset
        if isinstance(self.top_margin_fraction, Unset):
            top_margin_fraction = UNSET
        else:
            top_margin_fraction = self.top_margin_fraction

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if bottom_margin_fraction is not UNSET:
            field_dict["bottom_margin_fraction"] = bottom_margin_fraction
        if extract_annotations is not UNSET:
            field_dict["extract_annotations"] = extract_annotations
        if extract_images is not UNSET:
            field_dict["extract_images"] = extract_images
        if extract_metadata is not UNSET:
            field_dict["extract_metadata"] = extract_metadata
        if hierarchy is not UNSET:
            field_dict["hierarchy"] = hierarchy
        if passwords is not UNSET:
            field_dict["passwords"] = passwords
        if top_margin_fraction is not UNSET:
            field_dict["top_margin_fraction"] = top_margin_fraction

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.hierarchy_config import HierarchyConfig

        d = dict(src_dict)

        def _parse_bottom_margin_fraction(data: object) -> float | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("float | None | Unset", data)

        bottom_margin_fraction = _parse_bottom_margin_fraction(d.pop("bottom_margin_fraction", UNSET))

        def _parse_extract_annotations(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        extract_annotations = _parse_extract_annotations(d.pop("extract_annotations", UNSET))

        def _parse_extract_images(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        extract_images = _parse_extract_images(d.pop("extract_images", UNSET))

        def _parse_extract_metadata(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        extract_metadata = _parse_extract_metadata(d.pop("extract_metadata", UNSET))

        def _parse_hierarchy(data: object) -> HierarchyConfig | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                hierarchy_type_1 = HierarchyConfig.from_dict(data)

                return hierarchy_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("HierarchyConfig | None | Unset", data)

        hierarchy = _parse_hierarchy(d.pop("hierarchy", UNSET))

        def _parse_passwords(data: object) -> list[str] | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, list):
                    raise TypeError
                passwords_type_0 = cast("list[str]", data)

                return passwords_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("list[str] | None | Unset", data)

        passwords = _parse_passwords(d.pop("passwords", UNSET))

        def _parse_top_margin_fraction(data: object) -> float | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("float | None | Unset", data)

        top_margin_fraction = _parse_top_margin_fraction(d.pop("top_margin_fraction", UNSET))

        pdf_config = cls(
            bottom_margin_fraction=bottom_margin_fraction,
            extract_annotations=extract_annotations,
            extract_images=extract_images,
            extract_metadata=extract_metadata,
            hierarchy=hierarchy,
            passwords=passwords,
            top_margin_fraction=top_margin_fraction,
        )

        pdf_config.additional_properties = d
        return pdf_config

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
