// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extraction_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExtractionResult _$ExtractionResultFromJson(Map<String, dynamic> json) =>
    _ExtractionResult(
      chunks: (json['chunks'] as List<dynamic>?)
          ?.map((e) => Chunk.fromJson(e as Map<String, dynamic>))
          .toList(),
      content: json['content'] as String?,
      detectedLanguages: (json['detected_languages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ExtractedImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      mimeType: json['mime_type'] as String?,
      pages: (json['pages'] as List<dynamic>?)
          ?.map((e) => PageContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      processingWarnings: (json['processing_warnings'] as List<dynamic>?)
          ?.map((e) => ProcessingWarning.fromJson(e as Map<String, dynamic>))
          .toList(),
      qualityScore: (json['quality_score'] as num?)?.toDouble(),
      tables: (json['tables'] as List<dynamic>?)
          ?.map((e) => Table.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExtractionResultToJson(_ExtractionResult instance) =>
    <String, dynamic>{
      'chunks': instance.chunks,
      'content': instance.content,
      'detected_languages': instance.detectedLanguages,
      'images': instance.images,
      'metadata': instance.metadata,
      'mime_type': instance.mimeType,
      'pages': instance.pages,
      'processing_warnings': instance.processingWarnings,
      'quality_score': instance.qualityScore,
      'tables': instance.tables,
    };
