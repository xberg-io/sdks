// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout_detection_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LayoutDetectionConfig _$LayoutDetectionConfigFromJson(
  Map<String, dynamic> json,
) => _LayoutDetectionConfig(
  applyHeuristics: json['apply_heuristics'] as bool?,
  confidenceThreshold: (json['confidence_threshold'] as num?)?.toDouble(),
  preset: json['preset'] as String?,
);

Map<String, dynamic> _$LayoutDetectionConfigToJson(
  _LayoutDetectionConfig instance,
) => <String, dynamic>{
  'apply_heuristics': instance.applyHeuristics,
  'confidence_threshold': instance.confidenceThreshold,
  'preset': instance.preset,
};
