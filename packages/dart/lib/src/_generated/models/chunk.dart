// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'chunk_metadata.dart';
import 'chunk_type.dart';

part 'chunk.freezed.dart';
part 'chunk.g.dart';

/// A text chunk with optional embedding and metadata.
///
/// Chunks are created when chunking is enabled in `ExtractionConfig`. Each chunk.
/// contains the text content, optional embedding vector (if embedding generation.
/// is configured), and metadata about its position in the document.
@Freezed()
abstract class Chunk with _$Chunk {
  const factory Chunk({
    /// The text content of this chunk.
    required String content,

    /// Metadata about this chunk's position and properties.
    required ChunkMetadata metadata,

    /// Semantic structural classification of this chunk.
    ///
    /// Assigned by the heuristic classifier based on content patterns and.
    /// heading context. Defaults to `ChunkType::Unknown` when no rule matches.
    @JsonKey(name: 'chunk_type')
    ChunkType? chunkType,

    /// Optional embedding vector for this chunk.
    ///
    /// Only populated when `EmbeddingConfig` is provided in chunking configuration.
    /// The dimensionality depends on the chosen embedding model.
    List<double>? embedding,
  }) = _Chunk;
  
  factory Chunk.fromJson(Map<String, Object?> json) => _$ChunkFromJson(json);
}
