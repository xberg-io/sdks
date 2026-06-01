// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crawled_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CrawledPage _$CrawledPageFromJson(Map<String, dynamic> json) => _CrawledPage(
  fetchedAt: DateTime.parse(json['fetched_at'] as String),
  status: json['status'] as String,
  url: json['url'] as String,
  contentUrl: json['content_url'] as String?,
  error: json['error'] as String?,
  mimeType: json['mime_type'] as String?,
  sizeBytes: (json['size_bytes'] as num?)?.toInt(),
);

Map<String, dynamic> _$CrawledPageToJson(_CrawledPage instance) =>
    <String, dynamic>{
      'fetched_at': instance.fetchedAt.toIso8601String(),
      'status': instance.status,
      'url': instance.url,
      'content_url': instance.contentUrl,
      'error': instance.error,
      'mime_type': instance.mimeType,
      'size_bytes': instance.sizeBytes,
    };
