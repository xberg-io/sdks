// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_revision.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DocumentRevision _$DocumentRevisionFromJson(Map<String, dynamic> json) =>
    _DocumentRevision(
      delta: RevisionDelta.fromJson(json['delta'] as Map<String, dynamic>),
      kind: RevisionKind.fromJson(json['kind'] as String),
      revisionId: json['revision_id'] as String,
      anchor: json['anchor'] == null
          ? null
          : RevisionAnchor.fromJson(json['anchor'] as Map<String, dynamic>),
      author: json['author'] as String?,
      timestamp: json['timestamp'] as String?,
    );

Map<String, dynamic> _$DocumentRevisionToJson(_DocumentRevision instance) =>
    <String, dynamic>{
      'delta': instance.delta,
      'kind': instance.kind,
      'revision_id': instance.revisionId,
      'anchor': instance.anchor,
      'author': instance.author,
      'timestamp': instance.timestamp,
    };
