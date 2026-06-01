// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ImageMetadata _$ImageMetadataFromJson(Map<String, dynamic> json) =>
    _ImageMetadata(
      exif: Map<String, String>.from(json['exif'] as Map),
      format: json['format'] as String,
      height: (json['height'] as num).toInt(),
      width: (json['width'] as num).toInt(),
    );

Map<String, dynamic> _$ImageMetadataToJson(_ImageMetadata instance) =>
    <String, dynamic>{
      'exif': instance.exif,
      'format': instance.format,
      'height': instance.height,
      'width': instance.width,
    };
