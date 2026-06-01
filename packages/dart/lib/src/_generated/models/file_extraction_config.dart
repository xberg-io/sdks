// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'chunking_config.dart';
import 'content_filter_config.dart';
import 'image_extraction_config.dart';
import 'language_detection_config.dart';
import 'ocr_config.dart';
import 'page_config.dart';
import 'post_processor_config.dart';
import 'token_reduction_config.dart';

part 'file_extraction_config.freezed.dart';
part 'file_extraction_config.g.dart';

/// Per-file extraction config override for batch/presign requests.
///
/// All fields are optional — only provided fields override the batch-level config.
@Freezed()
abstract class FileExtractionConfig with _$FileExtractionConfig {
  const factory FileExtractionConfig({
    ChunkingConfig? chunking,
    @JsonKey(name: 'content_filter') ContentFilterConfig? contentFilter,
    @JsonKey(name: 'disable_ocr') bool? disableOcr,
    @JsonKey(name: 'enable_quality_processing') bool? enableQualityProcessing,
    @JsonKey(name: 'extraction_timeout_secs') int? extractionTimeoutSecs,
    @JsonKey(name: 'force_ocr') bool? forceOcr,
    @JsonKey(name: 'force_ocr_pages') List<int>? forceOcrPages,
    ImageExtractionConfig? images,
    @JsonKey(name: 'include_document_structure') bool? includeDocumentStructure,
    @JsonKey(name: 'language_detection')
    LanguageDetectionConfig? languageDetection,
    OcrConfig? ocr,
    @JsonKey(name: 'output_format') String? outputFormat,
    PageConfig? pages,
    PostProcessorConfig? postprocessor,
    @JsonKey(name: 'result_format') String? resultFormat,
    @JsonKey(name: 'token_reduction') TokenReductionConfig? tokenReduction,
  }) = _FileExtractionConfig;

  factory FileExtractionConfig.fromJson(Map<String, Object?> json) =>
      _$FileExtractionConfigFromJson(json);
}
