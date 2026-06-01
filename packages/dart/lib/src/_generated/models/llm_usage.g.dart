// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'llm_usage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LlmUsage _$LlmUsageFromJson(Map<String, dynamic> json) => _LlmUsage(
  model: json['model'] as String,
  source: json['source'] as String,
  estimatedCost: (json['estimated_cost'] as num?)?.toDouble(),
  finishReason: json['finish_reason'] as String?,
  inputTokens: (json['input_tokens'] as num?)?.toInt(),
  outputTokens: (json['output_tokens'] as num?)?.toInt(),
  totalTokens: (json['total_tokens'] as num?)?.toInt(),
);

Map<String, dynamic> _$LlmUsageToJson(_LlmUsage instance) => <String, dynamic>{
  'model': instance.model,
  'source': instance.source,
  'estimated_cost': instance.estimatedCost,
  'finish_reason': instance.finishReason,
  'input_tokens': instance.inputTokens,
  'output_tokens': instance.outputTokens,
  'total_tokens': instance.totalTokens,
};
