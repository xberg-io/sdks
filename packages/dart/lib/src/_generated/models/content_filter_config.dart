// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_filter_config.freezed.dart';
part 'content_filter_config.g.dart';

/// Content filtering configuration (headers, footers, watermarks).
@Freezed()
abstract class ContentFilterConfig with _$ContentFilterConfig {
  const factory ContentFilterConfig({
    /// Include running footers
    @JsonKey(name: 'include_footers')
    bool? includeFooters,

    /// Include running headers
    @JsonKey(name: 'include_headers')
    bool? includeHeaders,

    /// Include watermarks
    @JsonKey(name: 'include_watermarks')
    bool? includeWatermarks,

    /// Strip cross-page repeating text
    @JsonKey(name: 'strip_repeating_text')
    bool? stripRepeatingText,
  }) = _ContentFilterConfig;
  
  factory ContentFilterConfig.fromJson(Map<String, Object?> json) => _$ContentFilterConfigFromJson(json);
}
