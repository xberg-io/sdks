// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ocr_confidence.freezed.dart';
part 'ocr_confidence.g.dart';

/// Confidence scores for an OCR element.
///
/// Separates detection confidence (how confident that text exists at this location).
/// from recognition confidence (how confident about the actual text content).
@Freezed()
abstract class OcrConfidence with _$OcrConfidence {
  const factory OcrConfidence({
    /// Recognition confidence: how confident about the text content.
    ///
    /// Range: 0.0 to 1.0.
    required double recognition,

    /// Detection confidence: how confident the OCR engine is that text exists here.
    ///
    /// PaddleOCR provides this as `box_score`, Tesseract doesn't have a direct equivalent.
    /// Range: 0.0 to 1.0 (or None if not available).
    double? detection,
  }) = _OcrConfidence;

  factory OcrConfidence.fromJson(Map<String, Object?> json) =>
      _$OcrConfidenceFromJson(json);
}
