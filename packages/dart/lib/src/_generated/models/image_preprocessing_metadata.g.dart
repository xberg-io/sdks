// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_preprocessing_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ImagePreprocessingMetadata _$ImagePreprocessingMetadataFromJson(
  Map<String, dynamic> json,
) => _ImagePreprocessingMetadata(
  autoAdjusted: json['auto_adjusted'] as bool,
  dimensionClamped: json['dimension_clamped'] as bool,
  finalDpi: (json['final_dpi'] as num).toInt(),
  originalDimensions: (json['original_dimensions'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  originalDpi: (json['original_dpi'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
  resampleMethod: json['resample_method'] as String,
  scaleFactor: (json['scale_factor'] as num).toDouble(),
  skippedResize: json['skipped_resize'] as bool,
  targetDpi: (json['target_dpi'] as num).toInt(),
  calculatedDpi: (json['calculated_dpi'] as num?)?.toInt(),
  newDimensions: (json['new_dimensions'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  resizeError: json['resize_error'] as String?,
);

Map<String, dynamic> _$ImagePreprocessingMetadataToJson(
  _ImagePreprocessingMetadata instance,
) => <String, dynamic>{
  'auto_adjusted': instance.autoAdjusted,
  'dimension_clamped': instance.dimensionClamped,
  'final_dpi': instance.finalDpi,
  'original_dimensions': instance.originalDimensions,
  'original_dpi': instance.originalDpi,
  'resample_method': instance.resampleMethod,
  'scale_factor': instance.scaleFactor,
  'skipped_resize': instance.skippedResize,
  'target_dpi': instance.targetDpi,
  'calculated_dpi': instance.calculatedDpi,
  'new_dimensions': instance.newDimensions,
  'resize_error': instance.resizeError,
};
