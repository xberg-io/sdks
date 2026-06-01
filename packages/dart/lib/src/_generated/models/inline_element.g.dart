// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inline_element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InlineElement _$InlineElementFromJson(Map<String, dynamic> json) =>
    _InlineElement(
      content: json['content'] as String,
      elementType: InlineType.fromJson(json['element_type'] as String),
      attributes: json['attributes'] == null
          ? null
          : Attributes.fromJson(json['attributes'] as Map<String, dynamic>),
      metadata: (json['metadata'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$InlineElementToJson(_InlineElement instance) =>
    <String, dynamic>{
      'content': instance.content,
      'element_type': instance.elementType,
      'attributes': instance.attributes,
      'metadata': instance.metadata,
    };
