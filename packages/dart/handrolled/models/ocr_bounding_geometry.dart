// coverage:ignore-file
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ocr_bounding_geometry.freezed.dart';
part 'ocr_bounding_geometry.g.dart';

/// Bounding geometry for an OCR element.
///
/// Supports both axis-aligned rectangles (from Tesseract) and 4-point
/// quadrilaterals (from PaddleOCR and rotated text detection).
///
/// Discriminated by the `type` field. Hand-written to mirror the
/// [FormatMetadata] pattern because the upstream `oneOf` schema lacks an
/// explicit `discriminator` block.
@Freezed(unionKey: 'type')
sealed class OcrBoundingGeometry with _$OcrBoundingGeometry {
  /// Axis-aligned bounding box (typical for Tesseract output).
  const factory OcrBoundingGeometry.rectangle({
    /// Left x-coordinate in pixels.
    required int left,

    /// Top y-coordinate in pixels.
    required int top,

    /// Width in pixels.
    required int width,

    /// Height in pixels.
    required int height,
  }) = OcrBoundingGeometryRectangle;

  /// 4-point quadrilateral for rotated/skewed text (PaddleOCR).
  ///
  /// Points are in clockwise order starting from top-left:
  /// `[top_left, top_right, bottom_right, bottom_left]`.
  const factory OcrBoundingGeometry.quadrilateral({
    /// Four corner points as `[[x, y], ...]` in clockwise order.
    required List<List<int>> points,
  }) = OcrBoundingGeometryQuadrilateral;

  factory OcrBoundingGeometry.fromJson(Map<String, Object?> json) =>
      _$OcrBoundingGeometryFromJson(json);
}
