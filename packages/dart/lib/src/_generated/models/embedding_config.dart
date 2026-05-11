// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'embedding_config.freezed.dart';
part 'embedding_config.g.dart';

/// Embedding generation configuration for chunks.
@Freezed()
abstract class EmbeddingConfig with _$EmbeddingConfig {
  const factory EmbeddingConfig({
    /// Batch size for embedding generation
    @JsonKey(name: 'batch_size')
    int? batchSize,

    /// Model configuration (flexible JSON: {"type":"preset","name":"balanced"})
    dynamic model,

    /// Normalize embedding vectors
    bool? normalize,

    /// Show model download progress
    @JsonKey(name: 'show_download_progress')
    bool? showDownloadProgress,
  }) = _EmbeddingConfig;
  
  factory EmbeddingConfig.fromJson(Map<String, Object?> json) => _$EmbeddingConfigFromJson(json);
}
