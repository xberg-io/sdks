// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'error_metadata.dart';
import 'format_metadata.dart';
import 'image_preprocessing_metadata.dart';
import 'page_structure.dart';

part 'metadata.freezed.dart';
part 'metadata.g.dart';

/// Extraction result metadata.
///
/// Contains common fields applicable to all formats, format-specific metadata.
/// via a discriminated union, and additional custom fields from postprocessors.
@Freezed()
abstract class Metadata with _$Metadata {
  const factory Metadata({
    /// Abstract or summary text (from frontmatter).
    @JsonKey(name: 'abstract_text') String? abstractText,

    /// Additional custom fields from postprocessors.
    ///
    /// Serialized as a nested `"additional"` object (not flattened at root level).
    /// Uses `Cow<'static, str>` keys so static string keys avoid allocation.
    Map<String, dynamic>? additional,

    /// Primary author(s) - always Vec for consistency
    List<String>? authors,

    /// Document category (from frontmatter or classification).
    String? category,

    /// Creation timestamp (ISO 8601 format)
    @JsonKey(name: 'created_at') String? createdAt,

    /// User who created the document
    @JsonKey(name: 'created_by') String? createdBy,

    /// Document version string (from frontmatter).
    @JsonKey(name: 'document_version') String? documentVersion,

    /// Error metadata (for batch operations)
    ErrorMetadata? error,

    /// Extraction duration in milliseconds (for benchmarking).
    ///
    /// This field is populated by batch extraction to provide per-file timing.
    /// information. It's `None` for single-file extraction (which uses external timing).
    @JsonKey(name: 'extraction_duration_ms') int? extractionDurationMs,

    /// Format-specific metadata (discriminated union).
    ///
    /// Contains detailed metadata specific to the document format.
    /// Serialized as a nested `"format"` object with a `format_type` discriminator field.
    FormatMetadata? format,

    /// Image preprocessing metadata (when OCR preprocessing was applied)
    @JsonKey(name: 'image_preprocessing')
    ImagePreprocessingMetadata? imagePreprocessing,

    /// JSON schema (for structured data extraction)
    @JsonKey(name: 'json_schema') dynamic jsonSchema,

    /// Keywords/tags - always Vec for consistency
    List<String>? keywords,

    /// Primary language (ISO 639 code)
    String? language,

    /// Last modification timestamp (ISO 8601 format)
    @JsonKey(name: 'modified_at') String? modifiedAt,

    /// User who last modified the document
    @JsonKey(name: 'modified_by') String? modifiedBy,

    /// Whether OCR was used during extraction.
    ///
    /// Set to `true` whenever the extraction pipeline ran an OCR backend.
    /// (Tesseract, PaddleOCR, VLM, etc.) and used that output as the primary.
    /// or fallback text. `false` means native text extraction was used exclusively.
    @JsonKey(name: 'ocr_used') bool? ocrUsed,

    /// Output format identifier (e.g., "markdown", "html", "text").
    ///
    /// Set by the output format pipeline stage when format conversion is applied.
    /// Previously stored in `metadata.additional["output_format"]`.
    @JsonKey(name: 'output_format') String? outputFormat,

    /// Page/slide/sheet structure with boundaries
    PageStructure? pages,

    /// Document subject or description
    String? subject,

    /// Document tags (from frontmatter).
    List<String>? tags,

    /// Document title
    String? title,
  }) = _Metadata;

  factory Metadata.fromJson(Map<String, Object?> json) =>
      _$MetadataFromJson(json);
}
