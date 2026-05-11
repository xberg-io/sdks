// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Metadata _$MetadataFromJson(Map<String, dynamic> json) => _Metadata(
      abstractText: json['abstract_text'] as String?,
      additional: json['additional'] as Map<String, dynamic>?,
      authors:
          (json['authors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      category: json['category'] as String?,
      createdAt: json['created_at'] as String?,
      createdBy: json['created_by'] as String?,
      documentVersion: json['document_version'] as String?,
      extractionDurationMs: (json['extraction_duration_ms'] as num?)?.toInt(),
      keywords: (json['keywords'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      language: json['language'] as String?,
      modifiedAt: json['modified_at'] as String?,
      modifiedBy: json['modified_by'] as String?,
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
      'extraction_duration_ms': instance.extractionDurationMs,
      'keywords': instance.keywords,
      'language': instance.language,
      'modified_at': instance.modifiedAt,
      'modified_by': instance.modifiedBy,
      'output_format': instance.outputFormat,
      'pages': instance.pages,
      'subject': instance.subject,
      'tags': instance.tags,
      'title': instance.title,
    };
