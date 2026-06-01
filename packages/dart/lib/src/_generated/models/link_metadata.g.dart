// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LinkMetadata _$LinkMetadataFromJson(Map<String, dynamic> json) =>
    _LinkMetadata(
      attributes: (json['attributes'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
      href: json['href'] as String,
      linkType: LinkType.fromJson(json['link_type'] as String),
      rel: (json['rel'] as List<dynamic>).map((e) => e as String).toList(),
      text: json['text'] as String,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$LinkMetadataToJson(_LinkMetadata instance) =>
    <String, dynamic>{
      'attributes': instance.attributes,
      'href': instance.href,
      'link_type': instance.linkType,
      'rel': instance.rel,
      'text': instance.text,
      'title': instance.title,
    };
