// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'heading_level.dart';

part 'heading_context.freezed.dart';
part 'heading_context.g.dart';

/// Heading context for a chunk within a Markdown document.
///
/// Contains the heading hierarchy from document root to this chunk's section.
@Freezed()
abstract class HeadingContext with _$HeadingContext {
  const factory HeadingContext({
    /// The heading hierarchy from document root to this chunk's section.
    /// Index 0 is the outermost (h1), last element is the most specific.
    required List<HeadingLevel> headings,
  }) = _HeadingContext;
  
  factory HeadingContext.fromJson(Map<String, Object?> json) => _$HeadingContextFromJson(json);
}
