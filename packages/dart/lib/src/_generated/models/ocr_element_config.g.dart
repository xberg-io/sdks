// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocr_element_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OcrElementConfig _$OcrElementConfigFromJson(Map<String, dynamic> json) =>
    _OcrElementConfig(
      buildHierarchy: json['build_hierarchy'] as bool?,
      includeElements: json['include_elements'] as bool?,
      minConfidence: (json['min_confidence'] as num?)?.toDouble(),
      minLevel: json['min_level'] as String?,
    );

Map<String, dynamic> _$OcrElementConfigToJson(_OcrElementConfig instance) =>
    <String, dynamic>{
      'build_hierarchy': instance.buildHierarchy,
      'include_elements': instance.includeElements,
      'min_confidence': instance.minConfidence,
      'min_level': instance.minLevel,
    };
