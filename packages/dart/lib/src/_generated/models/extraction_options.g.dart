// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extraction_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExtractionOptions _$ExtractionOptionsFromJson(Map<String, dynamic> json) =>
    _ExtractionOptions(
      extractionConfig: json['extraction_config'] == null
          ? null
          : ExtractionConfig.fromJson(
              json['extraction_config'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExtractionOptionsToJson(_ExtractionOptions instance) =>
    <String, dynamic>{
      'extraction_config': instance.extractionConfig,
    };
