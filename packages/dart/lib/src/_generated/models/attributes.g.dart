// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Attributes _$AttributesFromJson(Map<String, dynamic> json) => _Attributes(
  classes: (json['classes'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  id: json['id'] as String?,
  keyValues: (json['key_values'] as List<dynamic>?)
      ?.map((e) => (e as List<dynamic>).map((e) => e as String).toList())
      .toList(),
);

Map<String, dynamic> _$AttributesToJson(_Attributes instance) =>
    <String, dynamic>{
      'classes': instance.classes,
      'id': instance.id,
      'key_values': instance.keyValues,
    };
