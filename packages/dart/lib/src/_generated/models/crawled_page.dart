// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'crawled_page.freezed.dart';
part 'crawled_page.g.dart';

/// A raw crawled page persisted for output_mode=scrape|crawl.
@Freezed()
abstract class CrawledPage with _$CrawledPage {
  const factory CrawledPage({
    /// Fetch timestamp (RFC3339)
    @JsonKey(name: 'fetched_at')
    required DateTime fetchedAt,

    /// Fetch status: "completed" | "failed"
    required String status,

    /// Source URL
    required String url,

    /// Presigned URL for downloading the raw content
    @JsonKey(name: 'content_url')
    String? contentUrl,

    /// Error message (when status=failed)
    String? error,

    /// MIME type
    @JsonKey(name: 'mime_type')
    String? mimeType,

    /// Size in bytes
    @JsonKey(name: 'size_bytes')
    int? sizeBytes,
  }) = _CrawledPage;
  
  factory CrawledPage.fromJson(Map<String, Object?> json) => _$CrawledPageFromJson(json);
}
