// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocr_bounding_geometry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OcrBoundingGeometryRectangle _$OcrBoundingGeometryRectangleFromJson(
  Map<String, dynamic> json,
) => OcrBoundingGeometryRectangle(
  left: (json['left'] as num).toInt(),
  top: (json['top'] as num).toInt(),
  width: (json['width'] as num).toInt(),
  height: (json['height'] as num).toInt(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$OcrBoundingGeometryRectangleToJson(
  OcrBoundingGeometryRectangle instance,
) => <String, dynamic>{
  'left': instance.left,
  'top': instance.top,
  'width': instance.width,
  'height': instance.height,
  'type': instance.$type,
};

OcrBoundingGeometryQuadrilateral _$OcrBoundingGeometryQuadrilateralFromJson(
  Map<String, dynamic> json,
) => OcrBoundingGeometryQuadrilateral(
  points: (json['points'] as List<dynamic>)
      .map((e) => (e as List<dynamic>).map((e) => (e as num).toInt()).toList())
      .toList(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$OcrBoundingGeometryQuadrilateralToJson(
  OcrBoundingGeometryQuadrilateral instance,
) => <String, dynamic>{'points': instance.points, 'type': instance.$type};
