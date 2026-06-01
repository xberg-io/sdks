// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'cell_change.dart';
import 'diff_line.dart';

part 'revision_delta.freezed.dart';
part 'revision_delta.g.dart';

/// The content changes that make up a single revision.
///
/// For insertions and deletions the `content` field carries the added/removed.
/// lines as `DiffLine::Added` / `DiffLine::Removed` entries. For format.
/// changes, `content` is empty — the property diff is left as a TODO for a.
/// later enrichment pass.
@Freezed()
abstract class RevisionDelta with _$RevisionDelta {
  const factory RevisionDelta({
    /// Line-level content changes for this revision.
    required List<DiffLine> content,

    /// Cell-level table changes for this revision.
    @JsonKey(name: 'table_changes') required List<CellChange> tableChanges,
  }) = _RevisionDelta;

  factory RevisionDelta.fromJson(Map<String, Object?> json) =>
      _$RevisionDeltaFromJson(json);
}
