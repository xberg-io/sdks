// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobResponse _$JobResponseFromJson(Map<String, dynamic> json) => _JobResponse(
  createdAt: DateTime.parse(json['created_at'] as String),
  filename: json['filename'] as String,
  id: json['id'] as String,
  status: JobStatus.fromJson(json['status'] as String),
  processingTimeMs: (json['processing_time_ms'] as num?)?.toInt(),
  result: json['result'] == null
      ? null
      : ExtractionResult.fromJson(json['result'] as Map<String, dynamic>),
);

Map<String, dynamic> _$JobResponseToJson(_JobResponse instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'filename': instance.filename,
      'id': instance.id,
      'status': instance.status,
      'processing_time_ms': instance.processingTimeMs,
      'result': instance.result,
    };
