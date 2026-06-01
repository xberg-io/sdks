// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'cell_change.freezed.dart';
part 'cell_change.g.dart';

/// A single changed cell within a table.
///
/// Defined here (rather than only in `crate::diff`) so `RevisionDelta` can.
/// reference it unconditionally, without requiring the `diff` Cargo feature.
/// `crate::diff` re-exports this type verbatim.
@Freezed()
abstract class CellChange with _$CellChange {
  const factory CellChange({
    /// Zero-based column index.
    required int col,

    /// Value before the change.
    required String from,

    /// Zero-based row index.
    required int row,

    /// Value after the change.
    required String to,
  }) = _CellChange;

  factory CellChange.fromJson(Map<String, Object?> json) =>
      _$CellChangeFromJson(json);
}
