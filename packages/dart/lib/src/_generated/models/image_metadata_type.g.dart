// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_metadata_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ImageMetadataType _$ImageMetadataTypeFromJson(Map<String, dynamic> json) =>
    _ImageMetadataType(
      attributes: (json['attributes'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
      imageType: ImageType.fromJson(json['image_type'] as String),
      src: json['src'] as String,
      alt: json['alt'] as String?,
      dimensions: (json['dimensions'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$ImageMetadataTypeToJson(_ImageMetadataType instance) =>
    <String, dynamic>{
      'attributes': instance.attributes,
      'image_type': instance.imageType,
      'src': instance.src,
      'alt': instance.alt,
      'dimensions': instance.dimensions,
      'title': instance.title,
    };
