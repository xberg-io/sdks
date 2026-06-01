// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'format_metadata.dart';

part 'text_metadata.freezed.dart';
part 'text_metadata.g.dart';

/// Text/Markdown metadata.
///
/// Extracted from plain text and Markdown files. Includes word counts and,.
/// for Markdown, structural elements like headers and links.
@Freezed()
abstract class TextMetadata with _$TextMetadata {
  const factory TextMetadata({
    /// Number of characters
    @JsonKey(name: 'character_count') required int characterCount,

    /// Number of lines in the document
    @JsonKey(name: 'line_count') required int lineCount,

    /// Number of words
    @JsonKey(name: 'word_count') required int wordCount,

    /// Code blocks as (language, code) tuples (for Markdown files)
    @JsonKey(name: 'code_blocks') List<List<String>>? codeBlocks,

    /// Markdown headers (headings text only, for Markdown files)
    List<String>? headers,

    /// Markdown links as (text, url) tuples (for Markdown files)
    List<List<String>>? links,
  }) = _TextMetadata;

  factory TextMetadata.fromJson(Map<String, Object?> json) =>
      _$TextMetadataFromJson(json);
}
