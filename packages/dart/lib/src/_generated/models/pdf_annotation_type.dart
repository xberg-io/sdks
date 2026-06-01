// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// Type of PDF annotation.
@JsonEnum()
enum PdfAnnotationType {
  @JsonValue('text')
  text('text'),
  @JsonValue('highlight')
  highlight('highlight'),
  @JsonValue('link')
  link('link'),
  @JsonValue('stamp')
  stamp('stamp'),
  @JsonValue('underline')
  underline('underline'),
  @JsonValue('strike_out')
  strikeOut('strike_out'),
  @JsonValue('other')
  other('other'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const PdfAnnotationType(this.json);

  factory PdfAnnotationType.fromJson(String json) =>
      values.firstWhere((e) => e.json == json, orElse: () => $unknown);

  final String? json;
  String toJson() {
    final value = json;
    if (value == null) {
      throw StateError(
        'Cannot convert enum value with null JSON representation to String. '
        'This usually happens for \$unknown or @JsonValue(null) entries.',
      );
    }
    return value as String;
  }

  @override
  String toString() => json?.toString() ?? super.toString();

  /// Returns all defined enum values excluding the $unknown value.
  static List<PdfAnnotationType> get $valuesDefined =>
      values.where((value) => value != $unknown).toList();
}
