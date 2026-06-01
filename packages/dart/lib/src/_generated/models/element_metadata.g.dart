// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'element_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ElementMetadata _$ElementMetadataFromJson(Map<String, dynamic> json) =>
    _ElementMetadata(
      additional: Map<String, String>.from(json['additional'] as Map),
      coordinates: json['coordinates'] == null
          ? null
          : BoundingBox.fromJson(json['coordinates'] as Map<String, dynamic>),
      elementIndex: (json['element_index'] as num?)?.toInt(),
      filename: json['filename'] as String?,
      pageNumber: (json['page_number'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ElementMetadataToJson(_ElementMetadata instance) =>
    <String, dynamic>{
      'additional': instance.additional,
      'coordinates': instance.coordinates,
      'element_index': instance.elementIndex,
      'filename': instance.filename,
      'page_number': instance.pageNumber,
    };
