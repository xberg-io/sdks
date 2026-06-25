from __future__ import annotations

from collections.abc import Mapping
from typing import TYPE_CHECKING, Any, TypeVar, cast

from attrs import define as _attrs_define
from attrs import field as _attrs_field
from typing_extensions import Self

from ..models.ocr_element_level import OcrElementLevel, check_ocr_element_level
from ..types import UNSET, Unset

if TYPE_CHECKING:
    from ..models.ocr_bounding_geometry_type_0 import OcrBoundingGeometryType0
    from ..models.ocr_bounding_geometry_type_1 import OcrBoundingGeometryType1
    from ..models.ocr_confidence import OcrConfidence
    from ..models.ocr_element_backend_metadata import OcrElementBackendMetadata
    from ..models.ocr_rotation import OcrRotation


T = TypeVar("T", bound="OcrElement")


@_attrs_define
class OcrElement:
    """A unified OCR element representing detected text with full metadata.

    This is the primary type for structured OCR output, preserving all information
    from both Tesseract and PaddleOCR backends.

    Attributes:
            confidence (OcrConfidence): Confidence scores for an OCR element.

                Separates detection confidence (how confident that text exists at this location)
                from recognition confidence (how confident about the actual text content).
            geometry (OcrBoundingGeometryType0 | OcrBoundingGeometryType1): Bounding geometry for an OCR element.

                Supports both axis-aligned rectangles (from Tesseract) and 4-point quadrilaterals
                (from PaddleOCR and rotated text detection).
            text (str): The recognized text content.
            backend_metadata (OcrElementBackendMetadata | Unset): Backend-specific metadata that doesn't fit the unified
                schema.
            level (OcrElementLevel | Unset): Hierarchical level of an OCR element.

                Maps to Tesseract's page segmentation hierarchy and provides
                equivalent semantics for PaddleOCR.
            page_number (int | Unset): Page number (1-indexed).
            parent_id (None | str | Unset): Parent element ID for hierarchical relationships.

                Only used for Tesseract output which has word -> line -> block hierarchy.
            rotation (None | OcrRotation | Unset):
    """

    confidence: OcrConfidence
    geometry: OcrBoundingGeometryType0 | OcrBoundingGeometryType1
    text: str
    backend_metadata: OcrElementBackendMetadata | Unset = UNSET
    level: OcrElementLevel | Unset = UNSET
    page_number: int | Unset = UNSET
    parent_id: None | str | Unset = UNSET
    rotation: None | OcrRotation | Unset = UNSET
    additional_properties: dict[str, Any] = _attrs_field(init=False, factory=dict)

    def to_dict(self) -> dict[str, Any]:
        from ..models.ocr_bounding_geometry_type_0 import OcrBoundingGeometryType0
        from ..models.ocr_rotation import OcrRotation

        confidence = self.confidence.to_dict()

        geometry: dict[str, Any]
        if isinstance(self.geometry, OcrBoundingGeometryType0):
            geometry = self.geometry.to_dict()
        else:
            geometry = self.geometry.to_dict()

        text = self.text

        backend_metadata: dict[str, Any] | Unset = UNSET
        if not isinstance(self.backend_metadata, Unset):
            backend_metadata = self.backend_metadata.to_dict()

        level: str | Unset = UNSET
        if not isinstance(self.level, Unset):
            level = self.level

        page_number = self.page_number

        parent_id: None | str | Unset
        if isinstance(self.parent_id, Unset):
            parent_id = UNSET
        else:
            parent_id = self.parent_id

        rotation: dict[str, Any] | None | Unset
        if isinstance(self.rotation, Unset):
            rotation = UNSET
        elif isinstance(self.rotation, OcrRotation):
            rotation = self.rotation.to_dict()
        else:
            rotation = self.rotation

        field_dict: dict[str, Any] = {}
        field_dict.update(self.additional_properties)
        field_dict.update(
            {
                "confidence": confidence,
                "geometry": geometry,
                "text": text,
            }
        )
        if backend_metadata is not UNSET:
            field_dict["backend_metadata"] = backend_metadata
        if level is not UNSET:
            field_dict["level"] = level
        if page_number is not UNSET:
            field_dict["page_number"] = page_number
        if parent_id is not UNSET:
            field_dict["parent_id"] = parent_id
        if rotation is not UNSET:
            field_dict["rotation"] = rotation

        return field_dict

    @classmethod
    def from_dict(cls, src_dict: Mapping[str, Any]) -> Self:
        from ..models.ocr_bounding_geometry_type_0 import OcrBoundingGeometryType0
        from ..models.ocr_bounding_geometry_type_1 import OcrBoundingGeometryType1
        from ..models.ocr_confidence import OcrConfidence
        from ..models.ocr_element_backend_metadata import OcrElementBackendMetadata
        from ..models.ocr_rotation import OcrRotation

        d = dict(src_dict)
        confidence = OcrConfidence.from_dict(d.pop("confidence"))

        def _parse_geometry(data: object) -> OcrBoundingGeometryType0 | OcrBoundingGeometryType1:
            try:
                if not isinstance(data, dict):
                    raise TypeError
                componentsschemas_ocr_bounding_geometry_type_0 = OcrBoundingGeometryType0.from_dict(data)

                return componentsschemas_ocr_bounding_geometry_type_0
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            if not isinstance(data, dict):
                raise TypeError
            componentsschemas_ocr_bounding_geometry_type_1 = OcrBoundingGeometryType1.from_dict(data)

            return componentsschemas_ocr_bounding_geometry_type_1

        geometry = _parse_geometry(d.pop("geometry"))

        text = d.pop("text")

        _backend_metadata = d.pop("backend_metadata", UNSET)
        backend_metadata: OcrElementBackendMetadata | Unset
        if isinstance(_backend_metadata, Unset):
            backend_metadata = UNSET
        else:
            backend_metadata = OcrElementBackendMetadata.from_dict(_backend_metadata)

        _level = d.pop("level", UNSET)
        level: OcrElementLevel | Unset
        if isinstance(_level, Unset):
            level = UNSET
        else:
            level = check_ocr_element_level(_level)

        page_number = d.pop("page_number", UNSET)

        def _parse_parent_id(data: object) -> None | str | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            return cast("None | str | Unset", data)

        parent_id = _parse_parent_id(d.pop("parent_id", UNSET))

        def _parse_rotation(data: object) -> None | OcrRotation | Unset:
            if data is None:
                return data
            if isinstance(data, Unset):
                return data
            try:
                if not isinstance(data, dict):
                    raise TypeError
                rotation_type_1 = OcrRotation.from_dict(data)

                return rotation_type_1
            except (TypeError, ValueError, AttributeError, KeyError):
                pass
            return cast("None | OcrRotation | Unset", data)

        rotation = _parse_rotation(d.pop("rotation", UNSET))

        ocr_element = cls(
            confidence=confidence,
            geometry=geometry,
            text=text,
            backend_metadata=backend_metadata,
            level=level,
            page_number=page_number,
            parent_id=parent_id,
            rotation=rotation,
        )

        ocr_element.additional_properties = d
        return ocr_element

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
