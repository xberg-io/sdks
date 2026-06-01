// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'extraction_result.dart';

part 'crawl_child_job.freezed.dart';
part 'crawl_child_job.g.dart';

/// A child extraction job spawned by a crawl job.
@Freezed()
abstract class CrawlChildJob with _$CrawlChildJob {
  const factory CrawlChildJob({
    /// Filename
    required String filename,

    /// Job ID (queryable via GET /v1/jobs/{id})
    required String id,

    /// Job status
    required String status,

    /// Raw body size in bytes of the source document fed to extraction.
    /// For HTML pages this is the rendered HTML length; for binary.
    /// documents it is the downloaded file size. Lets callers detect.
    /// suspiciously small responses (e.g. WAF challenge pages captured.
    /// as the "document" — typically 5–30 KB).
    @JsonKey(name: 'body_bytes') int? bodyBytes,

    /// Processing time in ms (when completed)
    @JsonKey(name: 'processing_time_ms') int? processingTimeMs,

    /// Extraction result (when completed)
    ExtractionResult? result,

    /// Source URL where this document was found
    @JsonKey(name: 'source_url') String? sourceUrl,
  }) = _CrawlChildJob;

  factory CrawlChildJob.fromJson(Map<String, Object?> json) =>
      _$CrawlChildJobFromJson(json);
}
