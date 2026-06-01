// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crawl_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CrawlConfig _$CrawlConfigFromJson(Map<String, dynamic> json) => _CrawlConfig(
  allowSubdomains: json['allow_subdomains'] as bool?,
  allowedFileTypes: (json['allowed_file_types'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  browser: json['browser'] == null
      ? null
      : BrowserOverrides.fromJson(json['browser'] as Map<String, dynamic>),
  bypass: json['bypass'] == null
      ? null
      : BypassRequestOverride.fromJson(json['bypass'] as Map<String, dynamic>),
  documentUrlDepth: (json['document_url_depth'] as num?)?.toInt(),
  excludePaths: (json['exclude_paths'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  extractPageContent: json['extract_page_content'] as bool?,
  followDocumentUrls: json['follow_document_urls'] as bool?,
  includePaths: (json['include_paths'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  maxConcurrent: (json['max_concurrent'] as num?)?.toInt(),
  maxDepth: (json['max_depth'] as num?)?.toInt(),
  maxPages: (json['max_pages'] as num?)?.toInt(),
  outputMode: json['output_mode'] as String?,
  proxy: json['proxy'] == null
      ? null
      : ProxyOverride.fromJson(json['proxy'] as Map<String, dynamic>),
  requestTimeoutSecs: (json['request_timeout_secs'] as num?)?.toInt(),
  respectRobotsTxt: json['respect_robots_txt'] as bool?,
  stayOnDomain: json['stay_on_domain'] as bool?,
  strategy: json['strategy'] as String?,
  userAgent: json['user_agent'] as String?,
);

Map<String, dynamic> _$CrawlConfigToJson(_CrawlConfig instance) =>
    <String, dynamic>{
      'allow_subdomains': instance.allowSubdomains,
      'allowed_file_types': instance.allowedFileTypes,
      'browser': instance.browser,
      'bypass': instance.bypass,
      'document_url_depth': instance.documentUrlDepth,
      'exclude_paths': instance.excludePaths,
      'extract_page_content': instance.extractPageContent,
      'follow_document_urls': instance.followDocumentUrls,
      'include_paths': instance.includePaths,
      'max_concurrent': instance.maxConcurrent,
      'max_depth': instance.maxDepth,
      'max_pages': instance.maxPages,
      'output_mode': instance.outputMode,
      'proxy': instance.proxy,
      'request_timeout_secs': instance.requestTimeoutSecs,
      'respect_robots_txt': instance.respectRobotsTxt,
      'stay_on_domain': instance.stayOnDomain,
      'strategy': instance.strategy,
      'user_agent': instance.userAgent,
    };
