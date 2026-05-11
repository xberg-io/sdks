// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'embedding_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EmbeddingConfig _$EmbeddingConfigFromJson(Map<String, dynamic> json) =>
    _EmbeddingConfig(
      batchSize: (json['batch_size'] as num?)?.toInt(),
      model: json['model'],
      normalize: json['normalize'] as bool?,
      showDownloadProgress: json['show_download_progress'] as bool?,
    );

Map<String, dynamic> _$EmbeddingConfigToJson(_EmbeddingConfig instance) =>
    <String, dynamic>{
      'batch_size': instance.batchSize,
      'model': instance.model,
      'normalize': instance.normalize,
      'show_download_progress': instance.showDownloadProgress,
    };
