// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bounding_box.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BoundingBox _$BoundingBoxFromJson(Map<String, dynamic> json) => _BoundingBox(
  x0: (json['x0'] as num).toDouble(),
  x1: (json['x1'] as num).toDouble(),
  y0: (json['y0'] as num).toDouble(),
  y1: (json['y1'] as num).toDouble(),
);

Map<String, dynamic> _$BoundingBoxToJson(_BoundingBox instance) =>
    <String, dynamic>{
      'x0': instance.x0,
      'x1': instance.x1,
      'y0': instance.y0,
      'y1': instance.y1,
    };
