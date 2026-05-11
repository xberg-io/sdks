// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bounding_box.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BoundingBox {
  double get x0;
  double get x1;
  double get y0;
  double get y1;

  /// Create a copy of BoundingBox
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BoundingBoxCopyWith<BoundingBox> get copyWith =>
      _$BoundingBoxCopyWithImpl<BoundingBox>(this as BoundingBox, _$identity);

  /// Serializes this BoundingBox to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BoundingBox &&
            (identical(other.x0, x0) || other.x0 == x0) &&
            (identical(other.x1, x1) || other.x1 == x1) &&
            (identical(other.y0, y0) || other.y0 == y0) &&
            (identical(other.y1, y1) || other.y1 == y1));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, x0, x1, y0, y1);

  @override
  String toString() {
    return 'BoundingBox(x0: $x0, x1: $x1, y0: $y0, y1: $y1)';
  }
}

/// @nodoc
abstract mixin class $BoundingBoxCopyWith<$Res> {
  factory $BoundingBoxCopyWith(
          BoundingBox value, $Res Function(BoundingBox) _then) =
      _$BoundingBoxCopyWithImpl;
  @useResult
  $Res call({double x0, double x1, double y0, double y1});
}

/// @nodoc
class _$BoundingBoxCopyWithImpl<$Res> implements $BoundingBoxCopyWith<$Res> {
  _$BoundingBoxCopyWithImpl(this._self, this._then);

  final BoundingBox _self;
  final $Res Function(BoundingBox) _then;

  /// Create a copy of BoundingBox
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x0 = null,
    Object? x1 = null,
    Object? y0 = null,
    Object? y1 = null,
  }) {
    return _then(_self.copyWith(
      x0: null == x0
          ? _self.x0
          : x0 // ignore: cast_nullable_to_non_nullable
              as double,
      x1: null == x1
          ? _self.x1
          : x1 // ignore: cast_nullable_to_non_nullable
              as double,
      y0: null == y0
          ? _self.y0
          : y0 // ignore: cast_nullable_to_non_nullable
              as double,
      y1: null == y1
          ? _self.y1
          : y1 // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [BoundingBox].
extension BoundingBoxPatterns on BoundingBox {
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
    TResult Function(_BoundingBox value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BoundingBox() when $default != null:
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
    TResult Function(_BoundingBox value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BoundingBox():
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
    TResult? Function(_BoundingBox value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BoundingBox() when $default != null:
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
    TResult Function(double x0, double x1, double y0, double y1)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BoundingBox() when $default != null:
        return $default(_that.x0, _that.x1, _that.y0, _that.y1);
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
    TResult Function(double x0, double x1, double y0, double y1) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BoundingBox():
        return $default(_that.x0, _that.x1, _that.y0, _that.y1);
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
    TResult? Function(double x0, double x1, double y0, double y1)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BoundingBox() when $default != null:
        return $default(_that.x0, _that.x1, _that.y0, _that.y1);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BoundingBox implements BoundingBox {
  const _BoundingBox(
      {required this.x0, required this.x1, required this.y0, required this.y1});
  factory _BoundingBox.fromJson(Map<String, dynamic> json) =>
      _$BoundingBoxFromJson(json);

  @override
  final double x0;
  @override
  final double x1;
  @override
  final double y0;
  @override
  final double y1;

  /// Create a copy of BoundingBox
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BoundingBoxCopyWith<_BoundingBox> get copyWith =>
      __$BoundingBoxCopyWithImpl<_BoundingBox>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BoundingBoxToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BoundingBox &&
            (identical(other.x0, x0) || other.x0 == x0) &&
            (identical(other.x1, x1) || other.x1 == x1) &&
            (identical(other.y0, y0) || other.y0 == y0) &&
            (identical(other.y1, y1) || other.y1 == y1));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, x0, x1, y0, y1);

  @override
  String toString() {
    return 'BoundingBox(x0: $x0, x1: $x1, y0: $y0, y1: $y1)';
  }
}

/// @nodoc
abstract mixin class _$BoundingBoxCopyWith<$Res>
    implements $BoundingBoxCopyWith<$Res> {
  factory _$BoundingBoxCopyWith(
          _BoundingBox value, $Res Function(_BoundingBox) _then) =
      __$BoundingBoxCopyWithImpl;
  @override
  @useResult
  $Res call({double x0, double x1, double y0, double y1});
}

/// @nodoc
class __$BoundingBoxCopyWithImpl<$Res> implements _$BoundingBoxCopyWith<$Res> {
  __$BoundingBoxCopyWithImpl(this._self, this._then);

  final _BoundingBox _self;
  final $Res Function(_BoundingBox) _then;

  /// Create a copy of BoundingBox
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? x0 = null,
    Object? x1 = null,
    Object? y0 = null,
    Object? y1 = null,
  }) {
    return _then(_BoundingBox(
      x0: null == x0
          ? _self.x0
          : x0 // ignore: cast_nullable_to_non_nullable
              as double,
      x1: null == x1
          ? _self.x1
          : x1 // ignore: cast_nullable_to_non_nullable
              as double,
      y0: null == y0
          ? _self.y0
          : y0 // ignore: cast_nullable_to_non_nullable
              as double,
      y1: null == y1
          ? _self.y1
          : y1 // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
