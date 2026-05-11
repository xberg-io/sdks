// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ocr_pipeline_stage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OcrPipelineStage {
  /// Backend name. Only "tesseract" is supported; any other value is.
  /// rejected at the API boundary.
  String get backend;

  /// Language override for this stage
  String? get language;

  /// Priority (higher = tried first, default 100)
  int? get priority;

  /// Tesseract config override for this stage
  @JsonKey(name: 'tesseract_config')
  dynamic get tesseractConfig;

  /// VLM config override for this stage
  @JsonKey(name: 'vlm_config')
  dynamic get vlmConfig;

  /// Create a copy of OcrPipelineStage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OcrPipelineStageCopyWith<OcrPipelineStage> get copyWith =>
      _$OcrPipelineStageCopyWithImpl<OcrPipelineStage>(
          this as OcrPipelineStage, _$identity);

  /// Serializes this OcrPipelineStage to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OcrPipelineStage &&
            (identical(other.backend, backend) || other.backend == backend) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            const DeepCollectionEquality()
                .equals(other.tesseractConfig, tesseractConfig) &&
            const DeepCollectionEquality().equals(other.vlmConfig, vlmConfig));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      backend,
      language,
      priority,
      const DeepCollectionEquality().hash(tesseractConfig),
      const DeepCollectionEquality().hash(vlmConfig));

  @override
  String toString() {
    return 'OcrPipelineStage(backend: $backend, language: $language, priority: $priority, tesseractConfig: $tesseractConfig, vlmConfig: $vlmConfig)';
  }
}

/// @nodoc
abstract mixin class $OcrPipelineStageCopyWith<$Res> {
  factory $OcrPipelineStageCopyWith(
          OcrPipelineStage value, $Res Function(OcrPipelineStage) _then) =
      _$OcrPipelineStageCopyWithImpl;
  @useResult
  $Res call(
      {String backend,
      String? language,
      int? priority,
      @JsonKey(name: 'tesseract_config') dynamic tesseractConfig,
      @JsonKey(name: 'vlm_config') dynamic vlmConfig});
}

/// @nodoc
class _$OcrPipelineStageCopyWithImpl<$Res>
    implements $OcrPipelineStageCopyWith<$Res> {
  _$OcrPipelineStageCopyWithImpl(this._self, this._then);

  final OcrPipelineStage _self;
  final $Res Function(OcrPipelineStage) _then;

  /// Create a copy of OcrPipelineStage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backend = null,
    Object? language = freezed,
    Object? priority = freezed,
    Object? tesseractConfig = freezed,
    Object? vlmConfig = freezed,
  }) {
    return _then(_self.copyWith(
      backend: null == backend
          ? _self.backend
          : backend // ignore: cast_nullable_to_non_nullable
              as String,
      language: freezed == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: freezed == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int?,
      tesseractConfig: freezed == tesseractConfig
          ? _self.tesseractConfig
          : tesseractConfig // ignore: cast_nullable_to_non_nullable
              as dynamic,
      vlmConfig: freezed == vlmConfig
          ? _self.vlmConfig
          : vlmConfig // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// Adds pattern-matching-related methods to [OcrPipelineStage].
extension OcrPipelineStagePatterns on OcrPipelineStage {
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
    TResult Function(_OcrPipelineStage value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OcrPipelineStage() when $default != null:
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
    TResult Function(_OcrPipelineStage value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OcrPipelineStage():
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
    TResult? Function(_OcrPipelineStage value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OcrPipelineStage() when $default != null:
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
            String backend,
            String? language,
            int? priority,
            @JsonKey(name: 'tesseract_config') dynamic tesseractConfig,
            @JsonKey(name: 'vlm_config') dynamic vlmConfig)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OcrPipelineStage() when $default != null:
        return $default(_that.backend, _that.language, _that.priority,
            _that.tesseractConfig, _that.vlmConfig);
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
            String backend,
            String? language,
            int? priority,
            @JsonKey(name: 'tesseract_config') dynamic tesseractConfig,
            @JsonKey(name: 'vlm_config') dynamic vlmConfig)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OcrPipelineStage():
        return $default(_that.backend, _that.language, _that.priority,
            _that.tesseractConfig, _that.vlmConfig);
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
            String backend,
            String? language,
            int? priority,
            @JsonKey(name: 'tesseract_config') dynamic tesseractConfig,
            @JsonKey(name: 'vlm_config') dynamic vlmConfig)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OcrPipelineStage() when $default != null:
        return $default(_that.backend, _that.language, _that.priority,
            _that.tesseractConfig, _that.vlmConfig);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OcrPipelineStage implements OcrPipelineStage {
  const _OcrPipelineStage(
      {required this.backend,
      this.language,
      this.priority,
      @JsonKey(name: 'tesseract_config') this.tesseractConfig,
      @JsonKey(name: 'vlm_config') this.vlmConfig});
  factory _OcrPipelineStage.fromJson(Map<String, dynamic> json) =>
      _$OcrPipelineStageFromJson(json);

  /// Backend name. Only "tesseract" is supported; any other value is.
  /// rejected at the API boundary.
  @override
  final String backend;

  /// Language override for this stage
  @override
  final String? language;

  /// Priority (higher = tried first, default 100)
  @override
  final int? priority;

  /// Tesseract config override for this stage
  @override
  @JsonKey(name: 'tesseract_config')
  final dynamic tesseractConfig;

  /// VLM config override for this stage
  @override
  @JsonKey(name: 'vlm_config')
  final dynamic vlmConfig;

  /// Create a copy of OcrPipelineStage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OcrPipelineStageCopyWith<_OcrPipelineStage> get copyWith =>
      __$OcrPipelineStageCopyWithImpl<_OcrPipelineStage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OcrPipelineStageToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OcrPipelineStage &&
            (identical(other.backend, backend) || other.backend == backend) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            const DeepCollectionEquality()
                .equals(other.tesseractConfig, tesseractConfig) &&
            const DeepCollectionEquality().equals(other.vlmConfig, vlmConfig));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      backend,
      language,
      priority,
      const DeepCollectionEquality().hash(tesseractConfig),
      const DeepCollectionEquality().hash(vlmConfig));

  @override
  String toString() {
    return 'OcrPipelineStage(backend: $backend, language: $language, priority: $priority, tesseractConfig: $tesseractConfig, vlmConfig: $vlmConfig)';
  }
}

/// @nodoc
abstract mixin class _$OcrPipelineStageCopyWith<$Res>
    implements $OcrPipelineStageCopyWith<$Res> {
  factory _$OcrPipelineStageCopyWith(
          _OcrPipelineStage value, $Res Function(_OcrPipelineStage) _then) =
      __$OcrPipelineStageCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String backend,
      String? language,
      int? priority,
      @JsonKey(name: 'tesseract_config') dynamic tesseractConfig,
      @JsonKey(name: 'vlm_config') dynamic vlmConfig});
}

/// @nodoc
class __$OcrPipelineStageCopyWithImpl<$Res>
    implements _$OcrPipelineStageCopyWith<$Res> {
  __$OcrPipelineStageCopyWithImpl(this._self, this._then);

  final _OcrPipelineStage _self;
  final $Res Function(_OcrPipelineStage) _then;

  /// Create a copy of OcrPipelineStage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? backend = null,
    Object? language = freezed,
    Object? priority = freezed,
    Object? tesseractConfig = freezed,
    Object? vlmConfig = freezed,
  }) {
    return _then(_OcrPipelineStage(
      backend: null == backend
          ? _self.backend
          : backend // ignore: cast_nullable_to_non_nullable
              as String,
      language: freezed == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: freezed == priority
          ? _self.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int?,
      tesseractConfig: freezed == tesseractConfig
          ? _self.tesseractConfig
          : tesseractConfig // ignore: cast_nullable_to_non_nullable
              as dynamic,
      vlmConfig: freezed == vlmConfig
          ? _self.vlmConfig
          : vlmConfig // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

// dart format on
