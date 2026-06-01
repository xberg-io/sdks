// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'djot_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DjotLink _$DjotLinkFromJson(Map<String, dynamic> json) => _DjotLink(
  text: json['text'] as String,
  url: json['url'] as String,
  attributes: json['attributes'] == null
      ? null
      : Attributes.fromJson(json['attributes'] as Map<String, dynamic>),
  title: json['title'] as String?,
);

Map<String, dynamic> _$DjotLinkToJson(_DjotLink instance) => <String, dynamic>{
  'text': instance.text,
  'url': instance.url,
  'attributes': instance.attributes,
  'title': instance.title,
};
