// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extract_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExtractResponse _$ExtractResponseFromJson(Map<String, dynamic> json) =>
    _ExtractResponse(
      status: json['status'] as String,
      crawlJobIds: (json['crawl_job_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      documents: (json['documents'] as List<dynamic>?)
          ?.map((e) => DocumentSubmission.fromJson(e as Map<String, dynamic>))
          .toList(),
      jobIds: (json['job_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ExtractResponseToJson(_ExtractResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'crawl_job_ids': instance.crawlJobIds,
      'documents': instance.documents,
      'job_ids': instance.jobIds,
    };
