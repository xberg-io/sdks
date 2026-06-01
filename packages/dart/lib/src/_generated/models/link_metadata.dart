// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'link_type.dart';

part 'link_metadata.freezed.dart';
part 'link_metadata.g.dart';

/// Link element metadata.
@Freezed()
abstract class LinkMetadata with _$LinkMetadata {
  const factory LinkMetadata({
    /// Additional attributes as key-value pairs
    required List<List<String>> attributes,

    /// The href URL value
    required String href,

    /// Link type classification
    @JsonKey(name: 'link_type')
    required LinkType linkType,

    /// Rel attribute values
    required List<String> rel,

    /// Link text content (normalized)
    required String text,

    /// Optional title attribute
    String? title,
  }) = _LinkMetadata;
  
  factory LinkMetadata.fromJson(Map<String, Object?> json) => _$LinkMetadataFromJson(json);
}
