from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="OcrPipelineStage")


@_attrs_define
class OcrPipelineStage:
    """Single backend stage in the OCR pipeline.

    Attributes:
        backend (str): Backend name: "tesseract", "easyocr", or custom
        language (None | str | Unset): Language override for this stage
        priority (int | Unset): Priority (higher = tried first, default 100)
        tesseract_config (Any | Unset): Tesseract config override for this stage
        vlm_config (Any | Unset): VLM config override for this stage
    """

    backend: str
    language: None | str | Unset = UNSET
    priority: int | Unset = UNSET
    tesseract_config: Any | Unset = UNSET
    vlm_config: Any | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        backend = self.backend

        language: None | str | Unset
        if isinstance(self.language, Unset):
            language = UNSET
        else:
            language = self.language

        priority = self.priority

        tesseract_config = self.tesseract_config

        vlm_config = self.vlm_config

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "backend": backend,
            }
        )
        if language is not UNSET:
            field_dict["language"] = language
        if priority is not UNSET:
            field_dict["priority"] = priority
        if tesseract_config is not UNSET:
            field_dict["tesseract_config"] = tesseract_config
        if vlm_config is not UNSET:
            field_dict["vlm_config"] = vlm_config

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        backend = d.pop("backend")

        def _parse_language(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        language = _parse_language(d.pop("language", UNSET))

        priority = d.pop("priority", UNSET)

        tesseract_config = d.pop("tesseract_config", UNSET)

        vlm_config = d.pop("vlm_config", UNSET)

        ocr_pipeline_stage = cls(
            backend=backend,
            language=language,
            priority=priority,
            tesseract_config=tesseract_config,
            vlm_config=vlm_config,
        )

        ocr_pipeline_stage.additional_properties = d
        return ocr_pipeline_stage

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
