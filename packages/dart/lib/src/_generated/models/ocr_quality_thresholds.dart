// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ocr_quality_thresholds.freezed.dart';
part 'ocr_quality_thresholds.g.dart';

/// Quality thresholds for OCR fallback decisions.
@Freezed()
abstract class OcrQualityThresholds with _$OcrQualityThresholds {
  const factory OcrQualityThresholds({
    @JsonKey(name: 'alnum_ws_ratio_threshold')
    double? alnumWsRatioThreshold,
    @JsonKey(name: 'critical_fragmented_word_ratio')
    double? criticalFragmentedWordRatio,
    @JsonKey(name: 'max_fragmented_word_ratio')
    double? maxFragmentedWordRatio,
    @JsonKey(name: 'min_alnum_ratio')
    double? minAlnumRatio,
    @JsonKey(name: 'min_avg_word_length')
    double? minAvgWordLength,
    @JsonKey(name: 'min_consecutive_repeat_ratio')
    double? minConsecutiveRepeatRatio,
    @JsonKey(name: 'min_garbage_chars')
    int? minGarbageChars,
    @JsonKey(name: 'min_meaningful_word_len')
    int? minMeaningfulWordLen,
    @JsonKey(name: 'min_meaningful_words')
    int? minMeaningfulWords,
    @JsonKey(name: 'min_non_whitespace_per_page')
    double? minNonWhitespacePerPage,
    @JsonKey(name: 'min_total_non_whitespace')
    int? minTotalNonWhitespace,
    @JsonKey(name: 'min_words_for_avg_length_check')
    int? minWordsForAvgLengthCheck,
    @JsonKey(name: 'min_words_for_repeat_check')
    int? minWordsForRepeatCheck,
    @JsonKey(name: 'non_text_min_chars')
    int? nonTextMinChars,
    @JsonKey(name: 'pipeline_min_quality')
    double? pipelineMinQuality,
    @JsonKey(name: 'substantive_min_chars')
    int? substantiveMinChars,
  }) = _OcrQualityThresholds;
  
  factory OcrQualityThresholds.fromJson(Map<String, Object?> json) => _$OcrQualityThresholdsFromJson(json);
}
