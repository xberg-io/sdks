// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'crawl_progress.freezed.dart';
part 'crawl_progress.g.dart';

/// Crawl progress counters
@Freezed()
abstract class CrawlProgress with _$CrawlProgress {
  const factory CrawlProgress({
    @JsonKey(name: 'documents_discovered')
    required int documentsDiscovered,
    @JsonKey(name: 'documents_extracted')
    required int documentsExtracted,
    @JsonKey(name: 'documents_failed')
    required int documentsFailed,
    @JsonKey(name: 'pages_crawled')
    required int pagesCrawled,
  }) = _CrawlProgress;
  
  factory CrawlProgress.fromJson(Map<String, Object?> json) => _$CrawlProgressFromJson(json);
}
