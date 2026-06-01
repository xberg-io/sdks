// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Element _$ElementFromJson(Map<String, dynamic> json) => _Element(
  elementId: json['element_id'] as String,
  elementType: ElementType.fromJson(json['element_type'] as String),
  metadata: ElementMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
  text: json['text'] as String,
);

Map<String, dynamic> _$ElementToJson(_Element instance) => <String, dynamic>{
  'element_id': instance.elementId,
  'element_type': instance.elementType,
  'metadata': instance.metadata,
  'text': instance.text,
};
