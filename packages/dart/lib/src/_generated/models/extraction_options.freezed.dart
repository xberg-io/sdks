// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'extraction_options.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExtractionOptions {
  /// Kreuzberg extraction configuration (optional, null = defaults).
  @JsonKey(name: 'extraction_config')
  ExtractionConfig? get extractionConfig;

  /// Create a copy of ExtractionOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExtractionOptionsCopyWith<ExtractionOptions> get copyWith =>
      _$ExtractionOptionsCopyWithImpl<ExtractionOptions>(
          this as ExtractionOptions, _$identity);

  /// Serializes this ExtractionOptions to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExtractionOptions &&
            (identical(other.extractionConfig, extractionConfig) ||
                other.extractionConfig == extractionConfig));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, extractionConfig);

  @override
  String toString() {
    return 'ExtractionOptions(extractionConfig: $extractionConfig)';
  }
}

/// @nodoc
abstract mixin class $ExtractionOptionsCopyWith<$Res> {
  factory $ExtractionOptionsCopyWith(
          ExtractionOptions value, $Res Function(ExtractionOptions) _then) =
      _$ExtractionOptionsCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'extraction_config') ExtractionConfig? extractionConfig});

  $ExtractionConfigCopyWith<$Res>? get extractionConfig;
}

/// @nodoc
class _$ExtractionOptionsCopyWithImpl<$Res>
    implements $ExtractionOptionsCopyWith<$Res> {
  _$ExtractionOptionsCopyWithImpl(this._self, this._then);

  final ExtractionOptions _self;
  final $Res Function(ExtractionOptions) _then;

  /// Create a copy of ExtractionOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? extractionConfig = freezed,
  }) {
    return _then(_self.copyWith(
      extractionConfig: freezed == extractionConfig
          ? _self.extractionConfig
          : extractionConfig // ignore: cast_nullable_to_non_nullable
              as ExtractionConfig?,
    ));
  }

  /// Create a copy of ExtractionOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExtractionConfigCopyWith<$Res>? get extractionConfig {
    if (_self.extractionConfig == null) {
      return null;
    }

    return $ExtractionConfigCopyWith<$Res>(_self.extractionConfig!, (value) {
      return _then(_self.copyWith(extractionConfig: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ExtractionOptions].
extension ExtractionOptionsPatterns on ExtractionOptions {
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
    TResult Function(_ExtractionOptions value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExtractionOptions() when $default != null:
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
    TResult Function(_ExtractionOptions value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExtractionOptions():
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
    TResult? Function(_ExtractionOptions value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExtractionOptions() when $default != null:
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
            @JsonKey(name: 'extraction_config')
            ExtractionConfig? extractionConfig)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExtractionOptions() when $default != null:
        return $default(_that.extractionConfig);
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
            @JsonKey(name: 'extraction_config')
            ExtractionConfig? extractionConfig)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExtractionOptions():
        return $default(_that.extractionConfig);
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
            @JsonKey(name: 'extraction_config')
            ExtractionConfig? extractionConfig)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExtractionOptions() when $default != null:
        return $default(_that.extractionConfig);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExtractionOptions implements ExtractionOptions {
  const _ExtractionOptions(
      {@JsonKey(name: 'extraction_config') this.extractionConfig});
  factory _ExtractionOptions.fromJson(Map<String, dynamic> json) =>
      _$ExtractionOptionsFromJson(json);

  /// Kreuzberg extraction configuration (optional, null = defaults).
  @override
  @JsonKey(name: 'extraction_config')
  final ExtractionConfig? extractionConfig;

  /// Create a copy of ExtractionOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExtractionOptionsCopyWith<_ExtractionOptions> get copyWith =>
      __$ExtractionOptionsCopyWithImpl<_ExtractionOptions>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExtractionOptionsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExtractionOptions &&
            (identical(other.extractionConfig, extractionConfig) ||
                other.extractionConfig == extractionConfig));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, extractionConfig);

  @override
  String toString() {
    return 'ExtractionOptions(extractionConfig: $extractionConfig)';
  }
}

/// @nodoc
abstract mixin class _$ExtractionOptionsCopyWith<$Res>
    implements $ExtractionOptionsCopyWith<$Res> {
  factory _$ExtractionOptionsCopyWith(
          _ExtractionOptions value, $Res Function(_ExtractionOptions) _then) =
      __$ExtractionOptionsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'extraction_config') ExtractionConfig? extractionConfig});

  @override
  $ExtractionConfigCopyWith<$Res>? get extractionConfig;
}

/// @nodoc
class __$ExtractionOptionsCopyWithImpl<$Res>
    implements _$ExtractionOptionsCopyWith<$Res> {
  __$ExtractionOptionsCopyWithImpl(this._self, this._then);

  final _ExtractionOptions _self;
  final $Res Function(_ExtractionOptions) _then;

  /// Create a copy of ExtractionOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? extractionConfig = freezed,
  }) {
    return _then(_ExtractionOptions(
      extractionConfig: freezed == extractionConfig
          ? _self.extractionConfig
          : extractionConfig // ignore: cast_nullable_to_non_nullable
              as ExtractionConfig?,
    ));
  }

  /// Create a copy of ExtractionOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExtractionConfigCopyWith<$Res>? get extractionConfig {
    if (_self.extractionConfig == null) {
      return null;
    }

    return $ExtractionConfigCopyWith<$Res>(_self.extractionConfig!, (value) {
      return _then(_self.copyWith(extractionConfig: value));
    });
  }
}

// dart format on
