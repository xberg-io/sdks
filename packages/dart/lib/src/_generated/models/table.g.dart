// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Table _$TableFromJson(Map<String, dynamic> json) => _Table(
      boundingBox: json['bounding_box'] == null
          ? null
          : BoundingBox.fromJson(json['bounding_box'] as Map<String, dynamic>),
      cells: (json['cells'] as List<dynamic>?)
          ?.map((e) => Row.fromJson(e as Map<String, dynamic>))
          .toList(),
      markdown: json['markdown'] as String?,
      pageNumber: (json['page_number'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TableToJson(_Table instance) => <String, dynamic>{
      'bounding_box': instance.boundingBox,
      'cells': instance.cells,
      'markdown': instance.markdown,
      'page_number': instance.pageNumber,
    };
