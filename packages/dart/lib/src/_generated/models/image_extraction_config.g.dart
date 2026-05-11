// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_extraction_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ImageExtractionConfig _$ImageExtractionConfigFromJson(
        Map<String, dynamic> json) =>
    _ImageExtractionConfig(
      autoAdjustDpi: json['auto_adjust_dpi'] as bool?,
      extractImages: json['extract_images'] as bool?,
      injectPlaceholders: json['inject_placeholders'] as bool?,
      maxDpi: (json['max_dpi'] as num?)?.toInt(),
      maxImageDimension: (json['max_image_dimension'] as num?)?.toInt(),
      minDpi: (json['min_dpi'] as num?)?.toInt(),
      targetDpi: (json['target_dpi'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ImageExtractionConfigToJson(
        _ImageExtractionConfig instance) =>
    <String, dynamic>{
      'auto_adjust_dpi': instance.autoAdjustDpi,
      'extract_images': instance.extractImages,
      'inject_placeholders': instance.injectPlaceholders,
      'max_dpi': instance.maxDpi,
      'max_image_dimension': instance.maxImageDimension,
      'min_dpi': instance.minDpi,
      'target_dpi': instance.targetDpi,
    };
