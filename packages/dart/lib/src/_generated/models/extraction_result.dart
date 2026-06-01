// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'archive_entry.dart';
import 'chunk.dart';
import 'djot_content.dart';
import 'document_revision.dart';
import 'document_structure.dart';
import 'element.dart';
import 'extracted_image.dart';
import 'extracted_uri.dart';
import 'extraction_method.dart';
import 'keyword.dart';
import 'llm_usage.dart';
import 'metadata.dart';
import 'ocr_element.dart';
import 'page_content.dart';
import 'pdf_annotation.dart';
import 'processing_warning.dart';
import 'table.dart';

part 'extraction_result.freezed.dart';
part 'extraction_result.g.dart';

/// General extraction result used by the core extraction API.
///
/// This is the main result type returned by all extraction functions.
@Freezed()
abstract class ExtractionResult with _$ExtractionResult {
  const factory ExtractionResult({
    required String content,
    required Metadata metadata,
    @JsonKey(name: 'mime_type') required String mimeType,
    required List<Table> tables,

    /// PDF annotations extracted from the document.
    ///
    /// When annotation extraction is enabled via `PdfConfig::extract_annotations`,.
    /// this field contains text notes, highlights, links, stamps, and other.
    /// annotations found in PDF documents.
    List<PdfAnnotation>? annotations,

    /// Nested extraction results from archive contents.
    ///
    /// When extracting archives, each processable file inside produces its own.
    /// full extraction result. Set to `None` for non-archive formats.
    /// Use `max_archive_depth` in config to control recursion depth.
    List<ArchiveEntry>? children,

    /// Text chunks when chunking is enabled.
    ///
    /// When chunking configuration is provided, the content is split into.
    /// overlapping chunks for efficient processing. Each chunk contains the text,.
    /// optional embeddings (if enabled), and metadata about its position.
    List<Chunk>? chunks,
    @JsonKey(name: 'detected_languages') List<String>? detectedLanguages,

    /// Rich Djot content structure (when extracting Djot documents).
    ///
    /// When extracting Djot documents with structured extraction enabled,.
    /// this field contains the full semantic structure including:.
    /// - Block-level elements with nesting.
    /// - Inline formatting with attributes.
    /// - Links, images, footnotes.
    /// - Math expressions.
    /// - Complete attribute information.
    ///
    /// The `content` field still contains plain text for backward compatibility.
    ///
    /// Always `None` for non-Djot documents.
    @JsonKey(name: 'djot_content') DjotContent? djotContent,

    /// Structured document tree (when document structure extraction is enabled).
    ///
    /// When `include_document_structure` is true in `ExtractionConfig`, this field.
    /// contains the full hierarchical representation of the document including:.
    /// - Heading-driven section nesting.
    /// - Table grids with cell-level metadata.
    /// - Content layer classification (body, header, footer, footnote).
    /// - Inline text annotations (formatting, links).
    /// - Bounding boxes and page numbers.
    ///
    /// Independent of `result_format` — can be combined with Unified or ElementBased.
    DocumentStructure? document,

    /// Semantic elements when element-based result format is enabled.
    ///
    /// When result_format is set to ElementBased, this field contains semantic.
    /// elements with type classification, unique identifiers, and metadata for.
    /// Unstructured-compatible element-based processing.
    List<Element>? elements,

    /// Extracted keywords when keyword extraction is enabled.
    ///
    /// When keyword extraction (RAKE or YAKE) is configured, this field contains.
    /// the extracted keywords with scores, algorithm info, and position data.
    /// Previously stored in `metadata.additional["keywords"]`.
    @JsonKey(name: 'extracted_keywords') List<Keyword>? extractedKeywords,

    /// Extraction strategy used to produce the returned text.
    ///
    /// Populated when the extractor can reliably distinguish native text extraction,.
    /// OCR-only extraction, or mixed native/OCR output.
    @JsonKey(name: 'extraction_method') ExtractionMethod? extractionMethod,

    /// Extracted images from the document.
    ///
    /// When image extraction is enabled via `ImageExtractionConfig`, this field.
    /// contains all images found in the document with their raw data and metadata.
    /// Each image may optionally contain a nested `ocr_result` if OCR was performed.
    List<ExtractedImage>? images,

    /// LLM token usage and cost data for all LLM calls made during this extraction.
    ///
    /// Contains one entry per LLM call. Multiple entries are produced when.
    /// VLM OCR, structured extraction, or LLM embeddings run during.
    /// the same extraction.
    ///
    /// `None` when no LLM was used.
    @JsonKey(name: 'llm_usage') List<LlmUsage>? llmUsage,

    /// OCR elements with full spatial and confidence metadata.
    ///
    /// When OCR is performed with element extraction enabled, this field contains.
    /// the structured representation of detected text including:.
    /// - Bounding geometry (rectangles or quadrilaterals).
    /// - Confidence scores (detection and recognition).
    /// - Rotation information.
    /// - Hierarchical relationships (Tesseract only).
    ///
    /// This field preserves all metadata that would otherwise be lost when.
    /// converting to plain text or markdown output formats.
    ///
    /// Only populated when `OcrElementConfig.include_elements` is true.
    @JsonKey(name: 'ocr_elements') List<OcrElement>? ocrElements,

    /// Per-page content when page extraction is enabled.
    ///
    /// When page extraction is configured, the document is split into per-page content.
    /// with tables and images mapped to their respective pages.
    List<PageContent>? pages,

    /// Non-fatal warnings collected during processing pipeline stages.
    ///
    /// Captures errors from optional pipeline features (embedding, chunking,.
    /// language detection, output formatting) that don't prevent extraction.
    /// but may indicate degraded results.
    /// Previously stored as individual keys in `metadata.additional`.
    @JsonKey(name: 'processing_warnings')
    List<ProcessingWarning>? processingWarnings,

    /// Document quality score from quality analysis.
    ///
    /// A value between 0.0 and 1.0 indicating the overall text quality.
    /// Previously stored in `metadata.additional["quality_score"]`.
    @JsonKey(name: 'quality_score') double? qualityScore,

    /// Tracked changes embedded in the source document.
    ///
    /// Populated by per-format extractors that understand change-tracking.
    /// metadata (DOCX `w:ins`/`w:del`/`w:rPrChange`, ODT `text:change-*`,.
    /// …). Every extractor defaults to `None` until its format-specific.
    /// implementation is added. Extractors that do populate this field follow.
    /// the "accepted-changes" convention: inserted text is present in.
    /// `content`, deleted text is absent — the revision list is the separate.
    /// audit trail.
    List<DocumentRevision>? revisions,

    /// Structured extraction output from LLM-based JSON schema extraction.
    ///
    /// When `structured_extraction` is configured in `ExtractionConfig`, the.
    /// extracted document content is sent to a VLM with the provided JSON schema.
    /// The response is parsed and stored here as a JSON value matching the schema.
    @JsonKey(name: 'structured_output') dynamic structuredOutput,

    /// URIs/links discovered during document extraction.
    ///
    /// Contains hyperlinks, image references, citations, email addresses, and.
    /// other URI-like references found in the document. Always extracted when.
    /// present in the source document.
    List<ExtractedUri>? uris,
  }) = _ExtractionResult;

  factory ExtractionResult.fromJson(Map<String, Object?> json) =>
      _$ExtractionResultFromJson(json);
}
