// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'layout_detection_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LayoutDetectionConfig {
  /// Apply postprocessing heuristics
  @JsonKey(name: 'apply_heuristics')
  bool? get applyHeuristics;

  /// Confidence threshold override
  @JsonKey(name: 'confidence_threshold')
  double? get confidenceThreshold;

  /// Preset: "fast" or "accurate"
  String? get preset;

  /// Create a copy of LayoutDetectionConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LayoutDetectionConfigCopyWith<LayoutDetectionConfig> get copyWith =>
      _$LayoutDetectionConfigCopyWithImpl<LayoutDetectionConfig>(
          this as LayoutDetectionConfig, _$identity);

  /// Serializes this LayoutDetectionConfig to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LayoutDetectionConfig &&
            (identical(other.applyHeuristics, applyHeuristics) ||
                other.applyHeuristics == applyHeuristics) &&
            (identical(other.confidenceThreshold, confidenceThreshold) ||
                other.confidenceThreshold == confidenceThreshold) &&
            (identical(other.preset, preset) || other.preset == preset));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, applyHeuristics, confidenceThreshold, preset);

  @override
  String toString() {
    return 'LayoutDetectionConfig(applyHeuristics: $applyHeuristics, confidenceThreshold: $confidenceThreshold, preset: $preset)';
  }
}

/// @nodoc
abstract mixin class $LayoutDetectionConfigCopyWith<$Res> {
  factory $LayoutDetectionConfigCopyWith(LayoutDetectionConfig value,
          $Res Function(LayoutDetectionConfig) _then) =
      _$LayoutDetectionConfigCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'apply_heuristics') bool? applyHeuristics,
      @JsonKey(name: 'confidence_threshold') double? confidenceThreshold,
      String? preset});
}

/// @nodoc
class _$LayoutDetectionConfigCopyWithImpl<$Res>
    implements $LayoutDetectionConfigCopyWith<$Res> {
  _$LayoutDetectionConfigCopyWithImpl(this._self, this._then);

  final LayoutDetectionConfig _self;
  final $Res Function(LayoutDetectionConfig) _then;

  /// Create a copy of LayoutDetectionConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? applyHeuristics = freezed,
    Object? confidenceThreshold = freezed,
    Object? preset = freezed,
  }) {
    return _then(_self.copyWith(
      applyHeuristics: freezed == applyHeuristics
          ? _self.applyHeuristics
          : applyHeuristics // ignore: cast_nullable_to_non_nullable
              as bool?,
      confidenceThreshold: freezed == confidenceThreshold
          ? _self.confidenceThreshold
          : confidenceThreshold // ignore: cast_nullable_to_non_nullable
              as double?,
      preset: freezed == preset
          ? _self.preset
          : preset // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [LayoutDetectionConfig].
extension LayoutDetectionConfigPatterns on LayoutDetectionConfig {
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
    TResult Function(_LayoutDetectionConfig value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LayoutDetectionConfig() when $default != null:
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
    TResult Function(_LayoutDetectionConfig value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LayoutDetectionConfig():
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
    TResult? Function(_LayoutDetectionConfig value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LayoutDetectionConfig() when $default != null:
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
            @JsonKey(name: 'apply_heuristics') bool? applyHeuristics,
            @JsonKey(name: 'confidence_threshold') double? confidenceThreshold,
            String? preset)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LayoutDetectionConfig() when $default != null:
        return $default(
            _that.applyHeuristics, _that.confidenceThreshold, _that.preset);
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
            @JsonKey(name: 'apply_heuristics') bool? applyHeuristics,
            @JsonKey(name: 'confidence_threshold') double? confidenceThreshold,
            String? preset)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LayoutDetectionConfig():
        return $default(
            _that.applyHeuristics, _that.confidenceThreshold, _that.preset);
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
            @JsonKey(name: 'apply_heuristics') bool? applyHeuristics,
            @JsonKey(name: 'confidence_threshold') double? confidenceThreshold,
            String? preset)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LayoutDetectionConfig() when $default != null:
        return $default(
            _that.applyHeuristics, _that.confidenceThreshold, _that.preset);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LayoutDetectionConfig implements LayoutDetectionConfig {
  const _LayoutDetectionConfig(
      {@JsonKey(name: 'apply_heuristics') this.applyHeuristics,
      @JsonKey(name: 'confidence_threshold') this.confidenceThreshold,
      this.preset});
  factory _LayoutDetectionConfig.fromJson(Map<String, dynamic> json) =>
      _$LayoutDetectionConfigFromJson(json);

  /// Apply postprocessing heuristics
  @override
  @JsonKey(name: 'apply_heuristics')
  final bool? applyHeuristics;

  /// Confidence threshold override
  @override
  @JsonKey(name: 'confidence_threshold')
  final double? confidenceThreshold;

  /// Preset: "fast" or "accurate"
  @override
  final String? preset;

  /// Create a copy of LayoutDetectionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LayoutDetectionConfigCopyWith<_LayoutDetectionConfig> get copyWith =>
      __$LayoutDetectionConfigCopyWithImpl<_LayoutDetectionConfig>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LayoutDetectionConfigToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LayoutDetectionConfig &&
            (identical(other.applyHeuristics, applyHeuristics) ||
                other.applyHeuristics == applyHeuristics) &&
            (identical(other.confidenceThreshold, confidenceThreshold) ||
                other.confidenceThreshold == confidenceThreshold) &&
            (identical(other.preset, preset) || other.preset == preset));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, applyHeuristics, confidenceThreshold, preset);

  @override
  String toString() {
    return 'LayoutDetectionConfig(applyHeuristics: $applyHeuristics, confidenceThreshold: $confidenceThreshold, preset: $preset)';
  }
}

/// @nodoc
abstract mixin class _$LayoutDetectionConfigCopyWith<$Res>
    implements $LayoutDetectionConfigCopyWith<$Res> {
  factory _$LayoutDetectionConfigCopyWith(_LayoutDetectionConfig value,
          $Res Function(_LayoutDetectionConfig) _then) =
      __$LayoutDetectionConfigCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'apply_heuristics') bool? applyHeuristics,
      @JsonKey(name: 'confidence_threshold') double? confidenceThreshold,
      String? preset});
}

/// @nodoc
class __$LayoutDetectionConfigCopyWithImpl<$Res>
    implements _$LayoutDetectionConfigCopyWith<$Res> {
  __$LayoutDetectionConfigCopyWithImpl(this._self, this._then);

  final _LayoutDetectionConfig _self;
  final $Res Function(_LayoutDetectionConfig) _then;

  /// Create a copy of LayoutDetectionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? applyHeuristics = freezed,
    Object? confidenceThreshold = freezed,
    Object? preset = freezed,
  }) {
    return _then(_LayoutDetectionConfig(
      applyHeuristics: freezed == applyHeuristics
          ? _self.applyHeuristics
          : applyHeuristics // ignore: cast_nullable_to_non_nullable
              as bool?,
      confidenceThreshold: freezed == confidenceThreshold
          ? _self.confidenceThreshold
          : confidenceThreshold // ignore: cast_nullable_to_non_nullable
              as double?,
      preset: freezed == preset
          ? _self.preset
          : preset // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
