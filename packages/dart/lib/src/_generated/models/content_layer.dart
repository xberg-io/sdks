// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// Content layer classification for document nodes.
///
/// Replaces separate body/furniture arrays with per-node granularity.
@JsonEnum()
enum ContentLayer {
  @JsonValue('body')
  body('body'),
  @JsonValue('header')
  header('header'),
  @JsonValue('footer')
  footer('footer'),
  @JsonValue('footnote')
  footnote('footnote'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const ContentLayer(this.json);

  factory ContentLayer.fromJson(String json) =>
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
  static List<ContentLayer> get $valuesDefined =>
      values.where((value) => value != $unknown).toList();
}
