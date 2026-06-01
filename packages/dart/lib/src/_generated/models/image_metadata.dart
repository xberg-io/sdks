// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'format_metadata.dart';

part 'image_metadata.freezed.dart';
part 'image_metadata.g.dart';

/// Image metadata extracted from image files.
///
/// Includes dimensions, format, and EXIF data.
@Freezed()
abstract class ImageMetadata with _$ImageMetadata {
  const factory ImageMetadata({
    /// EXIF metadata tags
    required Map<String, String> exif,

    /// Image format (e.g., "PNG", "JPEG", "TIFF")
    required String format,

    /// Image height in pixels
    required int height,

    /// Image width in pixels
    required int width,
  }) = _ImageMetadata;
  
  factory ImageMetadata.fromJson(Map<String, Object?> json) => _$ImageMetadataFromJson(json);
}
