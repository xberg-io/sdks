// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'bounding_box.dart';

part 'table.freezed.dart';
part 'table.g.dart';

/// Extracted table structure.
///
/// Represents a table detected and extracted from a document (PDF, image, etc.).
/// Tables are converted to both structured cell data and Markdown format.
@Freezed()
abstract class Table with _$Table {
  const factory Table({
    /// Table cells as a 2D vector (rows × columns)
    required List<List<String>> cells,

    /// Markdown representation of the table
    required String markdown,

    /// Page number where the table was found (1-indexed)
    @JsonKey(name: 'page_number')
    required int pageNumber,

    /// Bounding box of the table on the page (PDF coordinates: x0=left, y0=bottom, x1=right, y1=top).
    /// Only populated for PDF-extracted tables when position data is available.
    @JsonKey(name: 'bounding_box')
    BoundingBox? boundingBox,
  }) = _Table;
  
  factory Table.fromJson(Map<String, Object?> json) => _$TableFromJson(json);
}
