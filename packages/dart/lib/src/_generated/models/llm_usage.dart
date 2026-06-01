// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'llm_usage.freezed.dart';
part 'llm_usage.g.dart';

/// Token usage and cost data for a single LLM call made during extraction.
///
/// Populated when VLM OCR, structured extraction, or LLM-based embeddings.
/// are used. Multiple entries may be present when multiple LLM calls occur.
/// within one extraction (e.g. VLM OCR + structured extraction).
@Freezed()
abstract class LlmUsage with _$LlmUsage {
  const factory LlmUsage({
    /// The LLM model identifier (e.g. "openai/gpt-4o", "anthropic/claude-sonnet-4-20250514").
    required String model,

    /// The pipeline stage that triggered this LLM call.
    /// (e.g. "vlm_ocr", "structured_extraction", "embeddings").
    required String source,

    /// Estimated cost in USD based on the provider's published pricing.
    @JsonKey(name: 'estimated_cost') double? estimatedCost,

    /// Why the model stopped generating (e.g. "stop", "length", "content_filter").
    @JsonKey(name: 'finish_reason') String? finishReason,

    /// Number of input/prompt tokens consumed.
    @JsonKey(name: 'input_tokens') int? inputTokens,

    /// Number of output/completion tokens generated.
    @JsonKey(name: 'output_tokens') int? outputTokens,

    /// Total tokens (input + output).
    @JsonKey(name: 'total_tokens') int? totalTokens,
  }) = _LlmUsage;

  factory LlmUsage.fromJson(Map<String, Object?> json) =>
      _$LlmUsageFromJson(json);
}
