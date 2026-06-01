// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocr_pipeline_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OcrPipelineConfig _$OcrPipelineConfigFromJson(Map<String, dynamic> json) =>
    _OcrPipelineConfig(
      qualityThresholds: json['quality_thresholds'] == null
          ? null
          : OcrQualityThresholds.fromJson(
              json['quality_thresholds'] as Map<String, dynamic>,
            ),
      stages: (json['stages'] as List<dynamic>?)
          ?.map((e) => OcrPipelineStage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OcrPipelineConfigToJson(_OcrPipelineConfig instance) =>
    <String, dynamic>{
      'quality_thresholds': instance.qualityThresholds,
      'stages': instance.stages,
    };
