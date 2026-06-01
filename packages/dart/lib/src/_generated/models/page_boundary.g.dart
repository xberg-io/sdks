// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_boundary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PageBoundary _$PageBoundaryFromJson(Map<String, dynamic> json) =>
    _PageBoundary(
      byteEnd: (json['byte_end'] as num).toInt(),
      byteStart: (json['byte_start'] as num).toInt(),
      pageNumber: (json['page_number'] as num).toInt(),
    );

Map<String, dynamic> _$PageBoundaryToJson(_PageBoundary instance) =>
    <String, dynamic>{
      'byte_end': instance.byteEnd,
      'byte_start': instance.byteStart,
      'page_number': instance.pageNumber,
    };
