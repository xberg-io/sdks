// coverage:ignore-file
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'diff_line.freezed.dart';
part 'diff_line.g.dart';

/// A single line in a revision diff.
///
/// Discriminated by the `kind` field. Hand-written to mirror the
/// [FormatMetadata] pattern because the upstream `oneOf` schema lacks an
/// explicit `discriminator` block.
@Freezed(unionKey: 'kind')
sealed class DiffLine with _$DiffLine {
  /// Unchanged context line.
  const factory DiffLine.context({required String text}) = DiffLineContext;

  /// Line added in the "after" version.
  const factory DiffLine.added({required String text}) = DiffLineAdded;

  /// Line removed from the "before" version.
  const factory DiffLine.removed({required String text}) = DiffLineRemoved;

  factory DiffLine.fromJson(Map<String, Object?> json) =>
  _$DiffLineFromJson(json);
}
