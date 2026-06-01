// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'hierarchy_config.dart';

part 'pdf_config.freezed.dart';
part 'pdf_config.g.dart';

/// PDF-specific extraction options.
@Freezed()
abstract class PdfConfig with _$PdfConfig {
  const factory PdfConfig({
    /// Bottom margin fraction to skip (0.0-1.0)
    @JsonKey(name: 'bottom_margin_fraction') double? bottomMarginFraction,

    /// Extract PDF annotations
    @JsonKey(name: 'extract_annotations') bool? extractAnnotations,

    /// Extract images from PDF
    @JsonKey(name: 'extract_images') bool? extractImages,

    /// Extract PDF metadata
    @JsonKey(name: 'extract_metadata') bool? extractMetadata,

    /// Heading hierarchy detection
    HierarchyConfig? hierarchy,

    /// PDF passwords to try
    List<String>? passwords,

    /// Top margin fraction to skip (0.0-1.0)
    @JsonKey(name: 'top_margin_fraction') double? topMarginFraction,
  }) = _PdfConfig;

  factory PdfConfig.fromJson(Map<String, Object?> json) =>
      _$PdfConfigFromJson(json);
}
