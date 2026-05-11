// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chunk_metadata.freezed.dart';
part 'chunk_metadata.g.dart';

/// Chunk position and size metadata.
@Freezed()
abstract class ChunkMetadata with _$ChunkMetadata {
  const factory ChunkMetadata({
    @JsonKey(name: 'byte_end')
    required int byteEnd,
    @JsonKey(name: 'byte_start')
    required int byteStart,
    @JsonKey(name: 'chunk_index')
    required int chunkIndex,
    @JsonKey(name: 'total_chunks')
    required int totalChunks,
    @JsonKey(name: 'first_page')
    int? firstPage,
    @JsonKey(name: 'last_page')
    int? lastPage,
    @JsonKey(name: 'token_count')
    int? tokenCount,
  }) = _ChunkMetadata;
  
  factory ChunkMetadata.fromJson(Map<String, Object?> json) => _$ChunkMetadataFromJson(json);
}
