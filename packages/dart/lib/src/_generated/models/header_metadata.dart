// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'header_metadata.freezed.dart';
part 'header_metadata.g.dart';

/// Header/heading element metadata.
@Freezed()
abstract class HeaderMetadata with _$HeaderMetadata {
  const factory HeaderMetadata({
    /// Document tree depth at the header element
    required int depth,

    /// Byte offset in original HTML document
    @JsonKey(name: 'html_offset')
    required int htmlOffset,

    /// Header level: 1 (h1) through 6 (h6)
    required int level,

    /// Normalized text content of the header
    required String text,

    /// HTML id attribute if present
    String? id,
  }) = _HeaderMetadata;
  
  factory HeaderMetadata.fromJson(Map<String, Object?> json) => _$HeaderMetadataFromJson(json);
}
