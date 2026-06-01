// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// Link type classification.
@JsonEnum()
enum LinkType {
  @JsonValue('anchor')
  anchor('anchor'),
  @JsonValue('internal')
  internal('internal'),
  /// The name has been replaced because it contains a keyword. Original name: `external`.
  @JsonValue('external')
  valueExternal('external'),
  @JsonValue('email')
  email('email'),
  @JsonValue('phone')
  phone('phone'),
  @JsonValue('other')
  other('other'),
  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const LinkType(this.json);

  factory LinkType.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
  String toJson() {
    final value = json;
    if (value == null) {
      throw StateError('Cannot convert enum value with null JSON representation to String. '
          'This usually happens for \$unknown or @JsonValue(null) entries.');
    }
    return value as String;
  }

  @override
  String toString() => json?.toString() ?? super.toString();
  /// Returns all defined enum values excluding the $unknown value.
  static List<LinkType> get $valuesDefined => values.where((value) => value != $unknown).toList();
}
