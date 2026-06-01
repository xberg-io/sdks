// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xml_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_XmlMetadata _$XmlMetadataFromJson(Map<String, dynamic> json) => _XmlMetadata(
  elementCount: (json['element_count'] as num).toInt(),
  uniqueElements: (json['unique_elements'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$XmlMetadataToJson(_XmlMetadata instance) =>
    <String, dynamic>{
      'element_count': instance.elementCount,
      'unique_elements': instance.uniqueElements,
    };
