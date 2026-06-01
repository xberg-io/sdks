// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_preprocessing_metadata.freezed.dart';
part 'image_preprocessing_metadata.g.dart';

/// Image preprocessing metadata.
///
/// Tracks the transformations applied to an image during OCR preprocessing,.
/// including DPI normalization, resizing, and resampling.
@Freezed()
abstract class ImagePreprocessingMetadata with _$ImagePreprocessingMetadata {
  const factory ImagePreprocessingMetadata({
    /// Whether DPI was auto-adjusted based on content
    @JsonKey(name: 'auto_adjusted')
    required bool autoAdjusted,

    /// Whether dimensions were clamped to max_image_dimension
    @JsonKey(name: 'dimension_clamped')
    required bool dimensionClamped,

    /// Final DPI after processing
    @JsonKey(name: 'final_dpi')
    required int finalDpi,

    /// Original image dimensions (width, height) in pixels
    @JsonKey(name: 'original_dimensions')
    required List<int> originalDimensions,

    /// Original image DPI (horizontal, vertical)
    @JsonKey(name: 'original_dpi')
    required List<double> originalDpi,

    /// Resampling algorithm used ("LANCZOS3", "CATMULLROM", etc.)
    @JsonKey(name: 'resample_method')
    required String resampleMethod,

    /// Scaling factor applied to the image
    @JsonKey(name: 'scale_factor')
    required double scaleFactor,

    /// Whether resize was skipped (dimensions already optimal)
    @JsonKey(name: 'skipped_resize')
    required bool skippedResize,

    /// Target DPI from configuration
    @JsonKey(name: 'target_dpi')
    required int targetDpi,

    /// Calculated optimal DPI (if auto_adjust_dpi enabled)
    @JsonKey(name: 'calculated_dpi')
    int? calculatedDpi,

    /// New dimensions after resizing (if resized)
    @JsonKey(name: 'new_dimensions')
    List<int>? newDimensions,

    /// Error message if resize failed
    @JsonKey(name: 'resize_error')
    String? resizeError,
  }) = _ImagePreprocessingMetadata;
  
  factory ImagePreprocessingMetadata.fromJson(Map<String, Object?> json) => _$ImagePreprocessingMetadataFromJson(json);
}
