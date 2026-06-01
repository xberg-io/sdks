// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'ocr_pipeline_stage.dart';
import 'ocr_quality_thresholds.dart';

part 'ocr_pipeline_config.freezed.dart';
part 'ocr_pipeline_config.g.dart';

/// Multi-backend OCR pipeline with quality-based fallback.
@Freezed()
abstract class OcrPipelineConfig with _$OcrPipelineConfig {
  const factory OcrPipelineConfig({
    /// Quality evaluation thresholds for fallback decisions
    @JsonKey(name: 'quality_thresholds')
    OcrQualityThresholds? qualityThresholds,

    /// Ordered list of backends to try (sorted by priority descending)
    List<OcrPipelineStage>? stages,
  }) = _OcrPipelineConfig;

  factory OcrPipelineConfig.fromJson(Map<String, Object?> json) =>
      _$OcrPipelineConfigFromJson(json);
}
