// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ocr_rotation.freezed.dart';
part 'ocr_rotation.g.dart';

/// Rotation information for an OCR element.
@Freezed()
abstract class OcrRotation with _$OcrRotation {
  const factory OcrRotation({
    /// Rotation angle in degrees (0, 90, 180, 270 for PaddleOCR).
    @JsonKey(name: 'angle_degrees') required double angleDegrees,

    /// Confidence score for the rotation detection.
    double? confidence,
  }) = _OcrRotation;

  factory OcrRotation.fromJson(Map<String, Object?> json) =>
      _$OcrRotationFromJson(json);
}
