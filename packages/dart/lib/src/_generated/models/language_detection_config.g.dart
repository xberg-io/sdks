// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_detection_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LanguageDetectionConfig _$LanguageDetectionConfigFromJson(
  Map<String, dynamic> json,
) => _LanguageDetectionConfig(
  detectMultiple: json['detect_multiple'] as bool?,
  enabled: json['enabled'] as bool?,
  minConfidence: (json['min_confidence'] as num?)?.toDouble(),
);

Map<String, dynamic> _$LanguageDetectionConfigToJson(
  _LanguageDetectionConfig instance,
) => <String, dynamic>{
  'detect_multiple': instance.detectMultiple,
  'enabled': instance.enabled,
  'min_confidence': instance.minConfidence,
};
