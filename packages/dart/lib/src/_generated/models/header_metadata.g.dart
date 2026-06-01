// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'header_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HeaderMetadata _$HeaderMetadataFromJson(Map<String, dynamic> json) =>
    _HeaderMetadata(
      depth: (json['depth'] as num).toInt(),
      htmlOffset: (json['html_offset'] as num).toInt(),
      level: (json['level'] as num).toInt(),
      text: json['text'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$HeaderMetadataToJson(_HeaderMetadata instance) =>
    <String, dynamic>{
      'depth': instance.depth,
      'html_offset': instance.htmlOffset,
      'level': instance.level,
      'text': instance.text,
      'id': instance.id,
    };
