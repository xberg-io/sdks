from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.ocr_pipeline_stage import OcrPipelineStage
    from ..models.ocr_quality_thresholds import OcrQualityThresholds


T = TypeVar("T", bound="OcrPipelineConfig")


@_attrs_define
class OcrPipelineConfig:
    """Multi-backend OCR pipeline with quality-based fallback.

    Attributes:
        quality_thresholds (None | OcrQualityThresholds | Unset):
        stages (list[OcrPipelineStage] | Unset): Ordered list of backends to try (sorted by priority descending)
    """

    quality_thresholds: None | OcrQualityThresholds | Unset = UNSET
    stages: list[OcrPipelineStage] | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.ocr_quality_thresholds import OcrQualityThresholds

        quality_thresholds: dict[str, Any] | None | Unset
        if isinstance(self.quality_thresholds, Unset):
            quality_thresholds = UNSET
        elif isinstance(self.quality_thresholds, OcrQualityThresholds):
            quality_thresholds = self.quality_thresholds.to_dict()
        else:
            quality_thresholds = self.quality_thresholds

        stages: list[dict[str, Any]] | Unset = UNSET
        if not isinstance(self.stages, Unset):
            stages = []
            for stages_item_data in self.stages:
                stages_item = stages_item_data.to_dict()
                stages.append(stages_item)

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if quality_thresholds is not UNSET:
            field_dict["quality_thresholds"] = quality_thresholds
        if stages is not UNSET:
            field_dict["stages"] = stages

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.ocr_pipeline_stage import OcrPipelineStage
        from ..models.ocr_quality_thresholds import OcrQualityThresholds

        d = dict(src_dict)

        def _parse_quality_thresholds(data: object) -> None | OcrQualityThresholds | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                quality_thresholds_type_1 = OcrQualityThresholds.from_dict(data)

                return quality_thresholds_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("None | OcrQualityThresholds | Unset", data)

        quality_thresholds = _parse_quality_thresholds(d.pop("quality_thresholds", UNSET))

        _stages = d.pop("stages", UNSET)
        stages: list[OcrPipelineStage] | Unset = UNSET
        if _stages is not UNSET:
            stages = []
            for stages_item_data in _stages:
                stages_item = OcrPipelineStage.from_dict(stages_item_data)

                stages.append(stages_item)

        ocr_pipeline_config = cls(
            quality_thresholds=quality_thresholds,
            stages=stages,
        )

        ocr_pipeline_config.additional_properties = d
        return ocr_pipeline_config

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
