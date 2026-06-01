// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'excel_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExcelMetadata _$ExcelMetadataFromJson(Map<String, dynamic> json) =>
    _ExcelMetadata(
      sheetCount: (json['sheet_count'] as num?)?.toInt(),
      sheetNames: (json['sheet_names'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ExcelMetadataToJson(_ExcelMetadata instance) =>
    <String, dynamic>{
      'sheet_count': instance.sheetCount,
      'sheet_names': instance.sheetNames,
    };
