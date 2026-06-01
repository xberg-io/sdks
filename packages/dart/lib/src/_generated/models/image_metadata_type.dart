// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'image_type.dart';

part 'image_metadata_type.freezed.dart';
part 'image_metadata_type.g.dart';

/// Image element metadata.
@Freezed()
abstract class ImageMetadataType with _$ImageMetadataType {
  const factory ImageMetadataType({
    /// Additional attributes as key-value pairs
    required List<List<String>> attributes,

    /// Image type classification
    @JsonKey(name: 'image_type') required ImageType imageType,

    /// Image source (URL, data URI, or SVG content)
    required String src,

    /// Alternative text from alt attribute
    String? alt,

    /// Image dimensions as (width, height) if available
    List<int>? dimensions,

    /// Title attribute
    String? title,
  }) = _ImageMetadataType;

  factory ImageMetadataType.fromJson(Map<String, Object?> json) =>
      _$ImageMetadataTypeFromJson(json);
}
