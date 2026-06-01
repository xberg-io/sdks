// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocr_quality_thresholds.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OcrQualityThresholds _$OcrQualityThresholdsFromJson(
  Map<String, dynamic> json,
) => _OcrQualityThresholds(
  alnumWsRatioThreshold: (json['alnum_ws_ratio_threshold'] as num?)?.toDouble(),
  criticalFragmentedWordRatio: (json['critical_fragmented_word_ratio'] as num?)
      ?.toDouble(),
  maxFragmentedWordRatio: (json['max_fragmented_word_ratio'] as num?)
      ?.toDouble(),
  minAlnumRatio: (json['min_alnum_ratio'] as num?)?.toDouble(),
  minAvgWordLength: (json['min_avg_word_length'] as num?)?.toDouble(),
  minConsecutiveRepeatRatio: (json['min_consecutive_repeat_ratio'] as num?)
      ?.toDouble(),
  minGarbageChars: (json['min_garbage_chars'] as num?)?.toInt(),
  minMeaningfulWordLen: (json['min_meaningful_word_len'] as num?)?.toInt(),
  minMeaningfulWords: (json['min_meaningful_words'] as num?)?.toInt(),
  minNonWhitespacePerPage: (json['min_non_whitespace_per_page'] as num?)
      ?.toDouble(),
  minTotalNonWhitespace: (json['min_total_non_whitespace'] as num?)?.toInt(),
  minWordsForAvgLengthCheck: (json['min_words_for_avg_length_check'] as num?)
      ?.toInt(),
  minWordsForRepeatCheck: (json['min_words_for_repeat_check'] as num?)?.toInt(),
  nonTextMinChars: (json['non_text_min_chars'] as num?)?.toInt(),
  pipelineMinQuality: (json['pipeline_min_quality'] as num?)?.toDouble(),
  substantiveMinChars: (json['substantive_min_chars'] as num?)?.toInt(),
);

Map<String, dynamic> _$OcrQualityThresholdsToJson(
  _OcrQualityThresholds instance,
) => <String, dynamic>{
  'alnum_ws_ratio_threshold': instance.alnumWsRatioThreshold,
  'critical_fragmented_word_ratio': instance.criticalFragmentedWordRatio,
  'max_fragmented_word_ratio': instance.maxFragmentedWordRatio,
  'min_alnum_ratio': instance.minAlnumRatio,
  'min_avg_word_length': instance.minAvgWordLength,
  'min_consecutive_repeat_ratio': instance.minConsecutiveRepeatRatio,
  'min_garbage_chars': instance.minGarbageChars,
  'min_meaningful_word_len': instance.minMeaningfulWordLen,
  'min_meaningful_words': instance.minMeaningfulWords,
  'min_non_whitespace_per_page': instance.minNonWhitespacePerPage,
  'min_total_non_whitespace': instance.minTotalNonWhitespace,
  'min_words_for_avg_length_check': instance.minWordsForAvgLengthCheck,
  'min_words_for_repeat_check': instance.minWordsForRepeatCheck,
  'non_text_min_chars': instance.nonTextMinChars,
  'pipeline_min_quality': instance.pipelineMinQuality,
  'substantive_min_chars': instance.substantiveMinChars,
};
