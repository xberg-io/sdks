// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'ocr_bounding_geometry.dart';
import 'ocr_confidence.dart';
import 'ocr_element_level.dart';
import 'ocr_rotation.dart';

part 'ocr_element.freezed.dart';
part 'ocr_element.g.dart';

/// A unified OCR element representing detected text with full metadata.
///
/// This is the primary type for structured OCR output, preserving all information.
/// from both Tesseract and PaddleOCR backends.
@Freezed()
abstract class OcrElement with _$OcrElement {
  const factory OcrElement({
    /// Confidence scores for detection and recognition.
    required OcrConfidence confidence,

    /// Bounding geometry (rectangle or quadrilateral).
    required OcrBoundingGeometry geometry,

    /// The recognized text content.
    required String text,

    /// Backend-specific metadata that doesn't fit the unified schema.
    @JsonKey(name: 'backend_metadata') Map<String, dynamic>? backendMetadata,

    /// Hierarchical level (word, line, block, page).
    OcrElementLevel? level,

    /// Page number (1-indexed).
    @JsonKey(name: 'page_number') int? pageNumber,

    /// Parent element ID for hierarchical relationships.
    ///
    /// Only used for Tesseract output which has word -> line -> block hierarchy.
    @JsonKey(name: 'parent_id') String? parentId,

    /// Rotation information (if detected).
    OcrRotation? rotation,
  }) = _OcrElement;

  factory OcrElement.fromJson(Map<String, Object?> json) =>
      _$OcrElementFromJson(json);
}
