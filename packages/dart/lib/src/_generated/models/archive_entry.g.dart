// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archive_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ArchiveEntry _$ArchiveEntryFromJson(Map<String, dynamic> json) =>
    _ArchiveEntry(
      mimeType: json['mime_type'] as String,
      path: json['path'] as String,
      result: ExtractionResult.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ArchiveEntryToJson(_ArchiveEntry instance) =>
    <String, dynamic>{
      'mime_type': instance.mimeType,
      'path': instance.path,
      'result': instance.result,
    };
