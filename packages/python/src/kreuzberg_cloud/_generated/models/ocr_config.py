from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.ocr_element_config import OcrElementConfig
    from ..models.ocr_pipeline_config import OcrPipelineConfig
    from ..models.ocr_quality_thresholds import OcrQualityThresholds


T = TypeVar("T", bound="OcrConfig")


@_attrs_define
class OcrConfig:
    """OCR backend and language configuration.

    Attributes:
        auto_rotate (bool | None | Unset): Automatic page rotation detection
        backend (None | str | Unset): OCR backend: "tesseract", "easyocr", or "vlm"
        element_config (None | OcrElementConfig | Unset):
        language (None | str | Unset): Language code (e.g., "eng", "deu", "fra")
        output_format (None | str | Unset): OCR output format override
        pipeline (None | OcrPipelineConfig | Unset):
        quality_thresholds (None | OcrQualityThresholds | Unset):
        tesseract_config (Any | Unset): Tesseract-specific configuration (flexible JSON with 20+ fields)
        vlm_config (Any | Unset): VLM (Vision Language Model) configuration
        vlm_prompt (None | str | Unset): Custom Jinja2 prompt template for VLM OCR
    """

    auto_rotate: bool | None | Unset = UNSET
    backend: None | str | Unset = UNSET
    element_config: None | OcrElementConfig | Unset = UNSET
    language: None | str | Unset = UNSET
    output_format: None | str | Unset = UNSET
    pipeline: None | OcrPipelineConfig | Unset = UNSET
    quality_thresholds: None | OcrQualityThresholds | Unset = UNSET
    tesseract_config: Any | Unset = UNSET
    vlm_config: Any | Unset = UNSET
    vlm_prompt: None | str | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.ocr_element_config import OcrElementConfig
        from ..models.ocr_pipeline_config import OcrPipelineConfig
        from ..models.ocr_quality_thresholds import OcrQualityThresholds

        auto_rotate: bool | None | Unset
        if isinstance(self.auto_rotate, Unset):
            auto_rotate = UNSET
        else:
            auto_rotate = self.auto_rotate

        backend: None | str | Unset
        if isinstance(self.backend, Unset):
            backend = UNSET
        else:
            backend = self.backend

        element_config: dict[str, Any] | None | Unset
        if isinstance(self.element_config, Unset):
            element_config = UNSET
        elif isinstance(self.element_config, OcrElementConfig):
            element_config = self.element_config.to_dict()
        else:
            element_config = self.element_config

        language: None | str | Unset
        if isinstance(self.language, Unset):
            language = UNSET
        else:
            language = self.language

        output_format: None | str | Unset
        if isinstance(self.output_format, Unset):
            output_format = UNSET
        else:
            output_format = self.output_format

        pipeline: dict[str, Any] | None | Unset
        if isinstance(self.pipeline, Unset):
            pipeline = UNSET
        elif isinstance(self.pipeline, OcrPipelineConfig):
            pipeline = self.pipeline.to_dict()
        else:
            pipeline = self.pipeline

        quality_thresholds: dict[str, Any] | None | Unset
        if isinstance(self.quality_thresholds, Unset):
            quality_thresholds = UNSET
        elif isinstance(self.quality_thresholds, OcrQualityThresholds):
            quality_thresholds = self.quality_thresholds.to_dict()
        else:
            quality_thresholds = self.quality_thresholds

        tesseract_config = self.tesseract_config

        vlm_config = self.vlm_config

        vlm_prompt: None | str | Unset
        if isinstance(self.vlm_prompt, Unset):
            vlm_prompt = UNSET
        else:
            vlm_prompt = self.vlm_prompt

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update({})
        if auto_rotate is not UNSET:
            field_dict["auto_rotate"] = auto_rotate
        if backend is not UNSET:
            field_dict["backend"] = backend
        if element_config is not UNSET:
            field_dict["element_config"] = element_config
        if language is not UNSET:
            field_dict["language"] = language
        if output_format is not UNSET:
            field_dict["output_format"] = output_format
        if pipeline is not UNSET:
            field_dict["pipeline"] = pipeline
        if quality_thresholds is not UNSET:
            field_dict["quality_thresholds"] = quality_thresholds
        if tesseract_config is not UNSET:
            field_dict["tesseract_config"] = tesseract_config
        if vlm_config is not UNSET:
            field_dict["vlm_config"] = vlm_config
        if vlm_prompt is not UNSET:
            field_dict["vlm_prompt"] = vlm_prompt

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.ocr_element_config import OcrElementConfig
        from ..models.ocr_pipeline_config import OcrPipelineConfig
        from ..models.ocr_quality_thresholds import OcrQualityThresholds

        d = dict(src_dict)

        def _parse_auto_rotate(data: object) -> bool | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("bool | None | Unset", data)

        auto_rotate = _parse_auto_rotate(d.pop("auto_rotate", UNSET))

        def _parse_backend(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        backend = _parse_backend(d.pop("backend", UNSET))

        def _parse_element_config(data: object) -> None | OcrElementConfig | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                element_config_type_1 = OcrElementConfig.from_dict(data)

                return element_config_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("None | OcrElementConfig | Unset", data)

        element_config = _parse_element_config(d.pop("element_config", UNSET))

        def _parse_language(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        language = _parse_language(d.pop("language", UNSET))

        def _parse_output_format(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        output_format = _parse_output_format(d.pop("output_format", UNSET))

        def _parse_pipeline(data: object) -> None | OcrPipelineConfig | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                pipeline_type_1 = OcrPipelineConfig.from_dict(data)

                return pipeline_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("None | OcrPipelineConfig | Unset", data)

        pipeline = _parse_pipeline(d.pop("pipeline", UNSET))

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

        tesseract_config = d.pop("tesseract_config", UNSET)

        vlm_config = d.pop("vlm_config", UNSET)

        def _parse_vlm_prompt(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        vlm_prompt = _parse_vlm_prompt(d.pop("vlm_prompt", UNSET))

        ocr_config = cls(
            auto_rotate=auto_rotate,
            backend=backend,
            element_config=element_config,
            language=language,
            output_format=output_format,
            pipeline=pipeline,
            quality_thresholds=quality_thresholds,
            tesseract_config=tesseract_config,
            vlm_config=vlm_config,
            vlm_prompt=vlm_prompt,
        )

        ocr_config.additional_properties = d
        return ocr_config

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
