// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crawl_job_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CrawlJobResponse _$CrawlJobResponseFromJson(Map<String, dynamic> json) =>
    _CrawlJobResponse(
      createdAt: DateTime.parse(json['created_at'] as String),
      id: json['id'] as String,
      outputMode: json['output_mode'] as String,
      progress: CrawlProgress.fromJson(
        json['progress'] as Map<String, dynamic>,
      ),
      seedUrls: (json['seed_urls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      status: CrawlJobStatus.fromJson(json['status'] as String),
      jobs: (json['jobs'] as List<dynamic>?)
          ?.map((e) => CrawlChildJob.fromJson(e as Map<String, dynamic>))
          .toList(),
      pages: (json['pages'] as List<dynamic>?)
          ?.map((e) => CrawledPage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CrawlJobResponseToJson(_CrawlJobResponse instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'id': instance.id,
      'output_mode': instance.outputMode,
      'progress': instance.progress,
      'seed_urls': instance.seedUrls,
      'status': instance.status,
      'jobs': instance.jobs,
      'pages': instance.pages,
    };
