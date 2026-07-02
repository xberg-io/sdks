// coverage:ignore-file
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'annotation_kind.freezed.dart';
part 'annotation_kind.g.dart';

/// Types of inline text annotations.
///
/// Discriminated by the `annotation_type` field. Variants are emitted by the
/// upstream OpenAPI spec as a `oneOf` without an explicit `discriminator`
/// block, so this union is hand-written to match the
/// [FormatMetadata] pattern (the only generated counterpart that works
/// end-to-end through `swagger_parser` + `freezed`).
@Freezed(unionKey: 'annotation_type')
sealed class AnnotationKind with _$AnnotationKind {
  const factory AnnotationKind.bold() = AnnotationKindBold;

  const factory AnnotationKind.italic() = AnnotationKindItalic;

  const factory AnnotationKind.underline() = AnnotationKindUnderline;

  const factory AnnotationKind.strikethrough() = AnnotationKindStrikethrough;

  const factory AnnotationKind.code() = AnnotationKindCode;

  const factory AnnotationKind.subscript() = AnnotationKindSubscript;

  const factory AnnotationKind.superscript() = AnnotationKindSuperscript;

  const factory AnnotationKind.link({required String url, String? title}) =
  AnnotationKindLink;

  /// Highlighted text (PDF highlights, HTML `<mark>`).
  const factory AnnotationKind.highlight() = AnnotationKindHighlight;

  /// Text color (CSS-compatible value, e.g. "#ff0000", "red").
  const factory AnnotationKind.color({required String value}) =
  AnnotationKindColor;

  /// Font size with units (e.g. "12pt", "1.2em", "16px").
  @FreezedUnionValue('font_size')
  const factory AnnotationKind.fontSize({required String value}) =
  AnnotationKindFontSize;

  /// Extensible annotation for format-specific styling.
  const factory AnnotationKind.custom({required String name, String? value}) =
  AnnotationKindCustom;

  factory AnnotationKind.fromJson(Map<String, Object?> json) =>
  _$AnnotationKindFromJson(json);
}
