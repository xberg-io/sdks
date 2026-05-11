// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ocr_pipeline_stage.freezed.dart';
part 'ocr_pipeline_stage.g.dart';

/// Single backend stage in the OCR pipeline.
@Freezed()
abstract class OcrPipelineStage with _$OcrPipelineStage {
  const factory OcrPipelineStage({
    /// Backend name. Only "tesseract" is supported; any other value is.
    /// rejected at the API boundary.
    required String backend,

    /// Language override for this stage
    String? language,

    /// Priority (higher = tried first, default 100)
    int? priority,

    /// Tesseract config override for this stage
    @JsonKey(name: 'tesseract_config')
    dynamic tesseractConfig,

    /// VLM config override for this stage
    @JsonKey(name: 'vlm_config')
    dynamic vlmConfig,
  }) = _OcrPipelineStage;
  
  factory OcrPipelineStage.fromJson(Map<String, Object?> json) => _$OcrPipelineStageFromJson(json);
}
