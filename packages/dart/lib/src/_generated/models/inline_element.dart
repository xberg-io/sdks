// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'attributes.dart';
import 'inline_type.dart';

part 'inline_element.freezed.dart';
part 'inline_element.g.dart';

/// Inline element within a block.
///
/// Represents text with formatting, links, images, etc.
@Freezed()
abstract class InlineElement with _$InlineElement {
  const factory InlineElement({
    /// Text content
    required String content,

    /// Type of inline element
    @JsonKey(name: 'element_type')
    required InlineType elementType,

    /// Element attributes
    Attributes? attributes,

    /// Additional metadata (e.g., href for links, src/alt for images)
    Map<String, String>? metadata,
  }) = _InlineElement;
  
  factory InlineElement.fromJson(Map<String, Object?> json) => _$InlineElementFromJson(json);
}
