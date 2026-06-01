// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'attributes.freezed.dart';
part 'attributes.g.dart';

/// Element attributes in Djot.
///
/// Represents the attributes attached to elements using {.class #id key="value"} syntax.
@Freezed()
abstract class Attributes with _$Attributes {
  const factory Attributes({
    /// CSS classes (.class1 .class2)
    List<String>? classes,

    /// Element ID (#identifier)
    String? id,

    /// Key-value pairs (key="value")
    @JsonKey(name: 'key_values')
    List<List<String>>? keyValues,
  }) = _Attributes;
  
  factory Attributes.fromJson(Map<String, Object?> json) => _$AttributesFromJson(json);
}
