// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'language_detection_config.freezed.dart';
part 'language_detection_config.g.dart';

/// Language detection configuration.
@Freezed()
abstract class LanguageDetectionConfig with _$LanguageDetectionConfig {
  const factory LanguageDetectionConfig({
    /// Detect multiple languages in document
    @JsonKey(name: 'detect_multiple') bool? detectMultiple,

    /// Enable language detection
    bool? enabled,

    /// Minimum confidence threshold (0.0-1.0)
    @JsonKey(name: 'min_confidence') double? minConfidence,
  }) = _LanguageDetectionConfig;

  factory LanguageDetectionConfig.fromJson(Map<String, Object?> json) =>
      _$LanguageDetectionConfigFromJson(json);
}
