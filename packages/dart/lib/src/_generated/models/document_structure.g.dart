// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_structure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DocumentStructure _$DocumentStructureFromJson(Map<String, dynamic> json) =>
    _DocumentStructure(
      nodes: (json['nodes'] as List<dynamic>)
          .map((e) => DocumentNode.fromJson(e as Map<String, dynamic>))
          .toList(),
      nodeTypes: (json['node_types'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      relationships: (json['relationships'] as List<dynamic>?)
          ?.map((e) => DocumentRelationship.fromJson(e as Map<String, dynamic>))
          .toList(),
      sourceFormat: json['source_format'] as String?,
    );

Map<String, dynamic> _$DocumentStructureToJson(_DocumentStructure instance) =>
    <String, dynamic>{
      'nodes': instance.nodes,
      'node_types': instance.nodeTypes,
      'relationships': instance.relationships,
      'source_format': instance.sourceFormat,
    };
