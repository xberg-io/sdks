// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Table _$TableFromJson(Map<String, dynamic> json) => _Table(
  cells: (json['cells'] as List<dynamic>)
      .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
      .toList(),
  markdown: json['markdown'] as String,
  pageNumber: (json['page_number'] as num).toInt(),
  boundingBox: json['bounding_box'] == null
      ? null
      : BoundingBox.fromJson(json['bounding_box'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TableToJson(_Table instance) => <String, dynamic>{
  'cells': instance.cells,
  'markdown': instance.markdown,
  'page_number': instance.pageNumber,
  'bounding_box': instance.boundingBox,
};
