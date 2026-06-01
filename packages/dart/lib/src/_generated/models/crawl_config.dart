// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'browser_overrides.dart';
import 'bypass_request_override.dart';
import 'proxy_override.dart';

part 'crawl_config.freezed.dart';
part 'crawl_config.g.dart';

/// Crawl policy configuration — controls URL crawling behavior.
@Freezed()
abstract class CrawlConfig with _$CrawlConfig {
  const factory CrawlConfig({
    /// Allow subdomains of the seed domain (default: true)
    @JsonKey(name: 'allow_subdomains')
    bool? allowSubdomains,

    /// MIME types of documents to extract (default: all supported by kreuzberg)
    @JsonKey(name: 'allowed_file_types')
    List<String>? allowedFileTypes,

    /// Browser rendering configuration overrides for this request
    BrowserOverrides? browser,

    /// Per-request bypass override. When set, applies an external bypass.
    /// provider to bypass WAF/antibot on the crawl.
    BypassRequestOverride? bypass,

    /// Max depth for URL-following from documents (default: 1, max: 3)
    @JsonKey(name: 'document_url_depth')
    int? documentUrlDepth,

    /// Regex patterns — skip URLs matching these
    @JsonKey(name: 'exclude_paths')
    List<String>? excludePaths,

    /// Also extract the HTML page content as markdown (default: false)
    @JsonKey(name: 'extract_page_content')
    bool? extractPageContent,

    /// Follow URLs discovered inside extracted documents (default: false)
    @JsonKey(name: 'follow_document_urls')
    bool? followDocumentUrls,

    /// Regex patterns — only crawl URLs matching these
    @JsonKey(name: 'include_paths')
    List<String>? includePaths,

    /// Maximum concurrent requests (default: 10)
    @JsonKey(name: 'max_concurrent')
    int? maxConcurrent,

    /// Maximum crawl depth from seed URL (default: 2, max: 5)
    @JsonKey(name: 'max_depth')
    int? maxDepth,

    /// Maximum pages to crawl (default: 100, max: 10000)
    @JsonKey(name: 'max_pages')
    int? maxPages,

    /// Output mode (default: "extract").
    /// - "scrape":  single-page fetch, no recursion, no extraction.
    /// - "crawl":   multi-page crawl, no extraction (raw content returned).
    /// - "extract": multi-page crawl + extract each discovered document.
    @JsonKey(name: 'output_mode')
    String? outputMode,

    /// Per-request proxy override. When set, this proxy is used for this.
    /// crawl instead of the worker's process-wide proxy pool.
    ProxyOverride? proxy,

    /// Per-request timeout in seconds (default: 30)
    @JsonKey(name: 'request_timeout_secs')
    int? requestTimeoutSecs,

    /// Respect robots.txt (default: true)
    @JsonKey(name: 'respect_robots_txt')
    bool? respectRobotsTxt,

    /// Stay on the same domain as seed URL (default: true)
    @JsonKey(name: 'stay_on_domain')
    bool? stayOnDomain,

    /// Crawl strategy: "bfs" (default), "dfs", "best_first", "adaptive"
    String? strategy,

    /// Custom User-Agent string
    @JsonKey(name: 'user_agent')
    String? userAgent,
  }) = _CrawlConfig;
  
  factory CrawlConfig.fromJson(Map<String, Object?> json) => _$CrawlConfigFromJson(json);
}
