// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'bounding_box.dart';
import 'row.dart';

part 'table.freezed.dart';
part 'table.g.dart';

/// Extracted table.
@Freezed()
abstract class Table with _$Table {
  const factory Table({
    /// Bounding box on the page
    @JsonKey(name: 'bounding_box')
    BoundingBox? boundingBox,

    /// 2D grid of cells (rows of string values)
    List<Row>? cells,

    /// Markdown representation of the table
    String? markdown,

    /// Page number (0-indexed)
    @JsonKey(name: 'page_number')
    int? pageNumber,
  }) = _Table;
  
  factory Table.fromJson(Map<String, Object?> json) => _$TableFromJson(json);
}
