// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocr_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OcrConfig _$OcrConfigFromJson(Map<String, dynamic> json) => _OcrConfig(
  autoRotate: json['auto_rotate'] as bool?,
  backend: json['backend'] as String?,
  elementConfig: json['element_config'] == null
      ? null
      : OcrElementConfig.fromJson(
          json['element_config'] as Map<String, dynamic>,
        ),
  language: json['language'] as String?,
  outputFormat: json['output_format'] as String?,
  pipeline: json['pipeline'] == null
      ? null
      : OcrPipelineConfig.fromJson(json['pipeline'] as Map<String, dynamic>),
  qualityThresholds: json['quality_thresholds'] == null
      ? null
      : OcrQualityThresholds.fromJson(
          json['quality_thresholds'] as Map<String, dynamic>,
        ),
  tesseractConfig: json['tesseract_config'],
  vlmConfig: json['vlm_config'],
  vlmPrompt: json['vlm_prompt'] as String?,
);

Map<String, dynamic> _$OcrConfigToJson(_OcrConfig instance) =>
    <String, dynamic>{
      'auto_rotate': instance.autoRotate,
      'backend': instance.backend,
      'element_config': instance.elementConfig,
      'language': instance.language,
      'output_format': instance.outputFormat,
      'pipeline': instance.pipeline,
      'quality_thresholds': instance.qualityThresholds,
      'tesseract_config': instance.tesseractConfig,
      'vlm_config': instance.vlmConfig,
      'vlm_prompt': instance.vlmPrompt,
    };
