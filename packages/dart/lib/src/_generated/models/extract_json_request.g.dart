// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extract_json_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExtractJsonRequest _$ExtractJsonRequestFromJson(Map<String, dynamic> json) =>
    _ExtractJsonRequest(
      crawlConfig: json['crawl_config'] == null
          ? null
          : CrawlConfig.fromJson(json['crawl_config'] as Map<String, dynamic>),
      documents: (json['documents'] as List<dynamic>?)
          ?.map((e) => DocumentInput.fromJson(e as Map<String, dynamic>))
          .toList(),
      options: json['options'] == null
          ? null
          : ExtractionOptions.fromJson(json['options'] as Map<String, dynamic>),
      urls: (json['urls'] as List<dynamic>?)
          ?.map((e) => UrlInput.fromJson(e as Map<String, dynamic>))
          .toList(),
      webhook: json['webhook'] == null
          ? null
          : WebhookConfig.fromJson(json['webhook'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExtractJsonRequestToJson(_ExtractJsonRequest instance) =>
    <String, dynamic>{
      'crawl_config': instance.crawlConfig,
      'documents': instance.documents,
      'options': instance.options,
      'urls': instance.urls,
      'webhook': instance.webhook,
    };
