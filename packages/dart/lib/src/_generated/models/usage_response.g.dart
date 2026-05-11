// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usage_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UsageResponse _$UsageResponseFromJson(Map<String, dynamic> json) =>
    _UsageResponse(
      byMimeType: (json['by_mime_type'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, UsageByMimeType.fromJson(e as Map<String, dynamic>)),
      ),
      periodEnd: json['period_end'] as String,
      periodStart: json['period_start'] as String,
      totalDocuments: (json['total_documents'] as num).toInt(),
      totalFailed: (json['total_failed'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
      quotaLimit: (json['quota_limit'] as num?)?.toInt(),
      quotaRemaining: (json['quota_remaining'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UsageResponseToJson(_UsageResponse instance) =>
    <String, dynamic>{
      'by_mime_type': instance.byMimeType,
      'period_end': instance.periodEnd,
      'period_start': instance.periodStart,
      'total_documents': instance.totalDocuments,
      'total_failed': instance.totalFailed,
      'total_pages': instance.totalPages,
      'quota_limit': instance.quotaLimit,
      'quota_remaining': instance.quotaRemaining,
    };
