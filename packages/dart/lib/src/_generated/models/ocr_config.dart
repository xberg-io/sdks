// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'ocr_element_config.dart';
import 'ocr_pipeline_config.dart';
import 'ocr_quality_thresholds.dart';

part 'ocr_config.freezed.dart';
part 'ocr_config.g.dart';

/// OCR backend and language configuration.
@Freezed()
abstract class OcrConfig with _$OcrConfig {
  const factory OcrConfig({
    /// Automatic page rotation detection
    @JsonKey(name: 'auto_rotate')
    bool? autoRotate,

    /// OCR backend: "tesseract", "easyocr", or "vlm"
    String? backend,

    /// Structured OCR element extraction
    @JsonKey(name: 'element_config')
    OcrElementConfig? elementConfig,

    /// Language code (e.g., "eng", "deu", "fra")
    String? language,

    /// OCR output format override
    @JsonKey(name: 'output_format')
    String? outputFormat,

    /// Multi-backend OCR pipeline with quality-based fallback
    OcrPipelineConfig? pipeline,

    /// Quality thresholds for OCR fallback decisions
    @JsonKey(name: 'quality_thresholds')
    OcrQualityThresholds? qualityThresholds,

    /// Tesseract-specific configuration (flexible JSON with 20+ fields)
    @JsonKey(name: 'tesseract_config')
    dynamic tesseractConfig,

    /// VLM (Vision Language Model) configuration
    @JsonKey(name: 'vlm_config')
    dynamic vlmConfig,

    /// Custom Jinja2 prompt template for VLM OCR
    @JsonKey(name: 'vlm_prompt')
    String? vlmPrompt,
  }) = _OcrConfig;
  
  factory OcrConfig.fromJson(Map<String, Object?> json) => _$OcrConfigFromJson(json);
}
