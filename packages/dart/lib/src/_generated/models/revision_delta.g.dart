// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revision_delta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RevisionDelta _$RevisionDeltaFromJson(Map<String, dynamic> json) =>
    _RevisionDelta(
      content: (json['content'] as List<dynamic>)
          .map((e) => DiffLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      tableChanges: (json['table_changes'] as List<dynamic>)
          .map((e) => CellChange.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RevisionDeltaToJson(_RevisionDelta instance) =>
    <String, dynamic>{
      'content': instance.content,
      'table_changes': instance.tableChanges,
    };
