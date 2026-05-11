// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ocr_element_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OcrElementConfig {
  /// Build parent-child relationships
  @JsonKey(name: 'build_hierarchy')
  bool? get buildHierarchy;

  /// Include OCR elements in result
  @JsonKey(name: 'include_elements')
  bool? get includeElements;

  /// Minimum recognition confidence (0.0-1.0)
  @JsonKey(name: 'min_confidence')
  double? get minConfidence;

  /// Minimum hierarchical level: "word", "line", "block", "page"
  @JsonKey(name: 'min_level')
  String? get minLevel;

  /// Create a copy of OcrElementConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OcrElementConfigCopyWith<OcrElementConfig> get copyWith =>
      _$OcrElementConfigCopyWithImpl<OcrElementConfig>(
          this as OcrElementConfig, _$identity);

  /// Serializes this OcrElementConfig to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OcrElementConfig &&
            (identical(other.buildHierarchy, buildHierarchy) ||
                other.buildHierarchy == buildHierarchy) &&
            (identical(other.includeElements, includeElements) ||
                other.includeElements == includeElements) &&
            (identical(other.minConfidence, minConfidence) ||
                other.minConfidence == minConfidence) &&
            (identical(other.minLevel, minLevel) ||
                other.minLevel == minLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, buildHierarchy, includeElements, minConfidence, minLevel);

  @override
  String toString() {
    return 'OcrElementConfig(buildHierarchy: $buildHierarchy, includeElements: $includeElements, minConfidence: $minConfidence, minLevel: $minLevel)';
  }
}

/// @nodoc
abstract mixin class $OcrElementConfigCopyWith<$Res> {
  factory $OcrElementConfigCopyWith(
          OcrElementConfig value, $Res Function(OcrElementConfig) _then) =
      _$OcrElementConfigCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'build_hierarchy') bool? buildHierarchy,
      @JsonKey(name: 'include_elements') bool? includeElements,
      @JsonKey(name: 'min_confidence') double? minConfidence,
      @JsonKey(name: 'min_level') String? minLevel});
}

/// @nodoc
class _$OcrElementConfigCopyWithImpl<$Res>
    implements $OcrElementConfigCopyWith<$Res> {
  _$OcrElementConfigCopyWithImpl(this._self, this._then);

  final OcrElementConfig _self;
  final $Res Function(OcrElementConfig) _then;

  /// Create a copy of OcrElementConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? buildHierarchy = freezed,
    Object? includeElements = freezed,
    Object? minConfidence = freezed,
    Object? minLevel = freezed,
  }) {
    return _then(_self.copyWith(
      buildHierarchy: freezed == buildHierarchy
          ? _self.buildHierarchy
          : buildHierarchy // ignore: cast_nullable_to_non_nullable
              as bool?,
      includeElements: freezed == includeElements
          ? _self.includeElements
          : includeElements // ignore: cast_nullable_to_non_nullable
              as bool?,
      minConfidence: freezed == minConfidence
          ? _self.minConfidence
          : minConfidence // ignore: cast_nullable_to_non_nullable
              as double?,
      minLevel: freezed == minLevel
          ? _self.minLevel
          : minLevel // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [OcrElementConfig].
extension OcrElementConfigPatterns on OcrElementConfig {
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
    TResult Function(_OcrElementConfig value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OcrElementConfig() when $default != null:
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
    TResult Function(_OcrElementConfig value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OcrElementConfig():
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
    TResult? Function(_OcrElementConfig value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OcrElementConfig() when $default != null:
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
            @JsonKey(name: 'build_hierarchy') bool? buildHierarchy,
            @JsonKey(name: 'include_elements') bool? includeElements,
            @JsonKey(name: 'min_confidence') double? minConfidence,
            @JsonKey(name: 'min_level') String? minLevel)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OcrElementConfig() when $default != null:
        return $default(_that.buildHierarchy, _that.includeElements,
            _that.minConfidence, _that.minLevel);
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
            @JsonKey(name: 'build_hierarchy') bool? buildHierarchy,
            @JsonKey(name: 'include_elements') bool? includeElements,
            @JsonKey(name: 'min_confidence') double? minConfidence,
            @JsonKey(name: 'min_level') String? minLevel)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OcrElementConfig():
        return $default(_that.buildHierarchy, _that.includeElements,
            _that.minConfidence, _that.minLevel);
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
            @JsonKey(name: 'build_hierarchy') bool? buildHierarchy,
            @JsonKey(name: 'include_elements') bool? includeElements,
            @JsonKey(name: 'min_confidence') double? minConfidence,
            @JsonKey(name: 'min_level') String? minLevel)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OcrElementConfig() when $default != null:
        return $default(_that.buildHierarchy, _that.includeElements,
            _that.minConfidence, _that.minLevel);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OcrElementConfig implements OcrElementConfig {
  const _OcrElementConfig(
      {@JsonKey(name: 'build_hierarchy') this.buildHierarchy,
      @JsonKey(name: 'include_elements') this.includeElements,
      @JsonKey(name: 'min_confidence') this.minConfidence,
      @JsonKey(name: 'min_level') this.minLevel});
  factory _OcrElementConfig.fromJson(Map<String, dynamic> json) =>
      _$OcrElementConfigFromJson(json);

  /// Build parent-child relationships
  @override
  @JsonKey(name: 'build_hierarchy')
  final bool? buildHierarchy;

  /// Include OCR elements in result
  @override
  @JsonKey(name: 'include_elements')
  final bool? includeElements;

  /// Minimum recognition confidence (0.0-1.0)
  @override
  @JsonKey(name: 'min_confidence')
  final double? minConfidence;

  /// Minimum hierarchical level: "word", "line", "block", "page"
  @override
  @JsonKey(name: 'min_level')
  final String? minLevel;

  /// Create a copy of OcrElementConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OcrElementConfigCopyWith<_OcrElementConfig> get copyWith =>
      __$OcrElementConfigCopyWithImpl<_OcrElementConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OcrElementConfigToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OcrElementConfig &&
            (identical(other.buildHierarchy, buildHierarchy) ||
                other.buildHierarchy == buildHierarchy) &&
            (identical(other.includeElements, includeElements) ||
                other.includeElements == includeElements) &&
            (identical(other.minConfidence, minConfidence) ||
                other.minConfidence == minConfidence) &&
            (identical(other.minLevel, minLevel) ||
                other.minLevel == minLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, buildHierarchy, includeElements, minConfidence, minLevel);

  @override
  String toString() {
    return 'OcrElementConfig(buildHierarchy: $buildHierarchy, includeElements: $includeElements, minConfidence: $minConfidence, minLevel: $minLevel)';
  }
}

/// @nodoc
abstract mixin class _$OcrElementConfigCopyWith<$Res>
    implements $OcrElementConfigCopyWith<$Res> {
  factory _$OcrElementConfigCopyWith(
          _OcrElementConfig value, $Res Function(_OcrElementConfig) _then) =
      __$OcrElementConfigCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'build_hierarchy') bool? buildHierarchy,
      @JsonKey(name: 'include_elements') bool? includeElements,
      @JsonKey(name: 'min_confidence') double? minConfidence,
      @JsonKey(name: 'min_level') String? minLevel});
}

/// @nodoc
class __$OcrElementConfigCopyWithImpl<$Res>
    implements _$OcrElementConfigCopyWith<$Res> {
  __$OcrElementConfigCopyWithImpl(this._self, this._then);

  final _OcrElementConfig _self;
  final $Res Function(_OcrElementConfig) _then;

  /// Create a copy of OcrElementConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? buildHierarchy = freezed,
    Object? includeElements = freezed,
    Object? minConfidence = freezed,
    Object? minLevel = freezed,
  }) {
    return _then(_OcrElementConfig(
      buildHierarchy: freezed == buildHierarchy
          ? _self.buildHierarchy
          : buildHierarchy // ignore: cast_nullable_to_non_nullable
              as bool?,
      includeElements: freezed == includeElements
          ? _self.includeElements
          : includeElements // ignore: cast_nullable_to_non_nullable
              as bool?,
      minConfidence: freezed == minConfidence
          ? _self.minConfidence
          : minConfidence // ignore: cast_nullable_to_non_nullable
              as double?,
      minLevel: freezed == minLevel
          ? _self.minLevel
          : minLevel // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
