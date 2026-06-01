// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'format_metadata.dart';

part 'ocr_metadata.freezed.dart';
part 'ocr_metadata.g.dart';

/// OCR processing metadata.
///
/// Captures information about OCR processing configuration and results.
@Freezed()
abstract class OcrMetadata with _$OcrMetadata {
  const factory OcrMetadata({
    /// OCR language code(s) used
    required String language,

    /// Output format (e.g., "text", "hocr")
    @JsonKey(name: 'output_format') required String outputFormat,

    /// Tesseract Page Segmentation Mode (PSM)
    required int psm,

    /// Number of tables detected
    @JsonKey(name: 'table_count') required int tableCount,
    @JsonKey(name: 'table_cols') int? tableCols,
    @JsonKey(name: 'table_rows') int? tableRows,
  }) = _OcrMetadata;

  factory OcrMetadata.fromJson(Map<String, Object?> json) =>
      _$OcrMetadataFromJson(json);
}
