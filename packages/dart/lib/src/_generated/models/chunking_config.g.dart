// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chunking_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChunkingConfig _$ChunkingConfigFromJson(Map<String, dynamic> json) =>
    _ChunkingConfig(
      chunkerType: json['chunker_type'] as String?,
      embedding: json['embedding'] == null
          ? null
          : EmbeddingConfig.fromJson(json['embedding'] as Map<String, dynamic>),
      maxCharacters: (json['max_characters'] as num?)?.toInt(),
      overlap: (json['overlap'] as num?)?.toInt(),
      preset: json['preset'] as String?,
      trim: json['trim'] as bool?,
    );

Map<String, dynamic> _$ChunkingConfigToJson(_ChunkingConfig instance) =>
    <String, dynamic>{
      'chunker_type': instance.chunkerType,
      'embedding': instance.embedding,
      'max_characters': instance.maxCharacters,
      'overlap': instance.overlap,
      'preset': instance.preset,
      'trim': instance.trim,
    };
