// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hierarchy_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HierarchyConfig _$HierarchyConfigFromJson(Map<String, dynamic> json) =>
    _HierarchyConfig(
      enabled: json['enabled'] as bool?,
      includeBbox: json['include_bbox'] as bool?,
      kClusters: (json['k_clusters'] as num?)?.toInt(),
      ocrCoverageThreshold: (json['ocr_coverage_threshold'] as num?)
          ?.toDouble(),
    );

Map<String, dynamic> _$HierarchyConfigToJson(_HierarchyConfig instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'include_bbox': instance.includeBbox,
      'k_clusters': instance.kClusters,
      'ocr_coverage_threshold': instance.ocrCoverageThreshold,
    };
