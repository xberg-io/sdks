// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// Types of inline elements in Djot.
@JsonEnum()
enum InlineType {
  @JsonValue('text')
  text('text'),
  @JsonValue('strong')
  strong('strong'),
  @JsonValue('emphasis')
  emphasis('emphasis'),
  @JsonValue('highlight')
  highlight('highlight'),
  @JsonValue('subscript')
  subscript('subscript'),
  @JsonValue('superscript')
  superscript('superscript'),
  @JsonValue('insert')
  insert('insert'),
  @JsonValue('delete')
  delete('delete'),
  @JsonValue('code')
  code('code'),
  @JsonValue('link')
  link('link'),
  @JsonValue('image')
  image('image'),
  @JsonValue('span')
  span('span'),
  @JsonValue('math')
  math('math'),
  @JsonValue('raw_inline')
  rawInline('raw_inline'),
  @JsonValue('footnote_ref')
  footnoteRef('footnote_ref'),
  @JsonValue('symbol')
  symbol('symbol'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const InlineType(this.json);

  factory InlineType.fromJson(String json) =>
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
  static List<InlineType> get $valuesDefined =>
      values.where((value) => value != $unknown).toList();
}
