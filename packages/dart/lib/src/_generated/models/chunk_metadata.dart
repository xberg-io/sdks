// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'heading_context.dart';

part 'chunk_metadata.freezed.dart';
part 'chunk_metadata.g.dart';

/// Metadata about a chunk's position in the original document.
@Freezed()
abstract class ChunkMetadata with _$ChunkMetadata {
  const factory ChunkMetadata({
    /// Byte offset where this chunk ends in the original text (UTF-8 valid boundary).
    @JsonKey(name: 'byte_end') required int byteEnd,

    /// Byte offset where this chunk starts in the original text (UTF-8 valid boundary).
    @JsonKey(name: 'byte_start') required int byteStart,

    /// Zero-based index of this chunk in the document.
    @JsonKey(name: 'chunk_index') required int chunkIndex,

    /// Total number of chunks in the document.
    @JsonKey(name: 'total_chunks') required int totalChunks,

    /// First page number this chunk spans (1-indexed).
    ///
    /// Only populated when page tracking is enabled in extraction configuration.
    @JsonKey(name: 'first_page') int? firstPage,

    /// Heading context when using Markdown chunker.
    ///
    /// Contains the heading hierarchy this chunk falls under.
    /// Only populated when `ChunkerType::Markdown` is used.
    @JsonKey(name: 'heading_context') HeadingContext? headingContext,

    /// Indices into `ExtractionResult.images` for images on pages covered by this chunk.
    ///
    /// Contains zero-based indices into the top-level `images` collection for every.
    /// image whose `page_number` falls within `[first_page, last_page]`.
    /// Empty when image extraction is disabled or the chunk spans no pages with images.
    @JsonKey(name: 'image_indices') List<int>? imageIndices,

    /// Last page number this chunk spans (1-indexed, equal to first_page for single-page chunks).
    ///
    /// Only populated when page tracking is enabled in extraction configuration.
    @JsonKey(name: 'last_page') int? lastPage,

    /// Number of tokens in this chunk (if available).
    ///
    /// This is calculated by the embedding model's tokenizer if embeddings are enabled.
    @JsonKey(name: 'token_count') int? tokenCount,
  }) = _ChunkMetadata;

  factory ChunkMetadata.fromJson(Map<String, Object?> json) =>
      _$ChunkMetadataFromJson(json);
}
