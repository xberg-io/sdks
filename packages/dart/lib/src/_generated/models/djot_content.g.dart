// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'djot_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DjotContent _$DjotContentFromJson(Map<String, dynamic> json) => _DjotContent(
  blocks: (json['blocks'] as List<dynamic>)
      .map((e) => FormattedBlock.fromJson(e as Map<String, dynamic>))
      .toList(),
  footnotes: (json['footnotes'] as List<dynamic>)
      .map((e) => Footnote.fromJson(e as Map<String, dynamic>))
      .toList(),
  images: (json['images'] as List<dynamic>)
      .map((e) => DjotImage.fromJson(e as Map<String, dynamic>))
      .toList(),
  links: (json['links'] as List<dynamic>)
      .map((e) => DjotLink.fromJson(e as Map<String, dynamic>))
      .toList(),
  metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
  plainText: json['plain_text'] as String,
  tables: (json['tables'] as List<dynamic>)
      .map((e) => Table.fromJson(e as Map<String, dynamic>))
      .toList(),
  attributes: json['attributes'],
);

Map<String, dynamic> _$DjotContentToJson(_DjotContent instance) =>
    <String, dynamic>{
      'blocks': instance.blocks,
      'footnotes': instance.footnotes,
      'images': instance.images,
      'links': instance.links,
      'metadata': instance.metadata,
      'plain_text': instance.plainText,
      'tables': instance.tables,
      'attributes': instance.attributes,
    };
