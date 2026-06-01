// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'extraction_config.dart';

part 'extraction_options.freezed.dart';
part 'extraction_options.g.dart';

/// Extraction options (shared by JSON and multipart requests)
@Freezed()
abstract class ExtractionOptions with _$ExtractionOptions {
  const factory ExtractionOptions({
    /// Kreuzberg extraction configuration (optional, null = defaults).
    @JsonKey(name: 'extraction_config') ExtractionConfig? extractionConfig,
  }) = _ExtractionOptions;

  factory ExtractionOptions.fromJson(Map<String, Object?> json) =>
      _$ExtractionOptionsFromJson(json);
}
