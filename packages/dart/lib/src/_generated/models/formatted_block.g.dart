// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'formatted_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FormattedBlock _$FormattedBlockFromJson(Map<String, dynamic> json) =>
    _FormattedBlock(
      blockType: BlockType.fromJson(json['block_type'] as String),
      inlineContent: (json['inline_content'] as List<dynamic>)
          .map((e) => InlineElement.fromJson(e as Map<String, dynamic>))
          .toList(),
      attributes: json['attributes'] == null
          ? null
          : Attributes.fromJson(json['attributes'] as Map<String, dynamic>),
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => FormattedBlock.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: json['code'] as String?,
      language: json['language'] as String?,
      level: (json['level'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FormattedBlockToJson(_FormattedBlock instance) =>
    <String, dynamic>{
      'block_type': instance.blockType,
      'inline_content': instance.inlineContent,
      'attributes': instance.attributes,
      'children': instance.children,
      'code': instance.code,
      'language': instance.language,
      'level': instance.level,
    };
