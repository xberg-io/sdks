from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="HierarchyConfig")


@_attrs_define
class HierarchyConfig:
    """Heading hierarchy detection configuration.

    Attributes:
        enabled (bool | Unset): Enable hierarchy detection
        include_bbox (bool | Unset): Include bounding boxes
        k_clusters (int | None | Unset): Number of font-size clusters for heading levels
        ocr_coverage_threshold (float | None | Unset): OCR coverage threshold
    """

    enabled: bool | Unset = UNSET
    include_bbox: bool | Unset = UNSET
    k_clusters: int | None | Unset = UNSET
    ocr_coverage_threshold: float | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        enabled = self.enabled

        include_bbox = self.include_bbox

        k_clusters: int | None | Unset
        if isinstance(self.k_clusters, Unset):
            k_clusters = UNSET
        else:
            k_clusters = self.k_clusters

        ocr_coverage_threshold: float | None | Unset
        if isinstance(self.ocr_coverage_threshold, Unset):
            ocr_coverage_threshold = UNSET
        else:
            ocr_coverage_threshold = self.ocr_coverage_threshold

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if enabled is not UNSET:
            field_dict["enabled"] = enabled
        if include_bbox is not UNSET:
            field_dict["include_bbox"] = include_bbox
        if k_clusters is not UNSET:
            field_dict["k_clusters"] = k_clusters
        if ocr_coverage_threshold is not UNSET:
            field_dict["ocr_coverage_threshold"] = ocr_coverage_threshold

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        enabled = d.pop("enabled", UNSET)

        include_bbox = d.pop("include_bbox", UNSET)

        def _parse_k_clusters(data: object) -> int | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("int | None | Unset", data)

        k_clusters = _parse_k_clusters(d.pop("k_clusters", UNSET))

        def _parse_ocr_coverage_threshold(data: object) -> float | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("float | None | Unset", data)

        ocr_coverage_threshold = _parse_ocr_coverage_threshold(d.pop("ocr_coverage_threshold", UNSET))

        hierarchy_config = cls(
            enabled=enabled,
            include_bbox=include_bbox,
            k_clusters=k_clusters,
            ocr_coverage_threshold=ocr_coverage_threshold,
        )

        hierarchy_config.additional_properties = d
        return hierarchy_config

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
