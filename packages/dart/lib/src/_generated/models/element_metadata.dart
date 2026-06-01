// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'bounding_box.dart';

part 'element_metadata.freezed.dart';
part 'element_metadata.g.dart';

/// Metadata for a semantic element.
@Freezed()
abstract class ElementMetadata with _$ElementMetadata {
  const factory ElementMetadata({
    /// Additional custom metadata
    required Map<String, String> additional,

    /// Bounding box coordinates if available
    BoundingBox? coordinates,

    /// Position index in the element sequence
    @JsonKey(name: 'element_index')
    int? elementIndex,

    /// Source filename or document name
    String? filename,

    /// Page number (1-indexed)
    @JsonKey(name: 'page_number')
    int? pageNumber,
  }) = _ElementMetadata;
  
  factory ElementMetadata.fromJson(Map<String, Object?> json) => _$ElementMetadataFromJson(json);
}
