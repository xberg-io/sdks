// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'bounding_box.dart';
import 'extraction_result.dart';
import 'image_kind.dart';

part 'extracted_image.freezed.dart';
part 'extracted_image.g.dart';

/// Extracted image from a document.
///
/// Contains raw image data, metadata, and optional nested OCR results.
/// Raw bytes allow cross-language compatibility - users can convert to.
/// PIL.Image (Python), Sharp (Node.js), or other formats as needed.
@Freezed()
abstract class ExtractedImage with _$ExtractedImage {
  const factory ExtractedImage({
    /// Raw image data (PNG, JPEG, WebP, etc. bytes).
    /// Uses `bytes::Bytes` for cheap cloning of large buffers.
    required List<int> data,

    /// Image format (e.g., "jpeg", "png", "webp").
    /// Uses Cow<'static, str> to avoid allocation for static literals.
    required String format,

    /// Zero-indexed position of this image in the document/page
    @JsonKey(name: 'image_index') required int imageIndex,

    /// Bits per color component (e.g., 8, 16)
    @JsonKey(name: 'bits_per_component') int? bitsPerComponent,

    /// Bounding box of the image on the page (PDF coordinates: x0=left, y0=bottom, x1=right, y1=top).
    /// Only populated for PDF-extracted images when position data is available from the PDF extractor.
    @JsonKey(name: 'bounding_box') BoundingBox? boundingBox,

    /// Identifier shared across images that form a single logical figure.
    /// (e.g. all raster tiles of one technical drawing). `None` for singletons.
    @JsonKey(name: 'cluster_id') int? clusterId,

    /// Colorspace information (e.g., "RGB", "CMYK", "Gray")
    String? colorspace,

    /// Optional description of the image
    String? description,

    /// Image height in pixels
    int? height,

    /// Heuristic classification of what this image likely depicts.
    /// `None` if classification was disabled or inconclusive.
    @JsonKey(name: 'image_kind') ImageKind? imageKind,

    /// Whether this image is a mask image
    @JsonKey(name: 'is_mask') bool? isMask,

    /// Confidence score for `image_kind`, in the range 0.0 to 1.0.
    @JsonKey(name: 'kind_confidence') double? kindConfidence,

    /// Nested OCR extraction result (if image was OCRed).
    ///
    /// When OCR is performed on this image, the result is embedded here.
    /// rather than in a separate collection, making the relationship explicit.
    @JsonKey(name: 'ocr_result') ExtractionResult? ocrResult,

    /// Page/slide number where image was found (1-indexed)
    @JsonKey(name: 'page_number') int? pageNumber,

    /// Original source path of the image within the document archive (e.g., "media/image1.png" in DOCX).
    /// Used for rendering image references when the binary data is not extracted.
    @JsonKey(name: 'source_path') String? sourcePath,

    /// Image width in pixels
    int? width,
  }) = _ExtractedImage;

  factory ExtractedImage.fromJson(Map<String, Object?> json) =>
      _$ExtractedImageFromJson(json);
}
