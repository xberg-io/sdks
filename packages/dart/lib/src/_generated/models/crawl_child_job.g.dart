// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crawl_child_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CrawlChildJob _$CrawlChildJobFromJson(Map<String, dynamic> json) =>
    _CrawlChildJob(
      filename: json['filename'] as String,
      id: json['id'] as String,
      status: json['status'] as String,
      bodyBytes: (json['body_bytes'] as num?)?.toInt(),
      processingTimeMs: (json['processing_time_ms'] as num?)?.toInt(),
      result: json['result'] == null
          ? null
          : ExtractionResult.fromJson(json['result'] as Map<String, dynamic>),
      sourceUrl: json['source_url'] as String?,
    );

Map<String, dynamic> _$CrawlChildJobToJson(_CrawlChildJob instance) =>
    <String, dynamic>{
      'filename': instance.filename,
      'id': instance.id,
      'status': instance.status,
      'body_bytes': instance.bodyBytes,
      'processing_time_ms': instance.processingTimeMs,
      'result': instance.result,
      'source_url': instance.sourceUrl,
    };
