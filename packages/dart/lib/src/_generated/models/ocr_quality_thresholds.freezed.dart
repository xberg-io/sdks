// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ocr_quality_thresholds.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OcrQualityThresholds {
  @JsonKey(name: 'alnum_ws_ratio_threshold')
  double? get alnumWsRatioThreshold;
  @JsonKey(name: 'critical_fragmented_word_ratio')
  double? get criticalFragmentedWordRatio;
  @JsonKey(name: 'max_fragmented_word_ratio')
  double? get maxFragmentedWordRatio;
  @JsonKey(name: 'min_alnum_ratio')
  double? get minAlnumRatio;
  @JsonKey(name: 'min_avg_word_length')
  double? get minAvgWordLength;
  @JsonKey(name: 'min_consecutive_repeat_ratio')
  double? get minConsecutiveRepeatRatio;
  @JsonKey(name: 'min_garbage_chars')
  int? get minGarbageChars;
  @JsonKey(name: 'min_meaningful_word_len')
  int? get minMeaningfulWordLen;
  @JsonKey(name: 'min_meaningful_words')
  int? get minMeaningfulWords;
  @JsonKey(name: 'min_non_whitespace_per_page')
  double? get minNonWhitespacePerPage;
  @JsonKey(name: 'min_total_non_whitespace')
  int? get minTotalNonWhitespace;
  @JsonKey(name: 'min_words_for_avg_length_check')
  int? get minWordsForAvgLengthCheck;
  @JsonKey(name: 'min_words_for_repeat_check')
  int? get minWordsForRepeatCheck;
  @JsonKey(name: 'non_text_min_chars')
  int? get nonTextMinChars;
  @JsonKey(name: 'pipeline_min_quality')
  double? get pipelineMinQuality;
  @JsonKey(name: 'substantive_min_chars')
  int? get substantiveMinChars;

  /// Create a copy of OcrQualityThresholds
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OcrQualityThresholdsCopyWith<OcrQualityThresholds> get copyWith =>
      _$OcrQualityThresholdsCopyWithImpl<OcrQualityThresholds>(
          this as OcrQualityThresholds, _$identity);

  /// Serializes this OcrQualityThresholds to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OcrQualityThresholds &&
            (identical(other.alnumWsRatioThreshold, alnumWsRatioThreshold) ||
                other.alnumWsRatioThreshold == alnumWsRatioThreshold) &&
            (identical(other.criticalFragmentedWordRatio,
                    criticalFragmentedWordRatio) ||
                other.criticalFragmentedWordRatio ==
                    criticalFragmentedWordRatio) &&
            (identical(other.maxFragmentedWordRatio, maxFragmentedWordRatio) ||
                other.maxFragmentedWordRatio == maxFragmentedWordRatio) &&
            (identical(other.minAlnumRatio, minAlnumRatio) ||
                other.minAlnumRatio == minAlnumRatio) &&
            (identical(other.minAvgWordLength, minAvgWordLength) ||
                other.minAvgWordLength == minAvgWordLength) &&
            (identical(other.minConsecutiveRepeatRatio,
                    minConsecutiveRepeatRatio) ||
                other.minConsecutiveRepeatRatio == minConsecutiveRepeatRatio) &&
            (identical(other.minGarbageChars, minGarbageChars) ||
                other.minGarbageChars == minGarbageChars) &&
            (identical(other.minMeaningfulWordLen, minMeaningfulWordLen) ||
                other.minMeaningfulWordLen == minMeaningfulWordLen) &&
            (identical(other.minMeaningfulWords, minMeaningfulWords) ||
                other.minMeaningfulWords == minMeaningfulWords) &&
            (identical(
                    other.minNonWhitespacePerPage, minNonWhitespacePerPage) ||
                other.minNonWhitespacePerPage == minNonWhitespacePerPage) &&
            (identical(other.minTotalNonWhitespace, minTotalNonWhitespace) ||
                other.minTotalNonWhitespace == minTotalNonWhitespace) &&
            (identical(other.minWordsForAvgLengthCheck,
                    minWordsForAvgLengthCheck) ||
                other.minWordsForAvgLengthCheck == minWordsForAvgLengthCheck) &&
            (identical(other.minWordsForRepeatCheck, minWordsForRepeatCheck) ||
                other.minWordsForRepeatCheck == minWordsForRepeatCheck) &&
            (identical(other.nonTextMinChars, nonTextMinChars) ||
                other.nonTextMinChars == nonTextMinChars) &&
            (identical(other.pipelineMinQuality, pipelineMinQuality) ||
                other.pipelineMinQuality == pipelineMinQuality) &&
            (identical(other.substantiveMinChars, substantiveMinChars) ||
                other.substantiveMinChars == substantiveMinChars));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      alnumWsRatioThreshold,
      criticalFragmentedWordRatio,
      maxFragmentedWordRatio,
      minAlnumRatio,
      minAvgWordLength,
      minConsecutiveRepeatRatio,
      minGarbageChars,
      minMeaningfulWordLen,
      minMeaningfulWords,
      minNonWhitespacePerPage,
      minTotalNonWhitespace,
      minWordsForAvgLengthCheck,
      minWordsForRepeatCheck,
      nonTextMinChars,
      pipelineMinQuality,
      substantiveMinChars);

  @override
  String toString() {
    return 'OcrQualityThresholds(alnumWsRatioThreshold: $alnumWsRatioThreshold, criticalFragmentedWordRatio: $criticalFragmentedWordRatio, maxFragmentedWordRatio: $maxFragmentedWordRatio, minAlnumRatio: $minAlnumRatio, minAvgWordLength: $minAvgWordLength, minConsecutiveRepeatRatio: $minConsecutiveRepeatRatio, minGarbageChars: $minGarbageChars, minMeaningfulWordLen: $minMeaningfulWordLen, minMeaningfulWords: $minMeaningfulWords, minNonWhitespacePerPage: $minNonWhitespacePerPage, minTotalNonWhitespace: $minTotalNonWhitespace, minWordsForAvgLengthCheck: $minWordsForAvgLengthCheck, minWordsForRepeatCheck: $minWordsForRepeatCheck, nonTextMinChars: $nonTextMinChars, pipelineMinQuality: $pipelineMinQuality, substantiveMinChars: $substantiveMinChars)';
  }
}

/// @nodoc
abstract mixin class $OcrQualityThresholdsCopyWith<$Res> {
  factory $OcrQualityThresholdsCopyWith(OcrQualityThresholds value,
          $Res Function(OcrQualityThresholds) _then) =
      _$OcrQualityThresholdsCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'alnum_ws_ratio_threshold') double? alnumWsRatioThreshold,
      @JsonKey(name: 'critical_fragmented_word_ratio')
      double? criticalFragmentedWordRatio,
      @JsonKey(name: 'max_fragmented_word_ratio')
      double? maxFragmentedWordRatio,
      @JsonKey(name: 'min_alnum_ratio') double? minAlnumRatio,
      @JsonKey(name: 'min_avg_word_length') double? minAvgWordLength,
      @JsonKey(name: 'min_consecutive_repeat_ratio')
      double? minConsecutiveRepeatRatio,
      @JsonKey(name: 'min_garbage_chars') int? minGarbageChars,
      @JsonKey(name: 'min_meaningful_word_len') int? minMeaningfulWordLen,
      @JsonKey(name: 'min_meaningful_words') int? minMeaningfulWords,
      @JsonKey(name: 'min_non_whitespace_per_page')
      double? minNonWhitespacePerPage,
      @JsonKey(name: 'min_total_non_whitespace') int? minTotalNonWhitespace,
      @JsonKey(name: 'min_words_for_avg_length_check')
      int? minWordsForAvgLengthCheck,
      @JsonKey(name: 'min_words_for_repeat_check') int? minWordsForRepeatCheck,
      @JsonKey(name: 'non_text_min_chars') int? nonTextMinChars,
      @JsonKey(name: 'pipeline_min_quality') double? pipelineMinQuality,
      @JsonKey(name: 'substantive_min_chars') int? substantiveMinChars});
}

/// @nodoc
class _$OcrQualityThresholdsCopyWithImpl<$Res>
    implements $OcrQualityThresholdsCopyWith<$Res> {
  _$OcrQualityThresholdsCopyWithImpl(this._self, this._then);

  final OcrQualityThresholds _self;
  final $Res Function(OcrQualityThresholds) _then;

  /// Create a copy of OcrQualityThresholds
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alnumWsRatioThreshold = freezed,
    Object? criticalFragmentedWordRatio = freezed,
    Object? maxFragmentedWordRatio = freezed,
    Object? minAlnumRatio = freezed,
    Object? minAvgWordLength = freezed,
    Object? minConsecutiveRepeatRatio = freezed,
    Object? minGarbageChars = freezed,
    Object? minMeaningfulWordLen = freezed,
    Object? minMeaningfulWords = freezed,
    Object? minNonWhitespacePerPage = freezed,
    Object? minTotalNonWhitespace = freezed,
    Object? minWordsForAvgLengthCheck = freezed,
    Object? minWordsForRepeatCheck = freezed,
    Object? nonTextMinChars = freezed,
    Object? pipelineMinQuality = freezed,
    Object? substantiveMinChars = freezed,
  }) {
    return _then(_self.copyWith(
      alnumWsRatioThreshold: freezed == alnumWsRatioThreshold
          ? _self.alnumWsRatioThreshold
          : alnumWsRatioThreshold // ignore: cast_nullable_to_non_nullable
              as double?,
      criticalFragmentedWordRatio: freezed == criticalFragmentedWordRatio
          ? _self.criticalFragmentedWordRatio
          : criticalFragmentedWordRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      maxFragmentedWordRatio: freezed == maxFragmentedWordRatio
          ? _self.maxFragmentedWordRatio
          : maxFragmentedWordRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      minAlnumRatio: freezed == minAlnumRatio
          ? _self.minAlnumRatio
          : minAlnumRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      minAvgWordLength: freezed == minAvgWordLength
          ? _self.minAvgWordLength
          : minAvgWordLength // ignore: cast_nullable_to_non_nullable
              as double?,
      minConsecutiveRepeatRatio: freezed == minConsecutiveRepeatRatio
          ? _self.minConsecutiveRepeatRatio
          : minConsecutiveRepeatRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      minGarbageChars: freezed == minGarbageChars
          ? _self.minGarbageChars
          : minGarbageChars // ignore: cast_nullable_to_non_nullable
              as int?,
      minMeaningfulWordLen: freezed == minMeaningfulWordLen
          ? _self.minMeaningfulWordLen
          : minMeaningfulWordLen // ignore: cast_nullable_to_non_nullable
              as int?,
      minMeaningfulWords: freezed == minMeaningfulWords
          ? _self.minMeaningfulWords
          : minMeaningfulWords // ignore: cast_nullable_to_non_nullable
              as int?,
      minNonWhitespacePerPage: freezed == minNonWhitespacePerPage
          ? _self.minNonWhitespacePerPage
          : minNonWhitespacePerPage // ignore: cast_nullable_to_non_nullable
              as double?,
      minTotalNonWhitespace: freezed == minTotalNonWhitespace
          ? _self.minTotalNonWhitespace
          : minTotalNonWhitespace // ignore: cast_nullable_to_non_nullable
              as int?,
      minWordsForAvgLengthCheck: freezed == minWordsForAvgLengthCheck
          ? _self.minWordsForAvgLengthCheck
          : minWordsForAvgLengthCheck // ignore: cast_nullable_to_non_nullable
              as int?,
      minWordsForRepeatCheck: freezed == minWordsForRepeatCheck
          ? _self.minWordsForRepeatCheck
          : minWordsForRepeatCheck // ignore: cast_nullable_to_non_nullable
              as int?,
      nonTextMinChars: freezed == nonTextMinChars
          ? _self.nonTextMinChars
          : nonTextMinChars // ignore: cast_nullable_to_non_nullable
              as int?,
      pipelineMinQuality: freezed == pipelineMinQuality
          ? _self.pipelineMinQuality
          : pipelineMinQuality // ignore: cast_nullable_to_non_nullable
              as double?,
      substantiveMinChars: freezed == substantiveMinChars
          ? _self.substantiveMinChars
          : substantiveMinChars // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [OcrQualityThresholds].
extension OcrQualityThresholdsPatterns on OcrQualityThresholds {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_OcrQualityThresholds value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OcrQualityThresholds() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_OcrQualityThresholds value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OcrQualityThresholds():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_OcrQualityThresholds value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OcrQualityThresholds() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: 'alnum_ws_ratio_threshold')
            double? alnumWsRatioThreshold,
            @JsonKey(name: 'critical_fragmented_word_ratio')
            double? criticalFragmentedWordRatio,
            @JsonKey(name: 'max_fragmented_word_ratio')
            double? maxFragmentedWordRatio,
            @JsonKey(name: 'min_alnum_ratio') double? minAlnumRatio,
            @JsonKey(name: 'min_avg_word_length') double? minAvgWordLength,
            @JsonKey(name: 'min_consecutive_repeat_ratio')
            double? minConsecutiveRepeatRatio,
            @JsonKey(name: 'min_garbage_chars') int? minGarbageChars,
            @JsonKey(name: 'min_meaningful_word_len') int? minMeaningfulWordLen,
            @JsonKey(name: 'min_meaningful_words') int? minMeaningfulWords,
            @JsonKey(name: 'min_non_whitespace_per_page')
            double? minNonWhitespacePerPage,
            @JsonKey(name: 'min_total_non_whitespace')
            int? minTotalNonWhitespace,
            @JsonKey(name: 'min_words_for_avg_length_check')
            int? minWordsForAvgLengthCheck,
            @JsonKey(name: 'min_words_for_repeat_check')
            int? minWordsForRepeatCheck,
            @JsonKey(name: 'non_text_min_chars') int? nonTextMinChars,
            @JsonKey(name: 'pipeline_min_quality') double? pipelineMinQuality,
            @JsonKey(name: 'substantive_min_chars') int? substantiveMinChars)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OcrQualityThresholds() when $default != null:
        return $default(
            _that.alnumWsRatioThreshold,
            _that.criticalFragmentedWordRatio,
            _that.maxFragmentedWordRatio,
            _that.minAlnumRatio,
            _that.minAvgWordLength,
            _that.minConsecutiveRepeatRatio,
            _that.minGarbageChars,
            _that.minMeaningfulWordLen,
            _that.minMeaningfulWords,
            _that.minNonWhitespacePerPage,
            _that.minTotalNonWhitespace,
            _that.minWordsForAvgLengthCheck,
            _that.minWordsForRepeatCheck,
            _that.nonTextMinChars,
            _that.pipelineMinQuality,
            _that.substantiveMinChars);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: 'alnum_ws_ratio_threshold')
            double? alnumWsRatioThreshold,
            @JsonKey(name: 'critical_fragmented_word_ratio')
            double? criticalFragmentedWordRatio,
            @JsonKey(name: 'max_fragmented_word_ratio')
            double? maxFragmentedWordRatio,
            @JsonKey(name: 'min_alnum_ratio') double? minAlnumRatio,
            @JsonKey(name: 'min_avg_word_length') double? minAvgWordLength,
            @JsonKey(name: 'min_consecutive_repeat_ratio')
            double? minConsecutiveRepeatRatio,
            @JsonKey(name: 'min_garbage_chars') int? minGarbageChars,
            @JsonKey(name: 'min_meaningful_word_len') int? minMeaningfulWordLen,
            @JsonKey(name: 'min_meaningful_words') int? minMeaningfulWords,
            @JsonKey(name: 'min_non_whitespace_per_page')
            double? minNonWhitespacePerPage,
            @JsonKey(name: 'min_total_non_whitespace')
            int? minTotalNonWhitespace,
            @JsonKey(name: 'min_words_for_avg_length_check')
            int? minWordsForAvgLengthCheck,
            @JsonKey(name: 'min_words_for_repeat_check')
            int? minWordsForRepeatCheck,
            @JsonKey(name: 'non_text_min_chars') int? nonTextMinChars,
            @JsonKey(name: 'pipeline_min_quality') double? pipelineMinQuality,
            @JsonKey(name: 'substantive_min_chars') int? substantiveMinChars)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OcrQualityThresholds():
        return $default(
            _that.alnumWsRatioThreshold,
            _that.criticalFragmentedWordRatio,
            _that.maxFragmentedWordRatio,
            _that.minAlnumRatio,
            _that.minAvgWordLength,
            _that.minConsecutiveRepeatRatio,
            _that.minGarbageChars,
            _that.minMeaningfulWordLen,
            _that.minMeaningfulWords,
            _that.minNonWhitespacePerPage,
            _that.minTotalNonWhitespace,
            _that.minWordsForAvgLengthCheck,
            _that.minWordsForRepeatCheck,
            _that.nonTextMinChars,
            _that.pipelineMinQuality,
            _that.substantiveMinChars);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @JsonKey(name: 'alnum_ws_ratio_threshold')
            double? alnumWsRatioThreshold,
            @JsonKey(name: 'critical_fragmented_word_ratio')
            double? criticalFragmentedWordRatio,
            @JsonKey(name: 'max_fragmented_word_ratio')
            double? maxFragmentedWordRatio,
            @JsonKey(name: 'min_alnum_ratio') double? minAlnumRatio,
            @JsonKey(name: 'min_avg_word_length') double? minAvgWordLength,
            @JsonKey(name: 'min_consecutive_repeat_ratio')
            double? minConsecutiveRepeatRatio,
            @JsonKey(name: 'min_garbage_chars') int? minGarbageChars,
            @JsonKey(name: 'min_meaningful_word_len') int? minMeaningfulWordLen,
            @JsonKey(name: 'min_meaningful_words') int? minMeaningfulWords,
            @JsonKey(name: 'min_non_whitespace_per_page')
            double? minNonWhitespacePerPage,
            @JsonKey(name: 'min_total_non_whitespace')
            int? minTotalNonWhitespace,
            @JsonKey(name: 'min_words_for_avg_length_check')
            int? minWordsForAvgLengthCheck,
            @JsonKey(name: 'min_words_for_repeat_check')
            int? minWordsForRepeatCheck,
            @JsonKey(name: 'non_text_min_chars') int? nonTextMinChars,
            @JsonKey(name: 'pipeline_min_quality') double? pipelineMinQuality,
            @JsonKey(name: 'substantive_min_chars') int? substantiveMinChars)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OcrQualityThresholds() when $default != null:
        return $default(
            _that.alnumWsRatioThreshold,
            _that.criticalFragmentedWordRatio,
            _that.maxFragmentedWordRatio,
            _that.minAlnumRatio,
            _that.minAvgWordLength,
            _that.minConsecutiveRepeatRatio,
            _that.minGarbageChars,
            _that.minMeaningfulWordLen,
            _that.minMeaningfulWords,
            _that.minNonWhitespacePerPage,
            _that.minTotalNonWhitespace,
            _that.minWordsForAvgLengthCheck,
            _that.minWordsForRepeatCheck,
            _that.nonTextMinChars,
            _that.pipelineMinQuality,
            _that.substantiveMinChars);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OcrQualityThresholds implements OcrQualityThresholds {
  const _OcrQualityThresholds(
      {@JsonKey(name: 'alnum_ws_ratio_threshold') this.alnumWsRatioThreshold,
      @JsonKey(name: 'critical_fragmented_word_ratio')
      this.criticalFragmentedWordRatio,
      @JsonKey(name: 'max_fragmented_word_ratio') this.maxFragmentedWordRatio,
      @JsonKey(name: 'min_alnum_ratio') this.minAlnumRatio,
      @JsonKey(name: 'min_avg_word_length') this.minAvgWordLength,
      @JsonKey(name: 'min_consecutive_repeat_ratio')
      this.minConsecutiveRepeatRatio,
      @JsonKey(name: 'min_garbage_chars') this.minGarbageChars,
      @JsonKey(name: 'min_meaningful_word_len') this.minMeaningfulWordLen,
      @JsonKey(name: 'min_meaningful_words') this.minMeaningfulWords,
      @JsonKey(name: 'min_non_whitespace_per_page')
      this.minNonWhitespacePerPage,
      @JsonKey(name: 'min_total_non_whitespace') this.minTotalNonWhitespace,
      @JsonKey(name: 'min_words_for_avg_length_check')
      this.minWordsForAvgLengthCheck,
      @JsonKey(name: 'min_words_for_repeat_check') this.minWordsForRepeatCheck,
      @JsonKey(name: 'non_text_min_chars') this.nonTextMinChars,
      @JsonKey(name: 'pipeline_min_quality') this.pipelineMinQuality,
      @JsonKey(name: 'substantive_min_chars') this.substantiveMinChars});
  factory _OcrQualityThresholds.fromJson(Map<String, dynamic> json) =>
      _$OcrQualityThresholdsFromJson(json);

  @override
  @JsonKey(name: 'alnum_ws_ratio_threshold')
  final double? alnumWsRatioThreshold;
  @override
  @JsonKey(name: 'critical_fragmented_word_ratio')
  final double? criticalFragmentedWordRatio;
  @override
  @JsonKey(name: 'max_fragmented_word_ratio')
  final double? maxFragmentedWordRatio;
  @override
  @JsonKey(name: 'min_alnum_ratio')
  final double? minAlnumRatio;
  @override
  @JsonKey(name: 'min_avg_word_length')
  final double? minAvgWordLength;
  @override
  @JsonKey(name: 'min_consecutive_repeat_ratio')
  final double? minConsecutiveRepeatRatio;
  @override
  @JsonKey(name: 'min_garbage_chars')
  final int? minGarbageChars;
  @override
  @JsonKey(name: 'min_meaningful_word_len')
  final int? minMeaningfulWordLen;
  @override
  @JsonKey(name: 'min_meaningful_words')
  final int? minMeaningfulWords;
  @override
  @JsonKey(name: 'min_non_whitespace_per_page')
  final double? minNonWhitespacePerPage;
  @override
  @JsonKey(name: 'min_total_non_whitespace')
  final int? minTotalNonWhitespace;
  @override
  @JsonKey(name: 'min_words_for_avg_length_check')
  final int? minWordsForAvgLengthCheck;
  @override
  @JsonKey(name: 'min_words_for_repeat_check')
  final int? minWordsForRepeatCheck;
  @override
  @JsonKey(name: 'non_text_min_chars')
  final int? nonTextMinChars;
  @override
  @JsonKey(name: 'pipeline_min_quality')
  final double? pipelineMinQuality;
  @override
  @JsonKey(name: 'substantive_min_chars')
  final int? substantiveMinChars;

  /// Create a copy of OcrQualityThresholds
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OcrQualityThresholdsCopyWith<_OcrQualityThresholds> get copyWith =>
      __$OcrQualityThresholdsCopyWithImpl<_OcrQualityThresholds>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OcrQualityThresholdsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OcrQualityThresholds &&
            (identical(other.alnumWsRatioThreshold, alnumWsRatioThreshold) ||
                other.alnumWsRatioThreshold == alnumWsRatioThreshold) &&
            (identical(other.criticalFragmentedWordRatio,
                    criticalFragmentedWordRatio) ||
                other.criticalFragmentedWordRatio ==
                    criticalFragmentedWordRatio) &&
            (identical(other.maxFragmentedWordRatio, maxFragmentedWordRatio) ||
                other.maxFragmentedWordRatio == maxFragmentedWordRatio) &&
            (identical(other.minAlnumRatio, minAlnumRatio) ||
                other.minAlnumRatio == minAlnumRatio) &&
            (identical(other.minAvgWordLength, minAvgWordLength) ||
                other.minAvgWordLength == minAvgWordLength) &&
            (identical(other.minConsecutiveRepeatRatio,
                    minConsecutiveRepeatRatio) ||
                other.minConsecutiveRepeatRatio == minConsecutiveRepeatRatio) &&
            (identical(other.minGarbageChars, minGarbageChars) ||
                other.minGarbageChars == minGarbageChars) &&
            (identical(other.minMeaningfulWordLen, minMeaningfulWordLen) ||
                other.minMeaningfulWordLen == minMeaningfulWordLen) &&
            (identical(other.minMeaningfulWords, minMeaningfulWords) ||
                other.minMeaningfulWords == minMeaningfulWords) &&
            (identical(
                    other.minNonWhitespacePerPage, minNonWhitespacePerPage) ||
                other.minNonWhitespacePerPage == minNonWhitespacePerPage) &&
            (identical(other.minTotalNonWhitespace, minTotalNonWhitespace) ||
                other.minTotalNonWhitespace == minTotalNonWhitespace) &&
            (identical(other.minWordsForAvgLengthCheck,
                    minWordsForAvgLengthCheck) ||
                other.minWordsForAvgLengthCheck == minWordsForAvgLengthCheck) &&
            (identical(other.minWordsForRepeatCheck, minWordsForRepeatCheck) ||
                other.minWordsForRepeatCheck == minWordsForRepeatCheck) &&
            (identical(other.nonTextMinChars, nonTextMinChars) ||
                other.nonTextMinChars == nonTextMinChars) &&
            (identical(other.pipelineMinQuality, pipelineMinQuality) ||
                other.pipelineMinQuality == pipelineMinQuality) &&
            (identical(other.substantiveMinChars, substantiveMinChars) ||
                other.substantiveMinChars == substantiveMinChars));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      alnumWsRatioThreshold,
      criticalFragmentedWordRatio,
      maxFragmentedWordRatio,
      minAlnumRatio,
      minAvgWordLength,
      minConsecutiveRepeatRatio,
      minGarbageChars,
      minMeaningfulWordLen,
      minMeaningfulWords,
      minNonWhitespacePerPage,
      minTotalNonWhitespace,
      minWordsForAvgLengthCheck,
      minWordsForRepeatCheck,
      nonTextMinChars,
      pipelineMinQuality,
      substantiveMinChars);

  @override
  String toString() {
    return 'OcrQualityThresholds(alnumWsRatioThreshold: $alnumWsRatioThreshold, criticalFragmentedWordRatio: $criticalFragmentedWordRatio, maxFragmentedWordRatio: $maxFragmentedWordRatio, minAlnumRatio: $minAlnumRatio, minAvgWordLength: $minAvgWordLength, minConsecutiveRepeatRatio: $minConsecutiveRepeatRatio, minGarbageChars: $minGarbageChars, minMeaningfulWordLen: $minMeaningfulWordLen, minMeaningfulWords: $minMeaningfulWords, minNonWhitespacePerPage: $minNonWhitespacePerPage, minTotalNonWhitespace: $minTotalNonWhitespace, minWordsForAvgLengthCheck: $minWordsForAvgLengthCheck, minWordsForRepeatCheck: $minWordsForRepeatCheck, nonTextMinChars: $nonTextMinChars, pipelineMinQuality: $pipelineMinQuality, substantiveMinChars: $substantiveMinChars)';
  }
}

/// @nodoc
abstract mixin class _$OcrQualityThresholdsCopyWith<$Res>
    implements $OcrQualityThresholdsCopyWith<$Res> {
  factory _$OcrQualityThresholdsCopyWith(_OcrQualityThresholds value,
          $Res Function(_OcrQualityThresholds) _then) =
      __$OcrQualityThresholdsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'alnum_ws_ratio_threshold') double? alnumWsRatioThreshold,
      @JsonKey(name: 'critical_fragmented_word_ratio')
      double? criticalFragmentedWordRatio,
      @JsonKey(name: 'max_fragmented_word_ratio')
      double? maxFragmentedWordRatio,
      @JsonKey(name: 'min_alnum_ratio') double? minAlnumRatio,
      @JsonKey(name: 'min_avg_word_length') double? minAvgWordLength,
      @JsonKey(name: 'min_consecutive_repeat_ratio')
      double? minConsecutiveRepeatRatio,
      @JsonKey(name: 'min_garbage_chars') int? minGarbageChars,
      @JsonKey(name: 'min_meaningful_word_len') int? minMeaningfulWordLen,
      @JsonKey(name: 'min_meaningful_words') int? minMeaningfulWords,
      @JsonKey(name: 'min_non_whitespace_per_page')
      double? minNonWhitespacePerPage,
      @JsonKey(name: 'min_total_non_whitespace') int? minTotalNonWhitespace,
      @JsonKey(name: 'min_words_for_avg_length_check')
      int? minWordsForAvgLengthCheck,
      @JsonKey(name: 'min_words_for_repeat_check') int? minWordsForRepeatCheck,
      @JsonKey(name: 'non_text_min_chars') int? nonTextMinChars,
      @JsonKey(name: 'pipeline_min_quality') double? pipelineMinQuality,
      @JsonKey(name: 'substantive_min_chars') int? substantiveMinChars});
}

/// @nodoc
class __$OcrQualityThresholdsCopyWithImpl<$Res>
    implements _$OcrQualityThresholdsCopyWith<$Res> {
  __$OcrQualityThresholdsCopyWithImpl(this._self, this._then);

  final _OcrQualityThresholds _self;
  final $Res Function(_OcrQualityThresholds) _then;

  /// Create a copy of OcrQualityThresholds
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? alnumWsRatioThreshold = freezed,
    Object? criticalFragmentedWordRatio = freezed,
    Object? maxFragmentedWordRatio = freezed,
    Object? minAlnumRatio = freezed,
    Object? minAvgWordLength = freezed,
    Object? minConsecutiveRepeatRatio = freezed,
    Object? minGarbageChars = freezed,
    Object? minMeaningfulWordLen = freezed,
    Object? minMeaningfulWords = freezed,
    Object? minNonWhitespacePerPage = freezed,
    Object? minTotalNonWhitespace = freezed,
    Object? minWordsForAvgLengthCheck = freezed,
    Object? minWordsForRepeatCheck = freezed,
    Object? nonTextMinChars = freezed,
    Object? pipelineMinQuality = freezed,
    Object? substantiveMinChars = freezed,
  }) {
    return _then(_OcrQualityThresholds(
      alnumWsRatioThreshold: freezed == alnumWsRatioThreshold
          ? _self.alnumWsRatioThreshold
          : alnumWsRatioThreshold // ignore: cast_nullable_to_non_nullable
              as double?,
      criticalFragmentedWordRatio: freezed == criticalFragmentedWordRatio
          ? _self.criticalFragmentedWordRatio
          : criticalFragmentedWordRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      maxFragmentedWordRatio: freezed == maxFragmentedWordRatio
          ? _self.maxFragmentedWordRatio
          : maxFragmentedWordRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      minAlnumRatio: freezed == minAlnumRatio
          ? _self.minAlnumRatio
          : minAlnumRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      minAvgWordLength: freezed == minAvgWordLength
          ? _self.minAvgWordLength
          : minAvgWordLength // ignore: cast_nullable_to_non_nullable
              as double?,
      minConsecutiveRepeatRatio: freezed == minConsecutiveRepeatRatio
          ? _self.minConsecutiveRepeatRatio
          : minConsecutiveRepeatRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      minGarbageChars: freezed == minGarbageChars
          ? _self.minGarbageChars
          : minGarbageChars // ignore: cast_nullable_to_non_nullable
              as int?,
      minMeaningfulWordLen: freezed == minMeaningfulWordLen
          ? _self.minMeaningfulWordLen
          : minMeaningfulWordLen // ignore: cast_nullable_to_non_nullable
              as int?,
      minMeaningfulWords: freezed == minMeaningfulWords
          ? _self.minMeaningfulWords
          : minMeaningfulWords // ignore: cast_nullable_to_non_nullable
              as int?,
      minNonWhitespacePerPage: freezed == minNonWhitespacePerPage
          ? _self.minNonWhitespacePerPage
          : minNonWhitespacePerPage // ignore: cast_nullable_to_non_nullable
              as double?,
      minTotalNonWhitespace: freezed == minTotalNonWhitespace
          ? _self.minTotalNonWhitespace
          : minTotalNonWhitespace // ignore: cast_nullable_to_non_nullable
              as int?,
      minWordsForAvgLengthCheck: freezed == minWordsForAvgLengthCheck
          ? _self.minWordsForAvgLengthCheck
          : minWordsForAvgLengthCheck // ignore: cast_nullable_to_non_nullable
              as int?,
      minWordsForRepeatCheck: freezed == minWordsForRepeatCheck
          ? _self.minWordsForRepeatCheck
          : minWordsForRepeatCheck // ignore: cast_nullable_to_non_nullable
              as int?,
      nonTextMinChars: freezed == nonTextMinChars
          ? _self.nonTextMinChars
          : nonTextMinChars // ignore: cast_nullable_to_non_nullable
              as int?,
      pipelineMinQuality: freezed == pipelineMinQuality
          ? _self.pipelineMinQuality
          : pipelineMinQuality // ignore: cast_nullable_to_non_nullable
              as double?,
      substantiveMinChars: freezed == substantiveMinChars
          ? _self.substantiveMinChars
          : substantiveMinChars // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
