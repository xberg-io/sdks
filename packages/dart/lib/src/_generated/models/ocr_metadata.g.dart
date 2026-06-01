// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocr_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OcrMetadata _$OcrMetadataFromJson(Map<String, dynamic> json) => _OcrMetadata(
  language: json['language'] as String,
  outputFormat: json['output_format'] as String,
  psm: (json['psm'] as num).toInt(),
  tableCount: (json['table_count'] as num).toInt(),
  tableCols: (json['table_cols'] as num?)?.toInt(),
  tableRows: (json['table_rows'] as num?)?.toInt(),
);

Map<String, dynamic> _$OcrMetadataToJson(_OcrMetadata instance) =>
    <String, dynamic>{
      'language': instance.language,
      'output_format': instance.outputFormat,
      'psm': instance.psm,
      'table_count': instance.tableCount,
      'table_cols': instance.tableCols,
      'table_rows': instance.tableRows,
    };
