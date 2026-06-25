from __future__ import annotations

from collections.abc import Mapping
from typing import Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..types import UNSET, Unset

T = TypeVar("T", bound="OcrConfidence")


@_attrs_define
class OcrConfidence:
    """Confidence scores for an OCR element.

    Separates detection confidence (how confident that text exists at this location)
    from recognition confidence (how confident about the actual text content).

    Attributes:
            recognition (float): Recognition confidence: how confident about the text content.

                Range: 0.0 to 1.0.
            detection (float | None | Unset): Detection confidence: how confident the OCR engine is that text exists here.

                PaddleOCR provides this as `box_score`, Tesseract doesn't have a direct equivalent.
                Range: 0.0 to 1.0 (or None if not available).
    """

    recognition: float
    detection: float | None | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        recognition = self.recognition

        detection: float | None | Unset
        if isinstance(self.detection, Unset):
            detection = UNSET
        else:
            detection = self.detection

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "recognition": recognition,
            }
        )
        if detection is not UNSET:
            field_dict["detection"] = detection

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        d = dict(src_dict)
        recognition = d.pop("recognition")

        def _parse_detection(data: object) -> float | None | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("float | None | Unset", data)

        detection = _parse_detection(d.pop("detection", UNSET))

        ocr_confidence = cls(
            recognition=recognition,
            detection=detection,
        )

        ocr_confidence.additional_properties = d
        return ocr_confidence

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
