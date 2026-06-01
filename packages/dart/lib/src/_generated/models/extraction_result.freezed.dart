// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'extraction_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExtractionResult {

 String get content; Metadata get metadata;@JsonKey(name: 'mime_type') String get mimeType; List<Table> get tables;/// PDF annotations extracted from the document.
///
/// When annotation extraction is enabled via `PdfConfig::extract_annotations`,.
/// this field contains text notes, highlights, links, stamps, and other.
/// annotations found in PDF documents.
 List<PdfAnnotation>? get annotations;/// Nested extraction results from archive contents.
///
/// When extracting archives, each processable file inside produces its own.
/// full extraction result. Set to `None` for non-archive formats.
/// Use `max_archive_depth` in config to control recursion depth.
 List<ArchiveEntry>? get children;/// Text chunks when chunking is enabled.
///
/// When chunking configuration is provided, the content is split into.
/// overlapping chunks for efficient processing. Each chunk contains the text,.
/// optional embeddings (if enabled), and metadata about its position.
 List<Chunk>? get chunks;@JsonKey(name: 'detected_languages') List<String>? get detectedLanguages;/// Rich Djot content structure (when extracting Djot documents).
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
@JsonKey(name: 'djot_content') DjotContent? get djotContent;/// Structured document tree (when document structure extraction is enabled).
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
 DocumentStructure? get document;/// Semantic elements when element-based result format is enabled.
///
/// When result_format is set to ElementBased, this field contains semantic.
/// elements with type classification, unique identifiers, and metadata for.
/// Unstructured-compatible element-based processing.
 List<Element>? get elements;/// Extracted keywords when keyword extraction is enabled.
///
/// When keyword extraction (RAKE or YAKE) is configured, this field contains.
/// the extracted keywords with scores, algorithm info, and position data.
/// Previously stored in `metadata.additional["keywords"]`.
@JsonKey(name: 'extracted_keywords') List<Keyword>? get extractedKeywords;/// Extraction strategy used to produce the returned text.
///
/// Populated when the extractor can reliably distinguish native text extraction,.
/// OCR-only extraction, or mixed native/OCR output.
@JsonKey(name: 'extraction_method') ExtractionMethod? get extractionMethod;/// Extracted images from the document.
///
/// When image extraction is enabled via `ImageExtractionConfig`, this field.
/// contains all images found in the document with their raw data and metadata.
/// Each image may optionally contain a nested `ocr_result` if OCR was performed.
 List<ExtractedImage>? get images;/// LLM token usage and cost data for all LLM calls made during this extraction.
///
/// Contains one entry per LLM call. Multiple entries are produced when.
/// VLM OCR, structured extraction, or LLM embeddings run during.
/// the same extraction.
///
/// `None` when no LLM was used.
@JsonKey(name: 'llm_usage') List<LlmUsage>? get llmUsage;/// OCR elements with full spatial and confidence metadata.
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
@JsonKey(name: 'ocr_elements') List<OcrElement>? get ocrElements;/// Per-page content when page extraction is enabled.
///
/// When page extraction is configured, the document is split into per-page content.
/// with tables and images mapped to their respective pages.
 List<PageContent>? get pages;/// Non-fatal warnings collected during processing pipeline stages.
///
/// Captures errors from optional pipeline features (embedding, chunking,.
/// language detection, output formatting) that don't prevent extraction.
/// but may indicate degraded results.
/// Previously stored as individual keys in `metadata.additional`.
@JsonKey(name: 'processing_warnings') List<ProcessingWarning>? get processingWarnings;/// Document quality score from quality analysis.
///
/// A value between 0.0 and 1.0 indicating the overall text quality.
/// Previously stored in `metadata.additional["quality_score"]`.
@JsonKey(name: 'quality_score') double? get qualityScore;/// Tracked changes embedded in the source document.
///
/// Populated by per-format extractors that understand change-tracking.
/// metadata (DOCX `w:ins`/`w:del`/`w:rPrChange`, ODT `text:change-*`,.
/// …). Every extractor defaults to `None` until its format-specific.
/// implementation is added. Extractors that do populate this field follow.
/// the "accepted-changes" convention: inserted text is present in.
/// `content`, deleted text is absent — the revision list is the separate.
/// audit trail.
 List<DocumentRevision>? get revisions;/// Structured extraction output from LLM-based JSON schema extraction.
///
/// When `structured_extraction` is configured in `ExtractionConfig`, the.
/// extracted document content is sent to a VLM with the provided JSON schema.
/// The response is parsed and stored here as a JSON value matching the schema.
@JsonKey(name: 'structured_output') dynamic get structuredOutput;/// URIs/links discovered during document extraction.
///
/// Contains hyperlinks, image references, citations, email addresses, and.
/// other URI-like references found in the document. Always extracted when.
/// present in the source document.
 List<ExtractedUri>? get uris;
/// Create a copy of ExtractionResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExtractionResultCopyWith<ExtractionResult> get copyWith => _$ExtractionResultCopyWithImpl<ExtractionResult>(this as ExtractionResult, _$identity);

  /// Serializes this ExtractionResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExtractionResult&&(identical(other.content, content) || other.content == content)&&(identical(other.metadata, metadata) || other.metadata == metadata)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&const DeepCollectionEquality().equals(other.tables, tables)&&const DeepCollectionEquality().equals(other.annotations, annotations)&&const DeepCollectionEquality().equals(other.children, children)&&const DeepCollectionEquality().equals(other.chunks, chunks)&&const DeepCollectionEquality().equals(other.detectedLanguages, detectedLanguages)&&(identical(other.djotContent, djotContent) || other.djotContent == djotContent)&&(identical(other.document, document) || other.document == document)&&const DeepCollectionEquality().equals(other.elements, elements)&&const DeepCollectionEquality().equals(other.extractedKeywords, extractedKeywords)&&(identical(other.extractionMethod, extractionMethod) || other.extractionMethod == extractionMethod)&&const DeepCollectionEquality().equals(other.images, images)&&const DeepCollectionEquality().equals(other.llmUsage, llmUsage)&&const DeepCollectionEquality().equals(other.ocrElements, ocrElements)&&const DeepCollectionEquality().equals(other.pages, pages)&&const DeepCollectionEquality().equals(other.processingWarnings, processingWarnings)&&(identical(other.qualityScore, qualityScore) || other.qualityScore == qualityScore)&&const DeepCollectionEquality().equals(other.revisions, revisions)&&const DeepCollectionEquality().equals(other.structuredOutput, structuredOutput)&&const DeepCollectionEquality().equals(other.uris, uris));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,content,metadata,mimeType,const DeepCollectionEquality().hash(tables),const DeepCollectionEquality().hash(annotations),const DeepCollectionEquality().hash(children),const DeepCollectionEquality().hash(chunks),const DeepCollectionEquality().hash(detectedLanguages),djotContent,document,const DeepCollectionEquality().hash(elements),const DeepCollectionEquality().hash(extractedKeywords),extractionMethod,const DeepCollectionEquality().hash(images),const DeepCollectionEquality().hash(llmUsage),const DeepCollectionEquality().hash(ocrElements),const DeepCollectionEquality().hash(pages),const DeepCollectionEquality().hash(processingWarnings),qualityScore,const DeepCollectionEquality().hash(revisions),const DeepCollectionEquality().hash(structuredOutput),const DeepCollectionEquality().hash(uris)]);

@override
String toString() {
  return 'ExtractionResult(content: $content, metadata: $metadata, mimeType: $mimeType, tables: $tables, annotations: $annotations, children: $children, chunks: $chunks, detectedLanguages: $detectedLanguages, djotContent: $djotContent, document: $document, elements: $elements, extractedKeywords: $extractedKeywords, extractionMethod: $extractionMethod, images: $images, llmUsage: $llmUsage, ocrElements: $ocrElements, pages: $pages, processingWarnings: $processingWarnings, qualityScore: $qualityScore, revisions: $revisions, structuredOutput: $structuredOutput, uris: $uris)';
}


}

/// @nodoc
abstract mixin class $ExtractionResultCopyWith<$Res>  {
  factory $ExtractionResultCopyWith(ExtractionResult value, $Res Function(ExtractionResult) _then) = _$ExtractionResultCopyWithImpl;
@useResult
$Res call({
 String content, Metadata metadata,@JsonKey(name: 'mime_type') String mimeType, List<Table> tables, List<PdfAnnotation>? annotations, List<ArchiveEntry>? children, List<Chunk>? chunks,@JsonKey(name: 'detected_languages') List<String>? detectedLanguages,@JsonKey(name: 'djot_content') DjotContent? djotContent, DocumentStructure? document, List<Element>? elements,@JsonKey(name: 'extracted_keywords') List<Keyword>? extractedKeywords,@JsonKey(name: 'extraction_method') ExtractionMethod? extractionMethod, List<ExtractedImage>? images,@JsonKey(name: 'llm_usage') List<LlmUsage>? llmUsage,@JsonKey(name: 'ocr_elements') List<OcrElement>? ocrElements, List<PageContent>? pages,@JsonKey(name: 'processing_warnings') List<ProcessingWarning>? processingWarnings,@JsonKey(name: 'quality_score') double? qualityScore, List<DocumentRevision>? revisions,@JsonKey(name: 'structured_output') dynamic structuredOutput, List<ExtractedUri>? uris
});


$MetadataCopyWith<$Res> get metadata;$DjotContentCopyWith<$Res>? get djotContent;$DocumentStructureCopyWith<$Res>? get document;

}
/// @nodoc
class _$ExtractionResultCopyWithImpl<$Res>
    implements $ExtractionResultCopyWith<$Res> {
  _$ExtractionResultCopyWithImpl(this._self, this._then);

  final ExtractionResult _self;
  final $Res Function(ExtractionResult) _then;

/// Create a copy of ExtractionResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,Object? metadata = null,Object? mimeType = null,Object? tables = null,Object? annotations = freezed,Object? children = freezed,Object? chunks = freezed,Object? detectedLanguages = freezed,Object? djotContent = freezed,Object? document = freezed,Object? elements = freezed,Object? extractedKeywords = freezed,Object? extractionMethod = freezed,Object? images = freezed,Object? llmUsage = freezed,Object? ocrElements = freezed,Object? pages = freezed,Object? processingWarnings = freezed,Object? qualityScore = freezed,Object? revisions = freezed,Object? structuredOutput = freezed,Object? uris = freezed,}) {
  return _then(_self.copyWith(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Metadata,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,tables: null == tables ? _self.tables : tables // ignore: cast_nullable_to_non_nullable
as List<Table>,annotations: freezed == annotations ? _self.annotations : annotations // ignore: cast_nullable_to_non_nullable
as List<PdfAnnotation>?,children: freezed == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<ArchiveEntry>?,chunks: freezed == chunks ? _self.chunks : chunks // ignore: cast_nullable_to_non_nullable
as List<Chunk>?,detectedLanguages: freezed == detectedLanguages ? _self.detectedLanguages : detectedLanguages // ignore: cast_nullable_to_non_nullable
as List<String>?,djotContent: freezed == djotContent ? _self.djotContent : djotContent // ignore: cast_nullable_to_non_nullable
as DjotContent?,document: freezed == document ? _self.document : document // ignore: cast_nullable_to_non_nullable
as DocumentStructure?,elements: freezed == elements ? _self.elements : elements // ignore: cast_nullable_to_non_nullable
as List<Element>?,extractedKeywords: freezed == extractedKeywords ? _self.extractedKeywords : extractedKeywords // ignore: cast_nullable_to_non_nullable
as List<Keyword>?,extractionMethod: freezed == extractionMethod ? _self.extractionMethod : extractionMethod // ignore: cast_nullable_to_non_nullable
as ExtractionMethod?,images: freezed == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<ExtractedImage>?,llmUsage: freezed == llmUsage ? _self.llmUsage : llmUsage // ignore: cast_nullable_to_non_nullable
as List<LlmUsage>?,ocrElements: freezed == ocrElements ? _self.ocrElements : ocrElements // ignore: cast_nullable_to_non_nullable
as List<OcrElement>?,pages: freezed == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as List<PageContent>?,processingWarnings: freezed == processingWarnings ? _self.processingWarnings : processingWarnings // ignore: cast_nullable_to_non_nullable
as List<ProcessingWarning>?,qualityScore: freezed == qualityScore ? _self.qualityScore : qualityScore // ignore: cast_nullable_to_non_nullable
as double?,revisions: freezed == revisions ? _self.revisions : revisions // ignore: cast_nullable_to_non_nullable
as List<DocumentRevision>?,structuredOutput: freezed == structuredOutput ? _self.structuredOutput : structuredOutput // ignore: cast_nullable_to_non_nullable
as dynamic,uris: freezed == uris ? _self.uris : uris // ignore: cast_nullable_to_non_nullable
as List<ExtractedUri>?,
  ));
}
/// Create a copy of ExtractionResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MetadataCopyWith<$Res> get metadata {
  
  return $MetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}/// Create a copy of ExtractionResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DjotContentCopyWith<$Res>? get djotContent {
    if (_self.djotContent == null) {
    return null;
  }

  return $DjotContentCopyWith<$Res>(_self.djotContent!, (value) {
    return _then(_self.copyWith(djotContent: value));
  });
}/// Create a copy of ExtractionResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DocumentStructureCopyWith<$Res>? get document {
    if (_self.document == null) {
    return null;
  }

  return $DocumentStructureCopyWith<$Res>(_self.document!, (value) {
    return _then(_self.copyWith(document: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExtractionResult].
extension ExtractionResultPatterns on ExtractionResult {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExtractionResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExtractionResult() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExtractionResult value)  $default,){
final _that = this;
switch (_that) {
case _ExtractionResult():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExtractionResult value)?  $default,){
final _that = this;
switch (_that) {
case _ExtractionResult() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String content,  Metadata metadata, @JsonKey(name: 'mime_type')  String mimeType,  List<Table> tables,  List<PdfAnnotation>? annotations,  List<ArchiveEntry>? children,  List<Chunk>? chunks, @JsonKey(name: 'detected_languages')  List<String>? detectedLanguages, @JsonKey(name: 'djot_content')  DjotContent? djotContent,  DocumentStructure? document,  List<Element>? elements, @JsonKey(name: 'extracted_keywords')  List<Keyword>? extractedKeywords, @JsonKey(name: 'extraction_method')  ExtractionMethod? extractionMethod,  List<ExtractedImage>? images, @JsonKey(name: 'llm_usage')  List<LlmUsage>? llmUsage, @JsonKey(name: 'ocr_elements')  List<OcrElement>? ocrElements,  List<PageContent>? pages, @JsonKey(name: 'processing_warnings')  List<ProcessingWarning>? processingWarnings, @JsonKey(name: 'quality_score')  double? qualityScore,  List<DocumentRevision>? revisions, @JsonKey(name: 'structured_output')  dynamic structuredOutput,  List<ExtractedUri>? uris)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExtractionResult() when $default != null:
return $default(_that.content,_that.metadata,_that.mimeType,_that.tables,_that.annotations,_that.children,_that.chunks,_that.detectedLanguages,_that.djotContent,_that.document,_that.elements,_that.extractedKeywords,_that.extractionMethod,_that.images,_that.llmUsage,_that.ocrElements,_that.pages,_that.processingWarnings,_that.qualityScore,_that.revisions,_that.structuredOutput,_that.uris);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String content,  Metadata metadata, @JsonKey(name: 'mime_type')  String mimeType,  List<Table> tables,  List<PdfAnnotation>? annotations,  List<ArchiveEntry>? children,  List<Chunk>? chunks, @JsonKey(name: 'detected_languages')  List<String>? detectedLanguages, @JsonKey(name: 'djot_content')  DjotContent? djotContent,  DocumentStructure? document,  List<Element>? elements, @JsonKey(name: 'extracted_keywords')  List<Keyword>? extractedKeywords, @JsonKey(name: 'extraction_method')  ExtractionMethod? extractionMethod,  List<ExtractedImage>? images, @JsonKey(name: 'llm_usage')  List<LlmUsage>? llmUsage, @JsonKey(name: 'ocr_elements')  List<OcrElement>? ocrElements,  List<PageContent>? pages, @JsonKey(name: 'processing_warnings')  List<ProcessingWarning>? processingWarnings, @JsonKey(name: 'quality_score')  double? qualityScore,  List<DocumentRevision>? revisions, @JsonKey(name: 'structured_output')  dynamic structuredOutput,  List<ExtractedUri>? uris)  $default,) {final _that = this;
switch (_that) {
case _ExtractionResult():
return $default(_that.content,_that.metadata,_that.mimeType,_that.tables,_that.annotations,_that.children,_that.chunks,_that.detectedLanguages,_that.djotContent,_that.document,_that.elements,_that.extractedKeywords,_that.extractionMethod,_that.images,_that.llmUsage,_that.ocrElements,_that.pages,_that.processingWarnings,_that.qualityScore,_that.revisions,_that.structuredOutput,_that.uris);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String content,  Metadata metadata, @JsonKey(name: 'mime_type')  String mimeType,  List<Table> tables,  List<PdfAnnotation>? annotations,  List<ArchiveEntry>? children,  List<Chunk>? chunks, @JsonKey(name: 'detected_languages')  List<String>? detectedLanguages, @JsonKey(name: 'djot_content')  DjotContent? djotContent,  DocumentStructure? document,  List<Element>? elements, @JsonKey(name: 'extracted_keywords')  List<Keyword>? extractedKeywords, @JsonKey(name: 'extraction_method')  ExtractionMethod? extractionMethod,  List<ExtractedImage>? images, @JsonKey(name: 'llm_usage')  List<LlmUsage>? llmUsage, @JsonKey(name: 'ocr_elements')  List<OcrElement>? ocrElements,  List<PageContent>? pages, @JsonKey(name: 'processing_warnings')  List<ProcessingWarning>? processingWarnings, @JsonKey(name: 'quality_score')  double? qualityScore,  List<DocumentRevision>? revisions, @JsonKey(name: 'structured_output')  dynamic structuredOutput,  List<ExtractedUri>? uris)?  $default,) {final _that = this;
switch (_that) {
case _ExtractionResult() when $default != null:
return $default(_that.content,_that.metadata,_that.mimeType,_that.tables,_that.annotations,_that.children,_that.chunks,_that.detectedLanguages,_that.djotContent,_that.document,_that.elements,_that.extractedKeywords,_that.extractionMethod,_that.images,_that.llmUsage,_that.ocrElements,_that.pages,_that.processingWarnings,_that.qualityScore,_that.revisions,_that.structuredOutput,_that.uris);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExtractionResult implements ExtractionResult {
  const _ExtractionResult({required this.content, required this.metadata, @JsonKey(name: 'mime_type') required this.mimeType, required final  List<Table> tables, final  List<PdfAnnotation>? annotations, final  List<ArchiveEntry>? children, final  List<Chunk>? chunks, @JsonKey(name: 'detected_languages') final  List<String>? detectedLanguages, @JsonKey(name: 'djot_content') this.djotContent, this.document, final  List<Element>? elements, @JsonKey(name: 'extracted_keywords') final  List<Keyword>? extractedKeywords, @JsonKey(name: 'extraction_method') this.extractionMethod, final  List<ExtractedImage>? images, @JsonKey(name: 'llm_usage') final  List<LlmUsage>? llmUsage, @JsonKey(name: 'ocr_elements') final  List<OcrElement>? ocrElements, final  List<PageContent>? pages, @JsonKey(name: 'processing_warnings') final  List<ProcessingWarning>? processingWarnings, @JsonKey(name: 'quality_score') this.qualityScore, final  List<DocumentRevision>? revisions, @JsonKey(name: 'structured_output') this.structuredOutput, final  List<ExtractedUri>? uris}): _tables = tables,_annotations = annotations,_children = children,_chunks = chunks,_detectedLanguages = detectedLanguages,_elements = elements,_extractedKeywords = extractedKeywords,_images = images,_llmUsage = llmUsage,_ocrElements = ocrElements,_pages = pages,_processingWarnings = processingWarnings,_revisions = revisions,_uris = uris;
  factory _ExtractionResult.fromJson(Map<String, dynamic> json) => _$ExtractionResultFromJson(json);

@override final  String content;
@override final  Metadata metadata;
@override@JsonKey(name: 'mime_type') final  String mimeType;
 final  List<Table> _tables;
@override List<Table> get tables {
  if (_tables is EqualUnmodifiableListView) return _tables;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tables);
}

/// PDF annotations extracted from the document.
///
/// When annotation extraction is enabled via `PdfConfig::extract_annotations`,.
/// this field contains text notes, highlights, links, stamps, and other.
/// annotations found in PDF documents.
 final  List<PdfAnnotation>? _annotations;
/// PDF annotations extracted from the document.
///
/// When annotation extraction is enabled via `PdfConfig::extract_annotations`,.
/// this field contains text notes, highlights, links, stamps, and other.
/// annotations found in PDF documents.
@override List<PdfAnnotation>? get annotations {
  final value = _annotations;
  if (value == null) return null;
  if (_annotations is EqualUnmodifiableListView) return _annotations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Nested extraction results from archive contents.
///
/// When extracting archives, each processable file inside produces its own.
/// full extraction result. Set to `None` for non-archive formats.
/// Use `max_archive_depth` in config to control recursion depth.
 final  List<ArchiveEntry>? _children;
/// Nested extraction results from archive contents.
///
/// When extracting archives, each processable file inside produces its own.
/// full extraction result. Set to `None` for non-archive formats.
/// Use `max_archive_depth` in config to control recursion depth.
@override List<ArchiveEntry>? get children {
  final value = _children;
  if (value == null) return null;
  if (_children is EqualUnmodifiableListView) return _children;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Text chunks when chunking is enabled.
///
/// When chunking configuration is provided, the content is split into.
/// overlapping chunks for efficient processing. Each chunk contains the text,.
/// optional embeddings (if enabled), and metadata about its position.
 final  List<Chunk>? _chunks;
/// Text chunks when chunking is enabled.
///
/// When chunking configuration is provided, the content is split into.
/// overlapping chunks for efficient processing. Each chunk contains the text,.
/// optional embeddings (if enabled), and metadata about its position.
@override List<Chunk>? get chunks {
  final value = _chunks;
  if (value == null) return null;
  if (_chunks is EqualUnmodifiableListView) return _chunks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _detectedLanguages;
@override@JsonKey(name: 'detected_languages') List<String>? get detectedLanguages {
  final value = _detectedLanguages;
  if (value == null) return null;
  if (_detectedLanguages is EqualUnmodifiableListView) return _detectedLanguages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

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
@override@JsonKey(name: 'djot_content') final  DjotContent? djotContent;
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
@override final  DocumentStructure? document;
/// Semantic elements when element-based result format is enabled.
///
/// When result_format is set to ElementBased, this field contains semantic.
/// elements with type classification, unique identifiers, and metadata for.
/// Unstructured-compatible element-based processing.
 final  List<Element>? _elements;
/// Semantic elements when element-based result format is enabled.
///
/// When result_format is set to ElementBased, this field contains semantic.
/// elements with type classification, unique identifiers, and metadata for.
/// Unstructured-compatible element-based processing.
@override List<Element>? get elements {
  final value = _elements;
  if (value == null) return null;
  if (_elements is EqualUnmodifiableListView) return _elements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Extracted keywords when keyword extraction is enabled.
///
/// When keyword extraction (RAKE or YAKE) is configured, this field contains.
/// the extracted keywords with scores, algorithm info, and position data.
/// Previously stored in `metadata.additional["keywords"]`.
 final  List<Keyword>? _extractedKeywords;
/// Extracted keywords when keyword extraction is enabled.
///
/// When keyword extraction (RAKE or YAKE) is configured, this field contains.
/// the extracted keywords with scores, algorithm info, and position data.
/// Previously stored in `metadata.additional["keywords"]`.
@override@JsonKey(name: 'extracted_keywords') List<Keyword>? get extractedKeywords {
  final value = _extractedKeywords;
  if (value == null) return null;
  if (_extractedKeywords is EqualUnmodifiableListView) return _extractedKeywords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Extraction strategy used to produce the returned text.
///
/// Populated when the extractor can reliably distinguish native text extraction,.
/// OCR-only extraction, or mixed native/OCR output.
@override@JsonKey(name: 'extraction_method') final  ExtractionMethod? extractionMethod;
/// Extracted images from the document.
///
/// When image extraction is enabled via `ImageExtractionConfig`, this field.
/// contains all images found in the document with their raw data and metadata.
/// Each image may optionally contain a nested `ocr_result` if OCR was performed.
 final  List<ExtractedImage>? _images;
/// Extracted images from the document.
///
/// When image extraction is enabled via `ImageExtractionConfig`, this field.
/// contains all images found in the document with their raw data and metadata.
/// Each image may optionally contain a nested `ocr_result` if OCR was performed.
@override List<ExtractedImage>? get images {
  final value = _images;
  if (value == null) return null;
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// LLM token usage and cost data for all LLM calls made during this extraction.
///
/// Contains one entry per LLM call. Multiple entries are produced when.
/// VLM OCR, structured extraction, or LLM embeddings run during.
/// the same extraction.
///
/// `None` when no LLM was used.
 final  List<LlmUsage>? _llmUsage;
/// LLM token usage and cost data for all LLM calls made during this extraction.
///
/// Contains one entry per LLM call. Multiple entries are produced when.
/// VLM OCR, structured extraction, or LLM embeddings run during.
/// the same extraction.
///
/// `None` when no LLM was used.
@override@JsonKey(name: 'llm_usage') List<LlmUsage>? get llmUsage {
  final value = _llmUsage;
  if (value == null) return null;
  if (_llmUsage is EqualUnmodifiableListView) return _llmUsage;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

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
 final  List<OcrElement>? _ocrElements;
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
@override@JsonKey(name: 'ocr_elements') List<OcrElement>? get ocrElements {
  final value = _ocrElements;
  if (value == null) return null;
  if (_ocrElements is EqualUnmodifiableListView) return _ocrElements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Per-page content when page extraction is enabled.
///
/// When page extraction is configured, the document is split into per-page content.
/// with tables and images mapped to their respective pages.
 final  List<PageContent>? _pages;
/// Per-page content when page extraction is enabled.
///
/// When page extraction is configured, the document is split into per-page content.
/// with tables and images mapped to their respective pages.
@override List<PageContent>? get pages {
  final value = _pages;
  if (value == null) return null;
  if (_pages is EqualUnmodifiableListView) return _pages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Non-fatal warnings collected during processing pipeline stages.
///
/// Captures errors from optional pipeline features (embedding, chunking,.
/// language detection, output formatting) that don't prevent extraction.
/// but may indicate degraded results.
/// Previously stored as individual keys in `metadata.additional`.
 final  List<ProcessingWarning>? _processingWarnings;
/// Non-fatal warnings collected during processing pipeline stages.
///
/// Captures errors from optional pipeline features (embedding, chunking,.
/// language detection, output formatting) that don't prevent extraction.
/// but may indicate degraded results.
/// Previously stored as individual keys in `metadata.additional`.
@override@JsonKey(name: 'processing_warnings') List<ProcessingWarning>? get processingWarnings {
  final value = _processingWarnings;
  if (value == null) return null;
  if (_processingWarnings is EqualUnmodifiableListView) return _processingWarnings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Document quality score from quality analysis.
///
/// A value between 0.0 and 1.0 indicating the overall text quality.
/// Previously stored in `metadata.additional["quality_score"]`.
@override@JsonKey(name: 'quality_score') final  double? qualityScore;
/// Tracked changes embedded in the source document.
///
/// Populated by per-format extractors that understand change-tracking.
/// metadata (DOCX `w:ins`/`w:del`/`w:rPrChange`, ODT `text:change-*`,.
/// …). Every extractor defaults to `None` until its format-specific.
/// implementation is added. Extractors that do populate this field follow.
/// the "accepted-changes" convention: inserted text is present in.
/// `content`, deleted text is absent — the revision list is the separate.
/// audit trail.
 final  List<DocumentRevision>? _revisions;
/// Tracked changes embedded in the source document.
///
/// Populated by per-format extractors that understand change-tracking.
/// metadata (DOCX `w:ins`/`w:del`/`w:rPrChange`, ODT `text:change-*`,.
/// …). Every extractor defaults to `None` until its format-specific.
/// implementation is added. Extractors that do populate this field follow.
/// the "accepted-changes" convention: inserted text is present in.
/// `content`, deleted text is absent — the revision list is the separate.
/// audit trail.
@override List<DocumentRevision>? get revisions {
  final value = _revisions;
  if (value == null) return null;
  if (_revisions is EqualUnmodifiableListView) return _revisions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Structured extraction output from LLM-based JSON schema extraction.
///
/// When `structured_extraction` is configured in `ExtractionConfig`, the.
/// extracted document content is sent to a VLM with the provided JSON schema.
/// The response is parsed and stored here as a JSON value matching the schema.
@override@JsonKey(name: 'structured_output') final  dynamic structuredOutput;
/// URIs/links discovered during document extraction.
///
/// Contains hyperlinks, image references, citations, email addresses, and.
/// other URI-like references found in the document. Always extracted when.
/// present in the source document.
 final  List<ExtractedUri>? _uris;
/// URIs/links discovered during document extraction.
///
/// Contains hyperlinks, image references, citations, email addresses, and.
/// other URI-like references found in the document. Always extracted when.
/// present in the source document.
@override List<ExtractedUri>? get uris {
  final value = _uris;
  if (value == null) return null;
  if (_uris is EqualUnmodifiableListView) return _uris;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ExtractionResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExtractionResultCopyWith<_ExtractionResult> get copyWith => __$ExtractionResultCopyWithImpl<_ExtractionResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExtractionResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExtractionResult&&(identical(other.content, content) || other.content == content)&&(identical(other.metadata, metadata) || other.metadata == metadata)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&const DeepCollectionEquality().equals(other._tables, _tables)&&const DeepCollectionEquality().equals(other._annotations, _annotations)&&const DeepCollectionEquality().equals(other._children, _children)&&const DeepCollectionEquality().equals(other._chunks, _chunks)&&const DeepCollectionEquality().equals(other._detectedLanguages, _detectedLanguages)&&(identical(other.djotContent, djotContent) || other.djotContent == djotContent)&&(identical(other.document, document) || other.document == document)&&const DeepCollectionEquality().equals(other._elements, _elements)&&const DeepCollectionEquality().equals(other._extractedKeywords, _extractedKeywords)&&(identical(other.extractionMethod, extractionMethod) || other.extractionMethod == extractionMethod)&&const DeepCollectionEquality().equals(other._images, _images)&&const DeepCollectionEquality().equals(other._llmUsage, _llmUsage)&&const DeepCollectionEquality().equals(other._ocrElements, _ocrElements)&&const DeepCollectionEquality().equals(other._pages, _pages)&&const DeepCollectionEquality().equals(other._processingWarnings, _processingWarnings)&&(identical(other.qualityScore, qualityScore) || other.qualityScore == qualityScore)&&const DeepCollectionEquality().equals(other._revisions, _revisions)&&const DeepCollectionEquality().equals(other.structuredOutput, structuredOutput)&&const DeepCollectionEquality().equals(other._uris, _uris));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,content,metadata,mimeType,const DeepCollectionEquality().hash(_tables),const DeepCollectionEquality().hash(_annotations),const DeepCollectionEquality().hash(_children),const DeepCollectionEquality().hash(_chunks),const DeepCollectionEquality().hash(_detectedLanguages),djotContent,document,const DeepCollectionEquality().hash(_elements),const DeepCollectionEquality().hash(_extractedKeywords),extractionMethod,const DeepCollectionEquality().hash(_images),const DeepCollectionEquality().hash(_llmUsage),const DeepCollectionEquality().hash(_ocrElements),const DeepCollectionEquality().hash(_pages),const DeepCollectionEquality().hash(_processingWarnings),qualityScore,const DeepCollectionEquality().hash(_revisions),const DeepCollectionEquality().hash(structuredOutput),const DeepCollectionEquality().hash(_uris)]);

@override
String toString() {
  return 'ExtractionResult(content: $content, metadata: $metadata, mimeType: $mimeType, tables: $tables, annotations: $annotations, children: $children, chunks: $chunks, detectedLanguages: $detectedLanguages, djotContent: $djotContent, document: $document, elements: $elements, extractedKeywords: $extractedKeywords, extractionMethod: $extractionMethod, images: $images, llmUsage: $llmUsage, ocrElements: $ocrElements, pages: $pages, processingWarnings: $processingWarnings, qualityScore: $qualityScore, revisions: $revisions, structuredOutput: $structuredOutput, uris: $uris)';
}


}

/// @nodoc
abstract mixin class _$ExtractionResultCopyWith<$Res> implements $ExtractionResultCopyWith<$Res> {
  factory _$ExtractionResultCopyWith(_ExtractionResult value, $Res Function(_ExtractionResult) _then) = __$ExtractionResultCopyWithImpl;
@override @useResult
$Res call({
 String content, Metadata metadata,@JsonKey(name: 'mime_type') String mimeType, List<Table> tables, List<PdfAnnotation>? annotations, List<ArchiveEntry>? children, List<Chunk>? chunks,@JsonKey(name: 'detected_languages') List<String>? detectedLanguages,@JsonKey(name: 'djot_content') DjotContent? djotContent, DocumentStructure? document, List<Element>? elements,@JsonKey(name: 'extracted_keywords') List<Keyword>? extractedKeywords,@JsonKey(name: 'extraction_method') ExtractionMethod? extractionMethod, List<ExtractedImage>? images,@JsonKey(name: 'llm_usage') List<LlmUsage>? llmUsage,@JsonKey(name: 'ocr_elements') List<OcrElement>? ocrElements, List<PageContent>? pages,@JsonKey(name: 'processing_warnings') List<ProcessingWarning>? processingWarnings,@JsonKey(name: 'quality_score') double? qualityScore, List<DocumentRevision>? revisions,@JsonKey(name: 'structured_output') dynamic structuredOutput, List<ExtractedUri>? uris
});


@override $MetadataCopyWith<$Res> get metadata;@override $DjotContentCopyWith<$Res>? get djotContent;@override $DocumentStructureCopyWith<$Res>? get document;

}
/// @nodoc
class __$ExtractionResultCopyWithImpl<$Res>
    implements _$ExtractionResultCopyWith<$Res> {
  __$ExtractionResultCopyWithImpl(this._self, this._then);

  final _ExtractionResult _self;
  final $Res Function(_ExtractionResult) _then;

/// Create a copy of ExtractionResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = null,Object? metadata = null,Object? mimeType = null,Object? tables = null,Object? annotations = freezed,Object? children = freezed,Object? chunks = freezed,Object? detectedLanguages = freezed,Object? djotContent = freezed,Object? document = freezed,Object? elements = freezed,Object? extractedKeywords = freezed,Object? extractionMethod = freezed,Object? images = freezed,Object? llmUsage = freezed,Object? ocrElements = freezed,Object? pages = freezed,Object? processingWarnings = freezed,Object? qualityScore = freezed,Object? revisions = freezed,Object? structuredOutput = freezed,Object? uris = freezed,}) {
  return _then(_ExtractionResult(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Metadata,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,tables: null == tables ? _self._tables : tables // ignore: cast_nullable_to_non_nullable
as List<Table>,annotations: freezed == annotations ? _self._annotations : annotations // ignore: cast_nullable_to_non_nullable
as List<PdfAnnotation>?,children: freezed == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<ArchiveEntry>?,chunks: freezed == chunks ? _self._chunks : chunks // ignore: cast_nullable_to_non_nullable
as List<Chunk>?,detectedLanguages: freezed == detectedLanguages ? _self._detectedLanguages : detectedLanguages // ignore: cast_nullable_to_non_nullable
as List<String>?,djotContent: freezed == djotContent ? _self.djotContent : djotContent // ignore: cast_nullable_to_non_nullable
as DjotContent?,document: freezed == document ? _self.document : document // ignore: cast_nullable_to_non_nullable
as DocumentStructure?,elements: freezed == elements ? _self._elements : elements // ignore: cast_nullable_to_non_nullable
as List<Element>?,extractedKeywords: freezed == extractedKeywords ? _self._extractedKeywords : extractedKeywords // ignore: cast_nullable_to_non_nullable
as List<Keyword>?,extractionMethod: freezed == extractionMethod ? _self.extractionMethod : extractionMethod // ignore: cast_nullable_to_non_nullable
as ExtractionMethod?,images: freezed == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<ExtractedImage>?,llmUsage: freezed == llmUsage ? _self._llmUsage : llmUsage // ignore: cast_nullable_to_non_nullable
as List<LlmUsage>?,ocrElements: freezed == ocrElements ? _self._ocrElements : ocrElements // ignore: cast_nullable_to_non_nullable
as List<OcrElement>?,pages: freezed == pages ? _self._pages : pages // ignore: cast_nullable_to_non_nullable
as List<PageContent>?,processingWarnings: freezed == processingWarnings ? _self._processingWarnings : processingWarnings // ignore: cast_nullable_to_non_nullable
as List<ProcessingWarning>?,qualityScore: freezed == qualityScore ? _self.qualityScore : qualityScore // ignore: cast_nullable_to_non_nullable
as double?,revisions: freezed == revisions ? _self._revisions : revisions // ignore: cast_nullable_to_non_nullable
as List<DocumentRevision>?,structuredOutput: freezed == structuredOutput ? _self.structuredOutput : structuredOutput // ignore: cast_nullable_to_non_nullable
as dynamic,uris: freezed == uris ? _self._uris : uris // ignore: cast_nullable_to_non_nullable
as List<ExtractedUri>?,
  ));
}

/// Create a copy of ExtractionResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MetadataCopyWith<$Res> get metadata {
  
  return $MetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}/// Create a copy of ExtractionResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DjotContentCopyWith<$Res>? get djotContent {
    if (_self.djotContent == null) {
    return null;
  }

  return $DjotContentCopyWith<$Res>(_self.djotContent!, (value) {
    return _then(_self.copyWith(djotContent: value));
  });
}/// Create a copy of ExtractionResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DocumentStructureCopyWith<$Res>? get document {
    if (_self.document == null) {
    return null;
  }

  return $DocumentStructureCopyWith<$Res>(_self.document!, (value) {
    return _then(_self.copyWith(document: value));
  });
}
}

// dart format on
