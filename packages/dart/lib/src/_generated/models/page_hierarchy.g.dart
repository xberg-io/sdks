// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_hierarchy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PageHierarchy _$PageHierarchyFromJson(Map<String, dynamic> json) =>
    _PageHierarchy(
      blockCount: (json['block_count'] as num).toInt(),
      blocks: (json['blocks'] as List<dynamic>?)
          ?.map((e) => HierarchicalBlock.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PageHierarchyToJson(_PageHierarchy instance) =>
    <String, dynamic>{
      'block_count': instance.blockCount,
      'blocks': instance.blocks,
    };
