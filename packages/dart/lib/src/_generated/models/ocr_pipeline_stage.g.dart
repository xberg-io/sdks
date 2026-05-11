// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocr_pipeline_stage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OcrPipelineStage _$OcrPipelineStageFromJson(Map<String, dynamic> json) =>
    _OcrPipelineStage(
      backend: json['backend'] as String,
      language: json['language'] as String?,
      priority: (json['priority'] as num?)?.toInt(),
      tesseractConfig: json['tesseract_config'],
      vlmConfig: json['vlm_config'],
    );

Map<String, dynamic> _$OcrPipelineStageToJson(_OcrPipelineStage instance) =>
    <String, dynamic>{
      'backend': instance.backend,
      'language': instance.language,
      'priority': instance.priority,
      'tesseract_config': instance.tesseractConfig,
      'vlm_config': instance.vlmConfig,
    };
