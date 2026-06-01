// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'archive_metadata.dart';
import 'csv_metadata.dart';
import 'email_metadata.dart';
import 'excel_metadata.dart';
import 'header_metadata.dart';
import 'html_metadata.dart';
import 'image_metadata.dart';
import 'image_metadata_type.dart';
import 'link_metadata.dart';
import 'ocr_metadata.dart';
import 'pptx_metadata.dart';
import 'pst_metadata.dart';
import 'structured_data.dart';
import 'text_direction.dart';
import 'text_metadata.dart';
import 'xml_metadata.dart';

part 'format_metadata.freezed.dart';
part 'format_metadata.g.dart';

/// Format-specific metadata (discriminated union). Only one format type can exist per extraction result.
@Freezed(unionKey: 'format_type')
sealed class FormatMetadata with _$FormatMetadata {
  @FreezedUnionValue('archive')
  const factory FormatMetadata.archive({
    /// Total number of files in the archive
    @JsonKey(name: 'file_count')
    required int fileCount,

    /// List of file paths within the archive
    @JsonKey(name: 'file_list')
    required List<String> fileList,

    /// Archive format ("ZIP", "TAR", "7Z", etc.)
    required String format,

    /// Total uncompressed size in bytes
    @JsonKey(name: 'total_size')
    required int totalSize,

    /// Compressed size in bytes (if available)
    @JsonKey(name: 'compressed_size')
    int? compressedSize,
  }) = FormatMetadataArchive;

  @FreezedUnionValue('csv')
  const factory FormatMetadata.csv({
    @JsonKey(name: 'column_count')
    required int columnCount,
    @JsonKey(name: 'has_header')
    required bool hasHeader,
    @JsonKey(name: 'row_count')
    required int rowCount,
    @JsonKey(name: 'column_types')
    List<String>? columnTypes,
    String? delimiter,
  }) = FormatMetadataCsv;

  @FreezedUnionValue('email')
  const factory FormatMetadata.email({
    /// List of attachment filenames
    required List<String> attachments,

    /// BCC recipients
    @JsonKey(name: 'bcc_emails')
    required List<String> bccEmails,

    /// CC recipients
    @JsonKey(name: 'cc_emails')
    required List<String> ccEmails,

    /// Primary recipients
    @JsonKey(name: 'to_emails')
    required List<String> toEmails,

    /// Sender's email address
    @JsonKey(name: 'from_email')
    String? fromEmail,

    /// Sender's display name
    @JsonKey(name: 'from_name')
    String? fromName,

    /// Message-ID header value
    @JsonKey(name: 'message_id')
    String? messageId,
  }) = FormatMetadataEmail;

  @FreezedUnionValue('excel')
  const factory FormatMetadata.excel({
    /// Number of sheets in the workbook.
    @JsonKey(name: 'sheet_count')
    int? sheetCount,

    /// Names of all sheets in the workbook.
    @JsonKey(name: 'sheet_names')
    List<String>? sheetNames,
  }) = FormatMetadataExcel;

  @FreezedUnionValue('html')
  const factory FormatMetadata.html({
    /// Document author from `<meta name="author">` tag
    String? author,

    /// Base URL from `<base href="">` tag for resolving relative URLs
    @JsonKey(name: 'base_href')
    String? baseHref,

    /// Canonical URL from `<link rel="canonical">` tag
    @JsonKey(name: 'canonical_url')
    String? canonicalUrl,

    /// Document description from `<meta name="description">` tag
    String? description,

    /// Extracted header elements with hierarchy
    List<HeaderMetadata>? headers,

    /// Extracted images with source and dimensions
    List<ImageMetadataType>? images,

    /// Document keywords from `<meta name="keywords">` tag, split on commas
    List<String>? keywords,

    /// Document language from `lang` attribute
    String? language,

    /// Extracted hyperlinks with type classification
    List<LinkMetadata>? links,

    /// Additional meta tags not covered by specific fields.
    /// Keys are meta name/property attributes, values are content.
    @JsonKey(name: 'meta_tags')
    Map<String, String>? metaTags,

    /// Open Graph metadata (og:* properties) for social media.
    /// Keys like "title", "description", "image", "url", etc.
    @JsonKey(name: 'open_graph')
    Map<String, String>? openGraph,

    /// Extracted structured data blocks
    @JsonKey(name: 'structured_data')
    List<StructuredData>? structuredData,

    /// Document text direction from `dir` attribute
    @JsonKey(name: 'text_direction')
    TextDirection? textDirection,

    /// Document title from `<title>` tag
    String? title,

    /// Twitter Card metadata (twitter:* properties).
    /// Keys like "card", "site", "creator", "title", "description", "image", etc.
    @JsonKey(name: 'twitter_card')
    Map<String, String>? twitterCard,
  }) = FormatMetadataHtml;

  @FreezedUnionValue('image')
  const factory FormatMetadata.image({
    /// EXIF metadata tags
    required Map<String, String> exif,

    /// Image format (e.g., "PNG", "JPEG", "TIFF")
    required String format,

    /// Image height in pixels
    required int height,

    /// Image width in pixels
    required int width,
  }) = FormatMetadataImage;

  @FreezedUnionValue('ocr')
  const factory FormatMetadata.ocr({
    /// OCR language code(s) used
    required String language,

    /// Output format (e.g., "text", "hocr")
    @JsonKey(name: 'output_format')
    required String outputFormat,

    /// Tesseract Page Segmentation Mode (PSM)
    required int psm,

    /// Number of tables detected
    @JsonKey(name: 'table_count')
    required int tableCount,
    @JsonKey(name: 'table_cols')
    int? tableCols,
    @JsonKey(name: 'table_rows')
    int? tableRows,
  }) = FormatMetadataOcr;

  @FreezedUnionValue('pptx')
  const factory FormatMetadata.pptx({
    /// Total number of slides in the presentation
    @JsonKey(name: 'slide_count')
    required int slideCount,

    /// Names of slides (if available)
    @JsonKey(name: 'slide_names')
    required List<String> slideNames,

    /// Number of embedded images
    @JsonKey(name: 'image_count')
    int? imageCount,

    /// Number of tables
    @JsonKey(name: 'table_count')
    int? tableCount,
  }) = FormatMetadataPptx;

  @FreezedUnionValue('pst')
  const factory FormatMetadata.pst({
    @JsonKey(name: 'message_count')
    required int messageCount,
  }) = FormatMetadataPst;

  @FreezedUnionValue('text')
  const factory FormatMetadata.text({
    /// Number of characters
    @JsonKey(name: 'character_count')
    required int characterCount,

    /// Number of lines in the document
    @JsonKey(name: 'line_count')
    required int lineCount,

    /// Number of words
    @JsonKey(name: 'word_count')
    required int wordCount,

    /// Code blocks as (language, code) tuples (for Markdown files)
    @JsonKey(name: 'code_blocks')
    List<List<String>>? codeBlocks,

    /// Markdown headers (headings text only, for Markdown files)
    List<String>? headers,

    /// Markdown links as (text, url) tuples (for Markdown files)
    List<List<String>>? links,
  }) = FormatMetadataText;

  @FreezedUnionValue('xml')
  const factory FormatMetadata.xml({
    /// Total number of XML elements processed
    @JsonKey(name: 'element_count')
    required int elementCount,

    /// List of unique element tag names (sorted)
    @JsonKey(name: 'unique_elements')
    required List<String> uniqueElements,
  }) = FormatMetadataXml;

  
  factory FormatMetadata.fromJson(Map<String, Object?> json) => _$FormatMetadataFromJson(json);
}
