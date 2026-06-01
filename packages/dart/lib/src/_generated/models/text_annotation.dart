// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'annotation_kind.dart';

part 'text_annotation.freezed.dart';
part 'text_annotation.g.dart';

/// Inline text annotation — byte-range based formatting and links.
///
/// Annotations reference byte offsets into the node's text content,.
/// enabling precise identification of formatted regions.
@Freezed()
abstract class TextAnnotation with _$TextAnnotation {
  const factory TextAnnotation({
    /// End byte offset in the node's text content (exclusive).
    required int end,

    /// Annotation type.
    required AnnotationKind kind,

    /// Start byte offset in the node's text content (inclusive).
    required int start,
  }) = _TextAnnotation;
  
  factory TextAnnotation.fromJson(Map<String, Object?> json) => _$TextAnnotationFromJson(json);
}
