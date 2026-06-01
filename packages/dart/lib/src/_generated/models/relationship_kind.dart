// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// Semantic kind of a relationship between document elements.
@JsonEnum()
enum RelationshipKind {
  @JsonValue('footnote_reference')
  footnoteReference('footnote_reference'),
  @JsonValue('citation_reference')
  citationReference('citation_reference'),
  @JsonValue('internal_link')
  internalLink('internal_link'),
  @JsonValue('caption')
  caption('caption'),
  @JsonValue('label')
  label('label'),
  @JsonValue('toc_entry')
  tocEntry('toc_entry'),
  @JsonValue('cross_reference')
  crossReference('cross_reference'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const RelationshipKind(this.json);

  factory RelationshipKind.fromJson(String json) =>
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
  static List<RelationshipKind> get $valuesDefined =>
      values.where((value) => value != $unknown).toList();
}
