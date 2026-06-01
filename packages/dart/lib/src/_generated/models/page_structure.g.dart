// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_structure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PageStructure _$PageStructureFromJson(Map<String, dynamic> json) =>
    _PageStructure(
      totalCount: (json['total_count'] as num).toInt(),
      unitType: PageUnitType.fromJson(json['unit_type'] as String),
      boundaries: (json['boundaries'] as List<dynamic>?)
          ?.map((e) => PageBoundary.fromJson(e as Map<String, dynamic>))
          .toList(),
      pages: (json['pages'] as List<dynamic>?)
          ?.map((e) => PageInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PageStructureToJson(_PageStructure instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'unit_type': instance.unitType,
      'boundaries': instance.boundaries,
      'pages': instance.pages,
    };
