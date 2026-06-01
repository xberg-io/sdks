// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extraction_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExtractionResult _$ExtractionResultFromJson(Map<String, dynamic> json) =>
    _ExtractionResult(
      content: json['content'] as String,
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      mimeType: json['mime_type'] as String,
      tables: (json['tables'] as List<dynamic>)
          .map((e) => Table.fromJson(e as Map<String, dynamic>))
          .toList(),
      annotations: (json['annotations'] as List<dynamic>?)
          ?.map((e) => PdfAnnotation.fromJson(e as Map<String, dynamic>))
          .toList(),
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => ArchiveEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      chunks: (json['chunks'] as List<dynamic>?)
          ?.map((e) => Chunk.fromJson(e as Map<String, dynamic>))
          .toList(),
      detectedLanguages: (json['detected_languages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      djotContent: json['djot_content'] == null
          ? null
          : DjotContent.fromJson(json['djot_content'] as Map<String, dynamic>),
      document: json['document'] == null
          ? null
          : DocumentStructure.fromJson(
              json['document'] as Map<String, dynamic>,
            ),
      elements: (json['elements'] as List<dynamic>?)
          ?.map((e) => Element.fromJson(e as Map<String, dynamic>))
          .toList(),
      extractedKeywords: (json['extracted_keywords'] as List<dynamic>?)
          ?.map((e) => Keyword.fromJson(e as Map<String, dynamic>))
          .toList(),
      extractionMethod: json['extraction_method'] == null
          ? null
          : ExtractionMethod.fromJson(json['extraction_method'] as String),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ExtractedImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      llmUsage: (json['llm_usage'] as List<dynamic>?)
          ?.map((e) => LlmUsage.fromJson(e as Map<String, dynamic>))
          .toList(),
      ocrElements: (json['ocr_elements'] as List<dynamic>?)
          ?.map((e) => OcrElement.fromJson(e as Map<String, dynamic>))
          .toList(),
      pages: (json['pages'] as List<dynamic>?)
          ?.map((e) => PageContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      processingWarnings: (json['processing_warnings'] as List<dynamic>?)
          ?.map((e) => ProcessingWarning.fromJson(e as Map<String, dynamic>))
          .toList(),
      qualityScore: (json['quality_score'] as num?)?.toDouble(),
      revisions: (json['revisions'] as List<dynamic>?)
          ?.map((e) => DocumentRevision.fromJson(e as Map<String, dynamic>))
          .toList(),
      structuredOutput: json['structured_output'],
      uris: (json['uris'] as List<dynamic>?)
          ?.map((e) => ExtractedUri.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExtractionResultToJson(_ExtractionResult instance) =>
    <String, dynamic>{
      'content': instance.content,
      'metadata': instance.metadata,
      'mime_type': instance.mimeType,
      'tables': instance.tables,
      'annotations': instance.annotations,
      'children': instance.children,
      'chunks': instance.chunks,
      'detected_languages': instance.detectedLanguages,
      'djot_content': instance.djotContent,
      'document': instance.document,
      'elements': instance.elements,
      'extracted_keywords': instance.extractedKeywords,
      'extraction_method': instance.extractionMethod,
      'images': instance.images,
      'llm_usage': instance.llmUsage,
      'ocr_elements': instance.ocrElements,
      'pages': instance.pages,
      'processing_warnings': instance.processingWarnings,
      'quality_score': instance.qualityScore,
      'revisions': instance.revisions,
      'structured_output': instance.structuredOutput,
      'uris': instance.uris,
    };
