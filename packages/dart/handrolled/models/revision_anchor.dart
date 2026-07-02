// coverage:ignore-file
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'revision_anchor.freezed.dart';
part 'revision_anchor.g.dart';

/// Best-effort document location for a revision.
///
/// Discriminated by the `type` field. Hand-written to mirror the
/// [FormatMetadata] pattern because the upstream `oneOf` schema lacks an
/// explicit `discriminator` block.
@Freezed(unionKey: 'type')
sealed class RevisionAnchor with _$RevisionAnchor {
  /// Body paragraph, identified by its zero-based index in the document flow.
  const factory RevisionAnchor.paragraph({
    /// Zero-based index of the paragraph in document order.
    required int index,
  }) = RevisionAnchorParagraph;

  /// Cell inside a table.
  @FreezedUnionValue('table_cell')
  const factory RevisionAnchor.tableCell({
    /// Zero-based row index within the table.
    required int row,

    /// Zero-based column index within the table.
    required int col,

    /// Zero-based index of the table in document order.
    @JsonKey(name: 'table_index') required int tableIndex,
  }) = RevisionAnchorTableCell;

  /// Page, identified by its zero-based index.
  const factory RevisionAnchor.page({
    /// Zero-based page index.
    required int index,
  }) = RevisionAnchorPage;

  /// Presentation slide, identified by its zero-based index.
  const factory RevisionAnchor.slide({
    /// Zero-based slide index.
    required int index,
  }) = RevisionAnchorSlide;

  /// Spreadsheet cell or range, identified by sheet index and optional name.
  const factory RevisionAnchor.sheet({
    /// Zero-based sheet index.
    required int index,

    /// Sheet display name when available.
    String? name,
  }) = RevisionAnchorSheet;

  factory RevisionAnchor.fromJson(Map<String, Object?> json) =>
  _$RevisionAnchorFromJson(json);
}
