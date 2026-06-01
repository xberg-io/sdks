// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'bounding_box.dart';

part 'grid_cell.freezed.dart';
part 'grid_cell.g.dart';

/// Individual grid cell with position and span metadata.
@Freezed()
abstract class GridCell with _$GridCell {
  const factory GridCell({
    /// Zero-indexed column position.
    required int col,

    /// Cell text content.
    required String content,

    /// Zero-indexed row position.
    required int row,

    /// Bounding box for this cell (if available).
    BoundingBox? bbox,

    /// Number of columns this cell spans.
    @JsonKey(name: 'col_span') int? colSpan,

    /// Whether this is a header cell.
    @JsonKey(name: 'is_header') bool? isHeader,

    /// Number of rows this cell spans.
    @JsonKey(name: 'row_span') int? rowSpan,
  }) = _GridCell;

  factory GridCell.fromJson(Map<String, Object?> json) =>
      _$GridCellFromJson(json);
}
