// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'crawl_child_job.dart';
import 'crawl_job_status.dart';
import 'crawl_progress.dart';
import 'crawled_page.dart';

part 'crawl_job_response.freezed.dart';
part 'crawl_job_response.g.dart';

/// Response for crawl job status query
@Freezed()
abstract class CrawlJobResponse with _$CrawlJobResponse {
  const factory CrawlJobResponse({
    /// Creation timestamp (RFC3339)
    @JsonKey(name: 'created_at')
    required DateTime createdAt,

    /// Crawl job ID
    required String id,

    /// Output mode this job was submitted with (scrape, crawl, or extract)
    @JsonKey(name: 'output_mode')
    required String outputMode,

    /// Crawl progress counters
    required CrawlProgress progress,

    /// Seed URLs that were submitted
    @JsonKey(name: 'seed_urls')
    required List<String> seedUrls,

    /// Crawl job status
    required CrawlJobStatus status,

    /// Child extraction jobs (populated when output_mode=extract)
    List<CrawlChildJob>? jobs,

    /// Crawled raw pages (populated when output_mode=scrape|crawl)
    List<CrawledPage>? pages,
  }) = _CrawlJobResponse;
  
  factory CrawlJobResponse.fromJson(Map<String, Object?> json) => _$CrawlJobResponseFromJson(json);
}
