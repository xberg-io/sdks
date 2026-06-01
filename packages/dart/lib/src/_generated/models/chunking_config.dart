// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'embedding_config.dart';

part 'chunking_config.freezed.dart';
part 'chunking_config.g.dart';

/// Text chunking configuration.
@Freezed()
abstract class ChunkingConfig with _$ChunkingConfig {
  const factory ChunkingConfig({
    /// Chunker type: "text", "markdown", "yaml"
    @JsonKey(name: 'chunker_type') String? chunkerType,

    /// Embedding generation configuration
    EmbeddingConfig? embedding,

    /// Maximum chunk size in characters
    @JsonKey(name: 'max_characters') int? maxCharacters,

    /// Overlap between adjacent chunks in characters
    int? overlap,

    /// Preset name (overrides other settings)
    String? preset,

    /// Trim whitespace from chunk boundaries
    bool? trim,
  }) = _ChunkingConfig;

  factory ChunkingConfig.fromJson(Map<String, Object?> json) =>
      _$ChunkingConfigFromJson(json);
}
