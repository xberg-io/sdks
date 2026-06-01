// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'layout_region.dart';
import 'page_hierarchy.dart';
import 'table.dart';

part 'page_content.freezed.dart';
part 'page_content.g.dart';

/// Content for a single page/slide.
///
/// When page extraction is enabled, documents are split into per-page content.
/// with associated tables and images mapped to each page.
///
/// # Performance.
///
/// Uses Arc-wrapped tables and images for memory efficiency:.
/// - `Vec<Arc<Table>>` enables zero-copy sharing of table data.
/// - `Vec<Arc<ExtractedImage>>` enables zero-copy sharing of image data.
/// - Maintains exact JSON compatibility via custom Serialize/Deserialize.
///
/// This reduces memory overhead for documents with shared tables/images.
/// by avoiding redundant copies during serialization.
@Freezed()
abstract class PageContent with _$PageContent {
  const factory PageContent({
    /// Text content for this page
    required String content,

    /// Page number (1-indexed)
    @JsonKey(name: 'page_number') required int pageNumber,

    /// Hierarchy information for the page (when hierarchy extraction is enabled).
    ///
    /// Contains text hierarchy levels (H1-H6) extracted from the page content.
    PageHierarchy? hierarchy,

    /// Indices into `ExtractionResult.images` for images found on this page.
    ///
    /// Each value is a zero-based index into the top-level `images` collection.
    /// Only populated when `extract_images = true` in the extraction config.
    @JsonKey(name: 'image_indices') List<int>? imageIndices,

    /// Whether this page is blank (no meaningful text content).
    ///
    /// Determined during extraction based on text content analysis.
    /// A page is blank if it has fewer than 3 non-whitespace characters.
    /// and contains no tables or images.
    @JsonKey(name: 'is_blank') bool? isBlank,

    /// Layout detection regions for this page (when layout detection is enabled).
    ///
    /// Contains detected layout regions with class, confidence, bounding box,.
    /// and area fraction. Only populated when layout detection is configured.
    @JsonKey(name: 'layout_regions') List<LayoutRegion>? layoutRegions,

    /// Section name this slide belongs to (PPTX only).
    ///
    /// PowerPoint sections group slides into logical chapters (`<p:sectionLst>` in.
    /// `ppt/presentation.xml`). Only populated when the source is a PPTX file and.
    /// the slide belongs to a named section.
    @JsonKey(name: 'section_name') String? sectionName,

    /// Sheet name for this page (XLSX/ODS only).
    ///
    /// Each spreadsheet sheet maps to one `PageContent` entry. This field carries the.
    /// sheet's display name as it appears in the workbook. `None` for all non-spreadsheet.
    /// formats and for sheets with an empty name.
    @JsonKey(name: 'sheet_name') String? sheetName,

    /// Speaker notes for this slide (PPTX only).
    ///
    /// Contains the text from the slide's notes pane (`ppt/notesSlides/notesSlide{N}.xml`).
    /// Only populated when the source is a PPTX file and notes are present.
    @JsonKey(name: 'speaker_notes') String? speakerNotes,

    /// Tables found on this page (uses Arc for memory efficiency).
    ///
    /// Serializes as Vec<Table> for JSON compatibility while maintaining.
    /// Arc semantics in-memory for zero-copy sharing.
    List<Table>? tables,
  }) = _PageContent;

  factory PageContent.fromJson(Map<String, Object?> json) =>
      _$PageContentFromJson(json);
}
