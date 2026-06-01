// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'crawl_config.dart';

part 'url_input.freezed.dart';
part 'url_input.g.dart';

/// URL input for crawl-based extraction
@Freezed()
abstract class UrlInput with _$UrlInput {
  const factory UrlInput({
    /// URL to crawl and extract documents from
    required String url,

    /// Per-URL crawl config override (merged with top-level crawl_config)
    @JsonKey(name: 'crawl_config')
    CrawlConfig? crawlConfig,
  }) = _UrlInput;
  
  factory UrlInput.fromJson(Map<String, Object?> json) => _$UrlInputFromJson(json);
}
