// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'attributes.dart';
import 'block_type.dart';
import 'formatted_block.dart';
import 'inline_element.dart';

part 'formatted_block.freezed.dart';
part 'formatted_block.g.dart';

/// Block-level element in a Djot document.
///
/// Represents structural elements like headings, paragraphs, lists, code blocks, etc.
@Freezed()
abstract class FormattedBlock with _$FormattedBlock {
  const factory FormattedBlock({
    /// Type of block element
    @JsonKey(name: 'block_type')
    required BlockType blockType,

    /// Inline content within the block
    @JsonKey(name: 'inline_content')
    required List<InlineElement> inlineContent,

    /// Element attributes (classes, IDs, key-value pairs)
    Attributes? attributes,

    /// Nested blocks for containers (blockquotes, list items, divs)
    List<FormattedBlock>? children,

    /// Raw code content for code blocks
    String? code,

    /// Language identifier for code blocks
    String? language,

    /// Heading level (1-6) for headings, or nesting level for lists
    int? level,
  }) = _FormattedBlock;
  
  factory FormattedBlock.fromJson(Map<String, Object?> json) => _$FormattedBlockFromJson(json);
}
