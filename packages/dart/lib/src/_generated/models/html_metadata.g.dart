// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'html_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HtmlMetadata _$HtmlMetadataFromJson(Map<String, dynamic> json) =>
    _HtmlMetadata(
      author: json['author'] as String?,
      baseHref: json['base_href'] as String?,
      canonicalUrl: json['canonical_url'] as String?,
      description: json['description'] as String?,
      headers: (json['headers'] as List<dynamic>?)
          ?.map((e) => HeaderMetadata.fromJson(e as Map<String, dynamic>))
          .toList(),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImageMetadataType.fromJson(e as Map<String, dynamic>))
          .toList(),
      keywords: (json['keywords'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      language: json['language'] as String?,
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => LinkMetadata.fromJson(e as Map<String, dynamic>))
          .toList(),
      metaTags: (json['meta_tags'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      openGraph: (json['open_graph'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      structuredData: (json['structured_data'] as List<dynamic>?)
          ?.map((e) => StructuredData.fromJson(e as Map<String, dynamic>))
          .toList(),
      textDirection: json['text_direction'] == null
          ? null
          : TextDirection.fromJson(json['text_direction'] as String),
      title: json['title'] as String?,
      twitterCard: (json['twitter_card'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$HtmlMetadataToJson(_HtmlMetadata instance) =>
    <String, dynamic>{
      'author': instance.author,
      'base_href': instance.baseHref,
      'canonical_url': instance.canonicalUrl,
      'description': instance.description,
      'headers': instance.headers,
      'images': instance.images,
      'keywords': instance.keywords,
      'language': instance.language,
      'links': instance.links,
      'meta_tags': instance.metaTags,
      'open_graph': instance.openGraph,
      'structured_data': instance.structuredData,
      'text_direction': instance.textDirection,
      'title': instance.title,
      'twitter_card': instance.twitterCard,
    };
