// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'bounding_box.dart';

part 'extracted_image.freezed.dart';
part 'extracted_image.g.dart';

/// Extracted image with base64-encoded data.
@Freezed()
abstract class ExtractedImage with _$ExtractedImage {
  const factory ExtractedImage({
    /// Bounding box on the page
    @JsonKey(name: 'bounding_box')
    BoundingBox? boundingBox,

    /// Base64-encoded image data
    String? data,

    /// Image description
    String? description,

    /// Image format (e.g., "PNG", "JPEG")
    String? format,

    /// Image height in pixels
    int? height,

    /// Image index within the document
    @JsonKey(name: 'image_index')
    int? imageIndex,

    /// Page number the image was found on
    @JsonKey(name: 'page_number')
    int? pageNumber,

    /// Image width in pixels
    int? width,
  }) = _ExtractedImage;
  
  factory ExtractedImage.fromJson(Map<String, Object?> json) => _$ExtractedImageFromJson(json);
}
