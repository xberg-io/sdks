// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TextMetadata _$TextMetadataFromJson(Map<String, dynamic> json) =>
    _TextMetadata(
      characterCount: (json['character_count'] as num).toInt(),
      lineCount: (json['line_count'] as num).toInt(),
      wordCount: (json['word_count'] as num).toInt(),
      codeBlocks: (json['code_blocks'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
      headers: (json['headers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
    );

Map<String, dynamic> _$TextMetadataToJson(_TextMetadata instance) =>
    <String, dynamic>{
      'character_count': instance.characterCount,
      'line_count': instance.lineCount,
      'word_count': instance.wordCount,
      'code_blocks': instance.codeBlocks,
      'headers': instance.headers,
      'links': instance.links,
    };
