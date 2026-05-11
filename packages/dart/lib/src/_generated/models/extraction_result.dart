// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'chunk.dart';
import 'extracted_image.dart';
import 'metadata.dart';
import 'page_content.dart';
import 'processing_warning.dart';
import 'table.dart';

part 'extraction_result.freezed.dart';
part 'extraction_result.g.dart';

/// Extraction result — aligned with kreuzberg::ExtractionResult.
@Freezed()
abstract class ExtractionResult with _$ExtractionResult {
  const factory ExtractionResult({
    /// Text chunks (when chunking is enabled)
    List<Chunk>? chunks,

    /// Full extracted text content
    String? content,

    /// Detected document languages
    @JsonKey(name: 'detected_languages')
    List<String>? detectedLanguages,

    /// Extracted images (base64 encoded)
    List<ExtractedImage>? images,

    /// Document metadata
    Metadata? metadata,

    /// Content MIME type (e.g., "text/plain", "text/markdown")
    @JsonKey(name: 'mime_type')
    String? mimeType,

    /// Per-page content (when page extraction is enabled)
    List<PageContent>? pages,

    /// Non-fatal processing warnings
    @JsonKey(name: 'processing_warnings')
    List<ProcessingWarning>? processingWarnings,

    /// Document quality score (0.0-1.0)
    @JsonKey(name: 'quality_score')
    double? qualityScore,

    /// Extracted tables
    List<Table>? tables,
  }) = _ExtractionResult;
  
  factory ExtractionResult.fromJson(Map<String, Object?> json) => _$ExtractionResultFromJson(json);
}
