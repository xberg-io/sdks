// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'grid_cell.dart';

part 'table_grid.freezed.dart';
part 'table_grid.g.dart';

/// Structured table grid with cell-level metadata.
///
/// Stores row/column dimensions and a flat list of cells with position info.
@Freezed()
abstract class TableGrid with _$TableGrid {
  const factory TableGrid({
    /// All cells in row-major order.
    required List<GridCell> cells,

    /// Number of columns in the table.
    required int cols,

    /// Number of rows in the table.
    required int rows,
  }) = _TableGrid;

  factory TableGrid.fromJson(Map<String, Object?> json) =>
      _$TableGridFromJson(json);
}
