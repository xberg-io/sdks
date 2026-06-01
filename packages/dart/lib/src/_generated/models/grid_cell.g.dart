// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grid_cell.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GridCell _$GridCellFromJson(Map<String, dynamic> json) => _GridCell(
  col: (json['col'] as num).toInt(),
  content: json['content'] as String,
  row: (json['row'] as num).toInt(),
  bbox: json['bbox'] == null
      ? null
      : BoundingBox.fromJson(json['bbox'] as Map<String, dynamic>),
  colSpan: (json['col_span'] as num?)?.toInt(),
  isHeader: json['is_header'] as bool?,
  rowSpan: (json['row_span'] as num?)?.toInt(),
);

Map<String, dynamic> _$GridCellToJson(_GridCell instance) => <String, dynamic>{
  'col': instance.col,
  'content': instance.content,
  'row': instance.row,
  'bbox': instance.bbox,
  'col_span': instance.colSpan,
  'is_header': instance.isHeader,
  'row_span': instance.rowSpan,
};
