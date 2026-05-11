// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'chunk_metadata.dart';

part 'chunk.freezed.dart';
part 'chunk.g.dart';

/// Text chunk with optional embedding.
@Freezed()
abstract class Chunk with _$Chunk {
  const factory Chunk({
    /// Chunk text content
    String? content,

    /// Embedding vector (when embedding is enabled)
    List<double>? embedding,

    /// Chunk position metadata
    ChunkMetadata? metadata,
  }) = _Chunk;
  
  factory Chunk.fromJson(Map<String, Object?> json) => _$ChunkFromJson(json);
}
