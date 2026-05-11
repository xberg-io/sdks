// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PageConfig _$PageConfigFromJson(Map<String, dynamic> json) => _PageConfig(
      extractPages: json['extract_pages'] as bool?,
      insertPageMarkers: json['insert_page_markers'] as bool?,
      markerFormat: json['marker_format'] as String?,
    );

Map<String, dynamic> _$PageConfigToJson(_PageConfig instance) =>
    <String, dynamic>{
      'extract_pages': instance.extractPages,
      'insert_page_markers': instance.insertPageMarkers,
      'marker_format': instance.markerFormat,
    };
