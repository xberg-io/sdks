// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'row.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Row {
  List<String> get values;

  /// Create a copy of Row
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RowCopyWith<Row> get copyWith =>
      _$RowCopyWithImpl<Row>(this as Row, _$identity);

  /// Serializes this Row to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Row &&
            const DeepCollectionEquality().equals(other.values, values));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(values));

  @override
  String toString() {
    return 'Row(values: $values)';
  }
}

/// @nodoc
abstract mixin class $RowCopyWith<$Res> {
  factory $RowCopyWith(Row value, $Res Function(Row) _then) = _$RowCopyWithImpl;
  @useResult
  $Res call({List<String> values});
}

/// @nodoc
class _$RowCopyWithImpl<$Res> implements $RowCopyWith<$Res> {
  _$RowCopyWithImpl(this._self, this._then);

  final Row _self;
  final $Res Function(Row) _then;

  /// Create a copy of Row
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_self.copyWith(
      values: null == values
          ? _self.values
          : values // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [Row].
extension RowPatterns on Row {
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
    TResult Function(_Row value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Row() when $default != null:
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
    TResult Function(_Row value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Row():
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
    TResult? Function(_Row value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Row() when $default != null:
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
    TResult Function(List<String> values)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Row() when $default != null:
        return $default(_that.values);
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
    TResult Function(List<String> values) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Row():
        return $default(_that.values);
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
    TResult? Function(List<String> values)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Row() when $default != null:
        return $default(_that.values);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Row implements Row {
  const _Row({required final List<String> values}) : _values = values;
  factory _Row.fromJson(Map<String, dynamic> json) => _$RowFromJson(json);

  final List<String> _values;
  @override
  List<String> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  /// Create a copy of Row
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RowCopyWith<_Row> get copyWith =>
      __$RowCopyWithImpl<_Row>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RowToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Row &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  @override
  String toString() {
    return 'Row(values: $values)';
  }
}

/// @nodoc
abstract mixin class _$RowCopyWith<$Res> implements $RowCopyWith<$Res> {
  factory _$RowCopyWith(_Row value, $Res Function(_Row) _then) =
      __$RowCopyWithImpl;
  @override
  @useResult
  $Res call({List<String> values});
}

/// @nodoc
class __$RowCopyWithImpl<$Res> implements _$RowCopyWith<$Res> {
  __$RowCopyWithImpl(this._self, this._then);

  final _Row _self;
  final $Res Function(_Row) _then;

  /// Create a copy of Row
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? values = null,
  }) {
    return _then(_Row(
      values: null == values
          ? _self._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
