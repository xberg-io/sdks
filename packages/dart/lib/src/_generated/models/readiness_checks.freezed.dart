// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'readiness_checks.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReadinessChecks {
  /// Database connectivity
  String get database;

  /// NATS connectivity
  String get nats;

  /// Create a copy of ReadinessChecks
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReadinessChecksCopyWith<ReadinessChecks> get copyWith =>
      _$ReadinessChecksCopyWithImpl<ReadinessChecks>(
          this as ReadinessChecks, _$identity);

  /// Serializes this ReadinessChecks to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReadinessChecks &&
            (identical(other.database, database) ||
                other.database == database) &&
            (identical(other.nats, nats) || other.nats == nats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, database, nats);

  @override
  String toString() {
    return 'ReadinessChecks(database: $database, nats: $nats)';
  }
}

/// @nodoc
abstract mixin class $ReadinessChecksCopyWith<$Res> {
  factory $ReadinessChecksCopyWith(
          ReadinessChecks value, $Res Function(ReadinessChecks) _then) =
      _$ReadinessChecksCopyWithImpl;
  @useResult
  $Res call({String database, String nats});
}

/// @nodoc
class _$ReadinessChecksCopyWithImpl<$Res>
    implements $ReadinessChecksCopyWith<$Res> {
  _$ReadinessChecksCopyWithImpl(this._self, this._then);

  final ReadinessChecks _self;
  final $Res Function(ReadinessChecks) _then;

  /// Create a copy of ReadinessChecks
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? database = null,
    Object? nats = null,
  }) {
    return _then(_self.copyWith(
      database: null == database
          ? _self.database
          : database // ignore: cast_nullable_to_non_nullable
              as String,
      nats: null == nats
          ? _self.nats
          : nats // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ReadinessChecks].
extension ReadinessChecksPatterns on ReadinessChecks {
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
    TResult Function(_ReadinessChecks value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReadinessChecks() when $default != null:
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
    TResult Function(_ReadinessChecks value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReadinessChecks():
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
    TResult? Function(_ReadinessChecks value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReadinessChecks() when $default != null:
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
    TResult Function(String database, String nats)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReadinessChecks() when $default != null:
        return $default(_that.database, _that.nats);
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
    TResult Function(String database, String nats) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReadinessChecks():
        return $default(_that.database, _that.nats);
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
    TResult? Function(String database, String nats)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReadinessChecks() when $default != null:
        return $default(_that.database, _that.nats);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ReadinessChecks implements ReadinessChecks {
  const _ReadinessChecks({required this.database, required this.nats});
  factory _ReadinessChecks.fromJson(Map<String, dynamic> json) =>
      _$ReadinessChecksFromJson(json);

  /// Database connectivity
  @override
  final String database;

  /// NATS connectivity
  @override
  final String nats;

  /// Create a copy of ReadinessChecks
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReadinessChecksCopyWith<_ReadinessChecks> get copyWith =>
      __$ReadinessChecksCopyWithImpl<_ReadinessChecks>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ReadinessChecksToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReadinessChecks &&
            (identical(other.database, database) ||
                other.database == database) &&
            (identical(other.nats, nats) || other.nats == nats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, database, nats);

  @override
  String toString() {
    return 'ReadinessChecks(database: $database, nats: $nats)';
  }
}

/// @nodoc
abstract mixin class _$ReadinessChecksCopyWith<$Res>
    implements $ReadinessChecksCopyWith<$Res> {
  factory _$ReadinessChecksCopyWith(
          _ReadinessChecks value, $Res Function(_ReadinessChecks) _then) =
      __$ReadinessChecksCopyWithImpl;
  @override
  @useResult
  $Res call({String database, String nats});
}

/// @nodoc
class __$ReadinessChecksCopyWithImpl<$Res>
    implements _$ReadinessChecksCopyWith<$Res> {
  __$ReadinessChecksCopyWithImpl(this._self, this._then);

  final _ReadinessChecks _self;
  final $Res Function(_ReadinessChecks) _then;

  /// Create a copy of ReadinessChecks
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? database = null,
    Object? nats = null,
  }) {
    return _then(_ReadinessChecks(
      database: null == database
          ? _self.database
          : database // ignore: cast_nullable_to_non_nullable
              as String,
      nats: null == nats
          ? _self.nats
          : nats // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
