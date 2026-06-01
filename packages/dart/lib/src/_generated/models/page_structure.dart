// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'page_boundary.dart';
import 'page_info.dart';
import 'page_unit_type.dart';

part 'page_structure.freezed.dart';
part 'page_structure.g.dart';

/// Unified page structure for documents.
///
/// Supports different page types (PDF pages, PPTX slides, Excel sheets).
/// with character offset boundaries for chunk-to-page mapping.
@Freezed()
abstract class PageStructure with _$PageStructure {
  const factory PageStructure({
    /// Total number of pages/slides/sheets
    @JsonKey(name: 'total_count')
    required int totalCount,

    /// Type of paginated unit
    @JsonKey(name: 'unit_type')
    required PageUnitType unitType,

    /// Character offset boundaries for each page.
    ///
    /// Maps character ranges in the extracted content to page numbers.
    /// Used for chunk page range calculation.
    List<PageBoundary>? boundaries,

    /// Detailed per-page metadata (optional, only when needed)
    List<PageInfo>? pages,
  }) = _PageStructure;
  
  factory PageStructure.fromJson(Map<String, Object?> json) => _$PageStructureFromJson(json);
}
