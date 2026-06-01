// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'crawl_config.dart';
import 'document_input.dart';
import 'extraction_options.dart';
import 'url_input.dart';
import 'webhook_config.dart';

part 'extract_json_request.freezed.dart';
part 'extract_json_request.g.dart';

/// JSON body for `POST /v1/extract`
@Freezed()
abstract class ExtractJsonRequest with _$ExtractJsonRequest {
  const factory ExtractJsonRequest({
    /// Crawl configuration (applies to all URLs, can be overridden per-URL)
    @JsonKey(name: 'crawl_config')
    CrawlConfig? crawlConfig,

    /// Documents to process
    List<DocumentInput>? documents,

    /// Extraction options (optional)
    ExtractionOptions? options,

    /// URLs to crawl and extract documents from
    List<UrlInput>? urls,

    /// Webhook configuration for async result delivery (optional)
    WebhookConfig? webhook,
  }) = _ExtractJsonRequest;
  
  factory ExtractJsonRequest.fromJson(Map<String, Object?> json) => _$ExtractJsonRequestFromJson(json);
}
