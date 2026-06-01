// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'hierarchy_config.freezed.dart';
part 'hierarchy_config.g.dart';

/// Heading hierarchy detection configuration.
@Freezed()
abstract class HierarchyConfig with _$HierarchyConfig {
  const factory HierarchyConfig({
    /// Enable hierarchy detection
    bool? enabled,

    /// Include bounding boxes
    @JsonKey(name: 'include_bbox') bool? includeBbox,

    /// Number of font-size clusters for heading levels
    @JsonKey(name: 'k_clusters') int? kClusters,

    /// OCR coverage threshold
    @JsonKey(name: 'ocr_coverage_threshold') double? ocrCoverageThreshold,
  }) = _HierarchyConfig;

  factory HierarchyConfig.fromJson(Map<String, Object?> json) =>
      _$HierarchyConfigFromJson(json);
}
