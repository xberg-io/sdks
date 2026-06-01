// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_processor_config.freezed.dart';
part 'post_processor_config.g.dart';

/// Post-processing pipeline configuration.
@Freezed()
abstract class PostProcessorConfig with _$PostProcessorConfig {
  const factory PostProcessorConfig({
    /// Blacklist of processors to disable (None = none)
    @JsonKey(name: 'disabled_processors') List<String>? disabledProcessors,

    /// Enable post-processors
    bool? enabled,

    /// Whitelist of processors to enable (None = all)
    @JsonKey(name: 'enabled_processors') List<String>? enabledProcessors,
  }) = _PostProcessorConfig;

  factory PostProcessorConfig.fromJson(Map<String, Object?> json) =>
      _$PostProcessorConfigFromJson(json);
}
