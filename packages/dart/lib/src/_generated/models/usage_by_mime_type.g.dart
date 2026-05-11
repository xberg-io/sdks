// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usage_by_mime_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UsageByMimeType _$UsageByMimeTypeFromJson(Map<String, dynamic> json) =>
    _UsageByMimeType(
      documents: (json['documents'] as num).toInt(),
      failed: (json['failed'] as num).toInt(),
      pages: (json['pages'] as num).toInt(),
    );

Map<String, dynamic> _$UsageByMimeTypeToJson(_UsageByMimeType instance) =>
    <String, dynamic>{
      'documents': instance.documents,
      'failed': instance.failed,
      'pages': instance.pages,
    };
