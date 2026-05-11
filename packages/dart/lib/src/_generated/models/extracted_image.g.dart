// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extracted_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExtractedImage _$ExtractedImageFromJson(Map<String, dynamic> json) =>
    _ExtractedImage(
      boundingBox: json['bounding_box'] == null
          ? null
          : BoundingBox.fromJson(json['bounding_box'] as Map<String, dynamic>),
      data: json['data'] as String?,
      description: json['description'] as String?,
      format: json['format'] as String?,
      height: (json['height'] as num?)?.toInt(),
      imageIndex: (json['image_index'] as num?)?.toInt(),
      pageNumber: (json['page_number'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ExtractedImageToJson(_ExtractedImage instance) =>
    <String, dynamic>{
      'bounding_box': instance.boundingBox,
      'data': instance.data,
      'description': instance.description,
      'format': instance.format,
      'height': instance.height,
      'image_index': instance.imageIndex,
      'page_number': instance.pageNumber,
      'width': instance.width,
    };
