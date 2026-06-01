// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chunk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Chunk _$ChunkFromJson(Map<String, dynamic> json) => _Chunk(
  content: json['content'] as String,
  metadata: ChunkMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
  chunkType: json['chunk_type'] == null
      ? null
      : ChunkType.fromJson(json['chunk_type'] as String),
  embedding: (json['embedding'] as List<dynamic>?)
      ?.map((e) => (e as num).toDouble())
      .toList(),
);

Map<String, dynamic> _$ChunkToJson(_Chunk instance) => <String, dynamic>{
  'content': instance.content,
  'metadata': instance.metadata,
  'chunk_type': instance.chunkType,
  'embedding': instance.embedding,
};
