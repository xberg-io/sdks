// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crawl_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CrawlProgress _$CrawlProgressFromJson(Map<String, dynamic> json) =>
    _CrawlProgress(
      documentsDiscovered: (json['documents_discovered'] as num).toInt(),
      documentsExtracted: (json['documents_extracted'] as num).toInt(),
      documentsFailed: (json['documents_failed'] as num).toInt(),
      pagesCrawled: (json['pages_crawled'] as num).toInt(),
    );

Map<String, dynamic> _$CrawlProgressToJson(_CrawlProgress instance) =>
    <String, dynamic>{
      'documents_discovered': instance.documentsDiscovered,
      'documents_extracted': instance.documentsExtracted,
      'documents_failed': instance.documentsFailed,
      'pages_crawled': instance.pagesCrawled,
    };
