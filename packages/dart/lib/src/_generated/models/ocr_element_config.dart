// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ocr_element_config.freezed.dart';
part 'ocr_element_config.g.dart';

/// Structured OCR element extraction configuration.
@Freezed()
abstract class OcrElementConfig with _$OcrElementConfig {
  const factory OcrElementConfig({
    /// Build parent-child relationships
    @JsonKey(name: 'build_hierarchy')
    bool? buildHierarchy,

    /// Include OCR elements in result
    @JsonKey(name: 'include_elements')
    bool? includeElements,

    /// Minimum recognition confidence (0.0-1.0)
    @JsonKey(name: 'min_confidence')
    double? minConfidence,

    /// Minimum hierarchical level: "word", "line", "block", "page"
    @JsonKey(name: 'min_level')
    String? minLevel,
  }) = _OcrElementConfig;
  
  factory OcrElementConfig.fromJson(Map<String, Object?> json) => _$OcrElementConfigFromJson(json);
}
