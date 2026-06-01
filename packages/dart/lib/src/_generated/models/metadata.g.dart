// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Metadata _$MetadataFromJson(Map<String, dynamic> json) => _Metadata(
  abstractText: json['abstract_text'] as String?,
  additional: json['additional'] as Map<String, dynamic>?,
  authors: (json['authors'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  category: json['category'] as String?,
  createdAt: json['created_at'] as String?,
  createdBy: json['created_by'] as String?,
  documentVersion: json['document_version'] as String?,
  error: json['error'] == null
      ? null
      : ErrorMetadata.fromJson(json['error'] as Map<String, dynamic>),
  extractionDurationMs: (json['extraction_duration_ms'] as num?)?.toInt(),
  format: json['format'] == null
      ? null
      : FormatMetadata.fromJson(json['format'] as Map<String, dynamic>),
  imagePreprocessing: json['image_preprocessing'] == null
      ? null
      : ImagePreprocessingMetadata.fromJson(
          json['image_preprocessing'] as Map<String, dynamic>,
        ),
  jsonSchema: json['json_schema'],
  keywords: (json['keywords'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  language: json['language'] as String?,
  modifiedAt: json['modified_at'] as String?,
  modifiedBy: json['modified_by'] as String?,
  ocrUsed: json['ocr_used'] as bool?,
  outputFormat: json['output_format'] as String?,
  pages: json['pages'] == null
      ? null
      : PageStructure.fromJson(json['pages'] as Map<String, dynamic>),
  subject: json['subject'] as String?,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  title: json['title'] as String?,
);

Map<String, dynamic> _$MetadataToJson(_Metadata instance) => <String, dynamic>{
  'abstract_text': instance.abstractText,
  'additional': instance.additional,
  'authors': instance.authors,
  'category': instance.category,
  'created_at': instance.createdAt,
  'created_by': instance.createdBy,
  'document_version': instance.documentVersion,
  'error': instance.error,
  'extraction_duration_ms': instance.extractionDurationMs,
  'format': instance.format,
  'image_preprocessing': instance.imagePreprocessing,
  'json_schema': instance.jsonSchema,
  'keywords': instance.keywords,
  'language': instance.language,
  'modified_at': instance.modifiedAt,
  'modified_by': instance.modifiedBy,
  'ocr_used': instance.ocrUsed,
  'output_format': instance.outputFormat,
  'pages': instance.pages,
  'subject': instance.subject,
  'tags': instance.tags,
  'title': instance.title,
};
