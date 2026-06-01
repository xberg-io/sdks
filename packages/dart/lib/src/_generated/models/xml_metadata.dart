// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'format_metadata.dart';

part 'xml_metadata.freezed.dart';
part 'xml_metadata.g.dart';

/// XML metadata extracted during XML parsing.
///
/// Provides statistics about XML document structure.
@Freezed()
abstract class XmlMetadata with _$XmlMetadata {
  const factory XmlMetadata({
    /// Total number of XML elements processed
    @JsonKey(name: 'element_count') required int elementCount,

    /// List of unique element tag names (sorted)
    @JsonKey(name: 'unique_elements') required List<String> uniqueElements,
  }) = _XmlMetadata;

  factory XmlMetadata.fromJson(Map<String, Object?> json) =>
      _$XmlMetadataFromJson(json);
}
