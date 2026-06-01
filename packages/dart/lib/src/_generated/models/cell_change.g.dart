// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cell_change.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CellChange _$CellChangeFromJson(Map<String, dynamic> json) => _CellChange(
  col: (json['col'] as num).toInt(),
  from: json['from'] as String,
  row: (json['row'] as num).toInt(),
  to: json['to'] as String,
);

Map<String, dynamic> _$CellChangeToJson(_CellChange instance) =>
    <String, dynamic>{
      'col': instance.col,
      'from': instance.from,
      'row': instance.row,
      'to': instance.to,
    };
