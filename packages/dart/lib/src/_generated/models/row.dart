// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'row.freezed.dart';
part 'row.g.dart';

/// Table row — a list of cell string values.
///
/// Kreuzberg serializes cells as a nested array (each row is `["A", "B"]`).
/// This type accepts both array and object formats via a custom deserializer.
@Freezed()
abstract class Row with _$Row {
  const factory Row({
    required List<String> values,
  }) = _Row;
  
  factory Row.fromJson(Map<String, Object?> json) => _$RowFromJson(json);
}
