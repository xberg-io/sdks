// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout_region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LayoutRegion _$LayoutRegionFromJson(Map<String, dynamic> json) =>
    _LayoutRegion(
      areaFraction: (json['area_fraction'] as num).toDouble(),
      boundingBox: BoundingBox.fromJson(
        json['bounding_box'] as Map<String, dynamic>,
      ),
      className: json['class_name'] as String,
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$LayoutRegionToJson(_LayoutRegion instance) =>
    <String, dynamic>{
      'area_fraction': instance.areaFraction,
      'bounding_box': instance.boundingBox,
      'class_name': instance.className,
      'confidence': instance.confidence,
    };
