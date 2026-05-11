// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chunk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Chunk _$ChunkFromJson(Map<String, dynamic> json) => _Chunk(
      content: json['content'] as String?,
      embedding: (json['embedding'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      metadata: json['metadata'] == null
          ? null
          : ChunkMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChunkToJson(_Chunk instance) => <String, dynamic>{
      'content': instance.content,
      'embedding': instance.embedding,
      'metadata': instance.metadata,
    };
