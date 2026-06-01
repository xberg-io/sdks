// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UrlInput _$UrlInputFromJson(Map<String, dynamic> json) => _UrlInput(
  url: json['url'] as String,
  crawlConfig: json['crawl_config'] == null
      ? null
      : CrawlConfig.fromJson(json['crawl_config'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UrlInputToJson(_UrlInput instance) => <String, dynamic>{
  'url': instance.url,
  'crawl_config': instance.crawlConfig,
};
