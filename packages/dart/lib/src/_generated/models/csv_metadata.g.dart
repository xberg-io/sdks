// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'csv_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CsvMetadata _$CsvMetadataFromJson(Map<String, dynamic> json) => _CsvMetadata(
  columnCount: (json['column_count'] as num).toInt(),
  hasHeader: json['has_header'] as bool,
  rowCount: (json['row_count'] as num).toInt(),
  columnTypes: (json['column_types'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  delimiter: json['delimiter'] as String?,
);

Map<String, dynamic> _$CsvMetadataToJson(_CsvMetadata instance) =>
    <String, dynamic>{
      'column_count': instance.columnCount,
      'has_header': instance.hasHeader,
      'row_count': instance.rowCount,
      'column_types': instance.columnTypes,
      'delimiter': instance.delimiter,
    };
