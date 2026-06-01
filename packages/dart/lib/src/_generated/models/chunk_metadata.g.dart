// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chunk_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChunkMetadata _$ChunkMetadataFromJson(Map<String, dynamic> json) =>
    _ChunkMetadata(
      byteEnd: (json['byte_end'] as num).toInt(),
      byteStart: (json['byte_start'] as num).toInt(),
      chunkIndex: (json['chunk_index'] as num).toInt(),
      totalChunks: (json['total_chunks'] as num).toInt(),
      firstPage: (json['first_page'] as num?)?.toInt(),
      headingContext: json['heading_context'] == null
          ? null
          : HeadingContext.fromJson(
              json['heading_context'] as Map<String, dynamic>,
            ),
      imageIndices: (json['image_indices'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      lastPage: (json['last_page'] as num?)?.toInt(),
      tokenCount: (json['token_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ChunkMetadataToJson(_ChunkMetadata instance) =>
    <String, dynamic>{
      'byte_end': instance.byteEnd,
      'byte_start': instance.byteStart,
      'chunk_index': instance.chunkIndex,
      'total_chunks': instance.totalChunks,
      'first_page': instance.firstPage,
      'heading_context': instance.headingContext,
      'image_indices': instance.imageIndices,
      'last_page': instance.lastPage,
      'token_count': instance.tokenCount,
    };
