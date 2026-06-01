// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diff_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DiffResponse _$DiffResponseFromJson(Map<String, dynamic> json) =>
    _DiffResponse(
      computedAt: DateTime.parse(json['computed_at'] as String),
      diff: json['diff'],
      documentId: json['document_id'] as String,
      fromJobId: json['from_job_id'] as String,
      fromVersion: (json['from_version'] as num).toInt(),
      toJobId: json['to_job_id'] as String,
      toVersion: (json['to_version'] as num).toInt(),
    );

Map<String, dynamic> _$DiffResponseToJson(_DiffResponse instance) =>
    <String, dynamic>{
      'computed_at': instance.computedAt.toIso8601String(),
      'diff': instance.diff,
      'document_id': instance.documentId,
      'from_job_id': instance.fromJobId,
      'from_version': instance.fromVersion,
      'to_job_id': instance.toJobId,
      'to_version': instance.toVersion,
    };
