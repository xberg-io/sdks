// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_config.freezed.dart';
part 'page_config.g.dart';

/// Page extraction configuration.
@Freezed()
abstract class PageConfig with _$PageConfig {
  const factory PageConfig({
    /// Extract pages as separate array in result
    @JsonKey(name: 'extract_pages')
    bool? extractPages,

    /// Insert page markers in content text
    @JsonKey(name: 'insert_page_markers')
    bool? insertPageMarkers,

    /// Page marker format template (e.g., "\n\n<!-- PAGE {page_num} -->\n\n")
    @JsonKey(name: 'marker_format')
    String? markerFormat,
  }) = _PageConfig;
  
  factory PageConfig.fromJson(Map<String, Object?> json) => _$PageConfigFromJson(json);
}
