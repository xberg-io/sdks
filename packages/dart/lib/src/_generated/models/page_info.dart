// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_info.freezed.dart';
part 'page_info.g.dart';

/// Metadata for individual page/slide/sheet.
///
/// Captures per-page information including dimensions, content counts,.
/// and visibility state (for presentations).
@Freezed()
abstract class PageInfo with _$PageInfo {
  const factory PageInfo({
    /// Page number (1-indexed)
    required int number,

    /// Dimensions in points (PDF) or pixels (images): (width, height)
    List<double>? dimensions,

    /// Whether this page contains non-trivial vector graphics (paths, shapes, curves).
    ///
    /// Indicates the presence of vector-drawn content such as charts, diagrams,.
    /// or geometric shapes (e.g., from Adobe InDesign, LaTeX TikZ). These are.
    /// invisible to `ExtractionResult.images` since they are not embedded as raster.
    /// XObjects. Set to `true` when path count exceeds a heuristic threshold,.
    /// signaling that downstream consumers may want to rasterize the page to.
    /// capture this content.
    ///
    /// Only populated for PDFs; `None` for other document types.
    @JsonKey(name: 'has_vector_graphics')
    bool? hasVectorGraphics,

    /// Whether this page is hidden (e.g., in presentations)
    bool? hidden,

    /// Number of images on this page
    @JsonKey(name: 'image_count')
    int? imageCount,

    /// Whether this page is blank (no meaningful text, no images, no tables).
    ///
    /// A page is considered blank if it has fewer than 3 non-whitespace characters.
    /// and contains no tables or images. This is useful for filtering out empty pages.
    /// in scanned documents or PDFs with blank separator pages.
    @JsonKey(name: 'is_blank')
    bool? isBlank,

    /// Number of tables on this page
    @JsonKey(name: 'table_count')
    int? tableCount,

    /// Page title (usually for presentations)
    String? title,
  }) = _PageInfo;
  
  factory PageInfo.fromJson(Map<String, Object?> json) => _$PageInfoFromJson(json);
}
