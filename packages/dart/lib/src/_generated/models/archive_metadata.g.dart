// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archive_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ArchiveMetadata _$ArchiveMetadataFromJson(Map<String, dynamic> json) =>
    _ArchiveMetadata(
      fileCount: (json['file_count'] as num).toInt(),
      fileList: (json['file_list'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      format: json['format'] as String,
      totalSize: (json['total_size'] as num).toInt(),
      compressedSize: (json['compressed_size'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ArchiveMetadataToJson(_ArchiveMetadata instance) =>
    <String, dynamic>{
      'file_count': instance.fileCount,
      'file_list': instance.fileList,
      'format': instance.format,
      'total_size': instance.totalSize,
      'compressed_size': instance.compressedSize,
    };
