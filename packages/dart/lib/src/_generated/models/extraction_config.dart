// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'chunking_config.dart';
import 'content_filter_config.dart';
import 'image_extraction_config.dart';
import 'language_detection_config.dart';
import 'layout_detection_config.dart';
import 'ocr_config.dart';
import 'page_config.dart';
import 'pdf_config.dart';
import 'post_processor_config.dart';
import 'token_reduction_config.dart';

part 'extraction_config.freezed.dart';
part 'extraction_config.g.dart';

/// Top-level extraction configuration — mirrors kreuzberg::ExtractionConfig.
@Freezed()
abstract class ExtractionConfig with _$ExtractionConfig {
  const factory ExtractionConfig({
    /// Cache namespace for tenant isolation
    @JsonKey(name: 'cache_namespace') String? cacheNamespace,

    /// Per-request cache TTL override in seconds
    @JsonKey(name: 'cache_ttl_secs') int? cacheTtlSecs,

    /// Text chunking configuration
    ChunkingConfig? chunking,

    /// Content filtering (headers, footers, watermarks)
    @JsonKey(name: 'content_filter') ContentFilterConfig? contentFilter,

    /// Disable OCR entirely
    @JsonKey(name: 'disable_ocr') bool? disableOcr,

    /// Enable quality post-processing
    @JsonKey(name: 'enable_quality_processing') bool? enableQualityProcessing,

    /// Per-file extraction timeout in seconds
    @JsonKey(name: 'extraction_timeout_secs') int? extractionTimeoutSecs,

    /// Force OCR on all pages (bypass native text extraction)
    @JsonKey(name: 'force_ocr') bool? forceOcr,

    /// Force OCR on specific pages (1-indexed)
    @JsonKey(name: 'force_ocr_pages') List<int>? forceOcrPages,

    /// HTML extraction options (flexible JSON)
    @JsonKey(name: 'html_options') dynamic htmlOptions,

    /// Image extraction configuration
    ImageExtractionConfig? images,

    /// Include structured document tree in output
    @JsonKey(name: 'include_document_structure') bool? includeDocumentStructure,

    /// Keyword extraction configuration (flexible JSON)
    dynamic keywords,

    /// Language detection configuration
    @JsonKey(name: 'language_detection')
    LanguageDetectionConfig? languageDetection,

    /// Layout detection configuration
    LayoutDetectionConfig? layout,

    /// Maximum recursion depth for archive extraction
    @JsonKey(name: 'max_archive_depth') int? maxArchiveDepth,

    /// Maximum concurrent extractions
    @JsonKey(name: 'max_concurrent_extractions') int? maxConcurrentExtractions,

    /// OCR configuration
    OcrConfig? ocr,

    /// Output text format: "plain", "markdown", "html", "djot", "structured", "json"
    @JsonKey(name: 'output_format') String? outputFormat,

    /// Page extraction configuration
    PageConfig? pages,

    /// PDF-specific options
    @JsonKey(name: 'pdf_options') PdfConfig? pdfOptions,

    /// Post-processor configuration
    PostProcessorConfig? postprocessor,

    /// Result format: "unified" or "element_based"
    @JsonKey(name: 'result_format') String? resultFormat,

    /// Security limits (flexible JSON)
    @JsonKey(name: 'security_limits') dynamic securityLimits,

    /// Token reduction configuration
    @JsonKey(name: 'token_reduction') TokenReductionConfig? tokenReduction,

    /// Enable extraction result caching
    @JsonKey(name: 'use_cache') bool? useCache,
  }) = _ExtractionConfig;

  factory ExtractionConfig.fromJson(Map<String, Object?> json) =>
      _$ExtractionConfigFromJson(json);
}
