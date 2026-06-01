// coverage:ignore-file
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'table_grid.dart';

part 'node_content.freezed.dart';
part 'node_content.g.dart';

/// Tagged enum for node content. Each variant carries only type-specific data.
///
/// Uses `node_type` as the discriminator (matches the Rust
/// `#[serde(tag = "node_type")]` attribute). Hand-written to mirror the
/// [FormatMetadata] pattern because the upstream `oneOf` schema lacks an
/// explicit `discriminator` block.
@Freezed(unionKey: 'node_type')
sealed class NodeContent with _$NodeContent {
  /// Document title.
  const factory NodeContent.title({
    required String text,
  }) = NodeContentTitle;

  /// Section heading with level (1-6).
  const factory NodeContent.heading({
    required int level,
    required String text,
  }) = NodeContentHeading;

  /// Body text paragraph.
  const factory NodeContent.paragraph({
    required String text,
  }) = NodeContentParagraph;

  /// List container — children are `ListItem` nodes.
  const factory NodeContent.list({
    required bool ordered,
  }) = NodeContentList;

  /// Individual list item.
  @FreezedUnionValue('list_item')
  const factory NodeContent.listItem({
    required String text,
  }) = NodeContentListItem;

  /// Table with structured cell grid.
  const factory NodeContent.table({
    required TableGrid grid,
  }) = NodeContentTable;

  /// Image reference.
  const factory NodeContent.image({
    String? description,
    @JsonKey(name: 'image_index') int? imageIndex,

    /// Source URL or path of the image (from `<img src="...">` or `![](src)`).
    String? src,
  }) = NodeContentImage;

  /// Code block.
  const factory NodeContent.code({
    required String text,
    String? language,
  }) = NodeContentCode;

  /// Block quote — container, children carry the quoted content.
  const factory NodeContent.quote() = NodeContentQuote;

  /// Mathematical formula / equation.
  const factory NodeContent.formula({
    required String text,
  }) = NodeContentFormula;

  /// Footnote reference content.
  const factory NodeContent.footnote({
    required String text,
  }) = NodeContentFootnote;

  /// Logical grouping container (section, key-value area).
  ///
  /// `heading_level` + `heading_text` capture the section heading directly
  /// rather than relying on a first-child positional convention.
  const factory NodeContent.group({
    @JsonKey(name: 'heading_level') int? headingLevel,
    @JsonKey(name: 'heading_text') String? headingText,
    String? label,
  }) = NodeContentGroup;

  /// Page break marker.
  @FreezedUnionValue('page_break')
  const factory NodeContent.pageBreak() = NodeContentPageBreak;

  /// Presentation slide container — children are the slide's content nodes.
  const factory NodeContent.slide({
    /// 1-indexed slide number.
    required int number,
    String? title,
  }) = NodeContentSlide;

  /// Definition list container — children are `DefinitionItem` nodes.
  @FreezedUnionValue('definition_list')
  const factory NodeContent.definitionList() = NodeContentDefinitionList;

  /// Individual definition list entry with term and definition.
  @FreezedUnionValue('definition_item')
  const factory NodeContent.definitionItem({
    required String term,
    required String definition,
  }) = NodeContentDefinitionItem;

  /// Citation or bibliographic reference.
  const factory NodeContent.citation({
    required String key,
    required String text,
  }) = NodeContentCitation;

  /// Admonition / callout container (note, warning, tip, etc.).
  ///
  /// Children carry the admonition body content.
  const factory NodeContent.admonition({
    /// Kind of admonition (e.g. "note", "warning", "tip", "danger").
    required String kind,
    String? title,
  }) = NodeContentAdmonition;

  /// Raw block preserved verbatim from the source format.
  ///
  /// Used for content that cannot be mapped to a semantic node type
  /// (e.g. JSX in MDX, raw LaTeX in markdown, embedded HTML).
  @FreezedUnionValue('raw_block')
  const factory NodeContent.rawBlock({
    /// Source format identifier (e.g. "html", "latex", "jsx").
    required String format,
    required String content,
  }) = NodeContentRawBlock;

  /// Structured metadata block (email headers, YAML frontmatter, etc.).
  @FreezedUnionValue('metadata_block')
  const factory NodeContent.metadataBlock({
    required List<List<String>> entries,
  }) = NodeContentMetadataBlock;

  factory NodeContent.fromJson(Map<String, Object?> json) =>
      _$NodeContentFromJson(json);
}
