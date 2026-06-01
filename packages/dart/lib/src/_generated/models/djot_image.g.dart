// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'djot_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DjotImage _$DjotImageFromJson(Map<String, dynamic> json) => _DjotImage(
  alt: json['alt'] as String,
  src: json['src'] as String,
  attributes: json['attributes'] == null
      ? null
      : Attributes.fromJson(json['attributes'] as Map<String, dynamic>),
  title: json['title'] as String?,
);

Map<String, dynamic> _$DjotImageToJson(_DjotImage instance) =>
    <String, dynamic>{
      'alt': instance.alt,
      'src': instance.src,
      'attributes': instance.attributes,
      'title': instance.title,
    };
