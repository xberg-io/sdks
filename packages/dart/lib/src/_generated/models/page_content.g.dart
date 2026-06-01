// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PageContent _$PageContentFromJson(Map<String, dynamic> json) => _PageContent(
  content: json['content'] as String,
  pageNumber: (json['page_number'] as num).toInt(),
  hierarchy: json['hierarchy'] == null
      ? null
      : PageHierarchy.fromJson(json['hierarchy'] as Map<String, dynamic>),
  imageIndices: (json['image_indices'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  isBlank: json['is_blank'] as bool?,
  layoutRegions: (json['layout_regions'] as List<dynamic>?)
      ?.map((e) => LayoutRegion.fromJson(e as Map<String, dynamic>))
      .toList(),
  sectionName: json['section_name'] as String?,
  sheetName: json['sheet_name'] as String?,
  speakerNotes: json['speaker_notes'] as String?,
  tables: (json['tables'] as List<dynamic>?)
      ?.map((e) => Table.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PageContentToJson(_PageContent instance) =>
    <String, dynamic>{
      'content': instance.content,
      'page_number': instance.pageNumber,
      'hierarchy': instance.hierarchy,
      'image_indices': instance.imageIndices,
      'is_blank': instance.isBlank,
      'layout_regions': instance.layoutRegions,
      'section_name': instance.sectionName,
      'sheet_name': instance.sheetName,
      'speaker_notes': instance.speakerNotes,
      'tables': instance.tables,
    };
