// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_extraction_config.freezed.dart';
part 'image_extraction_config.g.dart';

/// Image extraction and processing configuration.
@Freezed()
abstract class ImageExtractionConfig with _$ImageExtractionConfig {
  const factory ImageExtractionConfig({
    /// Auto-adjust DPI based on content
    @JsonKey(name: 'auto_adjust_dpi') bool? autoAdjustDpi,

    /// Extract images from documents
    @JsonKey(name: 'extract_images') bool? extractImages,

    /// Inject image reference placeholders in markdown output
    @JsonKey(name: 'inject_placeholders') bool? injectPlaceholders,

    /// Maximum DPI threshold
    @JsonKey(name: 'max_dpi') int? maxDpi,

    /// Maximum image dimension (width or height)
    @JsonKey(name: 'max_image_dimension') int? maxImageDimension,

    /// Minimum DPI threshold
    @JsonKey(name: 'min_dpi') int? minDpi,

    /// Target DPI for image normalization
    @JsonKey(name: 'target_dpi') int? targetDpi,
  }) = _ImageExtractionConfig;

  factory ImageExtractionConfig.fromJson(Map<String, Object?> json) =>
      _$ImageExtractionConfigFromJson(json);
}
