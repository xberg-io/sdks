// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'formatted_block.dart';

part 'footnote.freezed.dart';
part 'footnote.g.dart';

/// Footnote in Djot.
@Freezed()
abstract class Footnote with _$Footnote {
  const factory Footnote({
    /// Footnote content blocks
    required List<FormattedBlock> content,

    /// Footnote label
    required String label,
  }) = _Footnote;

  factory Footnote.fromJson(Map<String, Object?> json) =>
      _$FootnoteFromJson(json);
}
