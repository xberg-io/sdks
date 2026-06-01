// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_reduction_config.freezed.dart';
part 'token_reduction_config.g.dart';

/// Token reduction configuration for LLM consumption.
@Freezed()
abstract class TokenReductionConfig with _$TokenReductionConfig {
  const factory TokenReductionConfig({
    /// Reduction mode: "off", "light", "moderate", "aggressive", "maximum"
    String? mode,

    /// Preserve capitalized/technical terms
    @JsonKey(name: 'preserve_important_words') bool? preserveImportantWords,
  }) = _TokenReductionConfig;

  factory TokenReductionConfig.fromJson(Map<String, Object?> json) =>
      _$TokenReductionConfigFromJson(json);
}
