// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_relationship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DocumentRelationship _$DocumentRelationshipFromJson(
  Map<String, dynamic> json,
) => _DocumentRelationship(
  kind: RelationshipKind.fromJson(json['kind'] as String),
  source: (json['source'] as num).toInt(),
  target: (json['target'] as num).toInt(),
);

Map<String, dynamic> _$DocumentRelationshipToJson(
  _DocumentRelationship instance,
) => <String, dynamic>{
  'kind': instance.kind,
  'source': instance.source,
  'target': instance.target,
};
