// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'djot_image.dart';
import 'djot_link.dart';
import 'footnote.dart';
import 'formatted_block.dart';
import 'metadata.dart';
import 'table.dart';

part 'djot_content.freezed.dart';
part 'djot_content.g.dart';

/// Comprehensive Djot document structure with semantic preservation.
///
/// This type captures the full richness of Djot markup, including:.
/// - Block-level structures (headings, lists, blockquotes, code blocks, etc.).
/// - Inline formatting (emphasis, strong, highlight, subscript, superscript, etc.).
/// - Attributes (classes, IDs, key-value pairs).
/// - Links, images, footnotes.
/// - Math expressions (inline and display).
/// - Tables with full structure.
///
/// Available when the `djot` feature is enabled.
@Freezed()
abstract class DjotContent with _$DjotContent {
  const factory DjotContent({
    /// Structured block-level content
    required List<FormattedBlock> blocks,

    /// Footnote definitions
    required List<Footnote> footnotes,

    /// Extracted images with metadata
    required List<DjotImage> images,

    /// Extracted links with URLs
    required List<DjotLink> links,

    /// Metadata from YAML frontmatter
    required Metadata metadata,

    /// Plain text representation for backwards compatibility
    @JsonKey(name: 'plain_text')
    required String plainText,

    /// Extracted tables as structured data
    required List<Table> tables,

    /// Attributes mapped by element identifier (if present)
    dynamic attributes,
  }) = _DjotContent;
  
  factory DjotContent.fromJson(Map<String, Object?> json) => _$DjotContentFromJson(json);
}
