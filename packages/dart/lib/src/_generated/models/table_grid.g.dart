// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_grid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TableGrid _$TableGridFromJson(Map<String, dynamic> json) => _TableGrid(
  cells: (json['cells'] as List<dynamic>)
      .map((e) => GridCell.fromJson(e as Map<String, dynamic>))
      .toList(),
  cols: (json['cols'] as num).toInt(),
  rows: (json['rows'] as num).toInt(),
);

Map<String, dynamic> _$TableGridToJson(_TableGrid instance) =>
    <String, dynamic>{
      'cells': instance.cells,
      'cols': instance.cols,
      'rows': instance.rows,
    };
