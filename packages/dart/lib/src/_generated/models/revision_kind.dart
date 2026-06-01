// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// Semantic classification of a tracked change.
@JsonEnum()
enum RevisionKind {
  @JsonValue('insertion')
  insertion('insertion'),
  @JsonValue('deletion')
  deletion('deletion'),
  @JsonValue('format_change')
  formatChange('format_change'),
  @JsonValue('comment')
  comment('comment'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const RevisionKind(this.json);

  factory RevisionKind.fromJson(String json) =>
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
  static List<RevisionKind> get $valuesDefined =>
      values.where((value) => value != $unknown).toList();
}
