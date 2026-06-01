// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'layout_detection_config.freezed.dart';
part 'layout_detection_config.g.dart';

/// Document layout detection configuration.
@Freezed()
abstract class LayoutDetectionConfig with _$LayoutDetectionConfig {
  const factory LayoutDetectionConfig({
    /// Apply postprocessing heuristics
    @JsonKey(name: 'apply_heuristics') bool? applyHeuristics,

    /// Confidence threshold override
    @JsonKey(name: 'confidence_threshold') double? confidenceThreshold,

    /// Preset: "fast" or "accurate"
    String? preset,
  }) = _LayoutDetectionConfig;

  factory LayoutDetectionConfig.fromJson(Map<String, Object?> json) =>
      _$LayoutDetectionConfigFromJson(json);
}
