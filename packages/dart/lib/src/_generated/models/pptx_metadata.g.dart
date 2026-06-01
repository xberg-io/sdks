// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pptx_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PptxMetadata _$PptxMetadataFromJson(Map<String, dynamic> json) =>
    _PptxMetadata(
      slideCount: (json['slide_count'] as num).toInt(),
      slideNames: (json['slide_names'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      imageCount: (json['image_count'] as num?)?.toInt(),
      tableCount: (json['table_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PptxMetadataToJson(_PptxMetadata instance) =>
    <String, dynamic>{
      'slide_count': instance.slideCount,
      'slide_names': instance.slideNames,
      'image_count': instance.imageCount,
      'table_count': instance.tableCount,
    };
