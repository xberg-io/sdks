// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'format_metadata.dart';

part 'pptx_metadata.freezed.dart';
part 'pptx_metadata.g.dart';

/// PowerPoint presentation metadata.
///
/// Extracted from PPTX files containing slide counts and presentation details.
@Freezed()
abstract class PptxMetadata with _$PptxMetadata {
  const factory PptxMetadata({
    /// Total number of slides in the presentation
    @JsonKey(name: 'slide_count')
    required int slideCount,

    /// Names of slides (if available)
    @JsonKey(name: 'slide_names')
    required List<String> slideNames,

    /// Number of embedded images
    @JsonKey(name: 'image_count')
    int? imageCount,

    /// Number of tables
    @JsonKey(name: 'table_count')
    int? tableCount,
  }) = _PptxMetadata;
  
  factory PptxMetadata.fromJson(Map<String, Object?> json) => _$PptxMetadataFromJson(json);
}
