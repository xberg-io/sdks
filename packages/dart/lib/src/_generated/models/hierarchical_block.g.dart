// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hierarchical_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HierarchicalBlock _$HierarchicalBlockFromJson(Map<String, dynamic> json) =>
    _HierarchicalBlock(
      fontSize: (json['font_size'] as num).toDouble(),
      level: json['level'] as String,
      text: json['text'] as String,
      bbox: (json['bbox'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$HierarchicalBlockToJson(_HierarchicalBlock instance) =>
    <String, dynamic>{
      'font_size': instance.fontSize,
      'level': instance.level,
      'text': instance.text,
      'bbox': instance.bbox,
    };
