// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_structure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PageStructure {
  @JsonKey(name: 'total_count')
  int get totalCount;

  /// Create a copy of PageStructure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PageStructureCopyWith<PageStructure> get copyWith =>
      _$PageStructureCopyWithImpl<PageStructure>(
          this as PageStructure, _$identity);

  /// Serializes this PageStructure to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PageStructure &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalCount);

  @override
  String toString() {
    return 'PageStructure(totalCount: $totalCount)';
  }
}

/// @nodoc
abstract mixin class $PageStructureCopyWith<$Res> {
  factory $PageStructureCopyWith(
          PageStructure value, $Res Function(PageStructure) _then) =
      _$PageStructureCopyWithImpl;
  @useResult
  $Res call({@JsonKey(name: 'total_count') int totalCount});
}

/// @nodoc
class _$PageStructureCopyWithImpl<$Res>
    implements $PageStructureCopyWith<$Res> {
  _$PageStructureCopyWithImpl(this._self, this._then);

  final PageStructure _self;
  final $Res Function(PageStructure) _then;

  /// Create a copy of PageStructure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
  }) {
    return _then(_self.copyWith(
      totalCount: null == totalCount
          ? _self.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [PageStructure].
extension PageStructurePatterns on PageStructure {
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
    TResult Function(_PageStructure value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PageStructure() when $default != null:
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
    TResult Function(_PageStructure value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PageStructure():
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
    TResult? Function(_PageStructure value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PageStructure() when $default != null:
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
    TResult Function(@JsonKey(name: 'total_count') int totalCount)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PageStructure() when $default != null:
        return $default(_that.totalCount);
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
    TResult Function(@JsonKey(name: 'total_count') int totalCount) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PageStructure():
        return $default(_that.totalCount);
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
    TResult? Function(@JsonKey(name: 'total_count') int totalCount)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PageStructure() when $default != null:
        return $default(_that.totalCount);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PageStructure implements PageStructure {
  const _PageStructure(
      {@JsonKey(name: 'total_count') required this.totalCount});
  factory _PageStructure.fromJson(Map<String, dynamic> json) =>
      _$PageStructureFromJson(json);

  @override
  @JsonKey(name: 'total_count')
  final int totalCount;

  /// Create a copy of PageStructure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PageStructureCopyWith<_PageStructure> get copyWith =>
      __$PageStructureCopyWithImpl<_PageStructure>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PageStructureToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PageStructure &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalCount);

  @override
  String toString() {
    return 'PageStructure(totalCount: $totalCount)';
  }
}

/// @nodoc
abstract mixin class _$PageStructureCopyWith<$Res>
    implements $PageStructureCopyWith<$Res> {
  factory _$PageStructureCopyWith(
          _PageStructure value, $Res Function(_PageStructure) _then) =
      __$PageStructureCopyWithImpl;
  @override
  @useResult
  $Res call({@JsonKey(name: 'total_count') int totalCount});
}

/// @nodoc
class __$PageStructureCopyWithImpl<$Res>
    implements _$PageStructureCopyWith<$Res> {
  __$PageStructureCopyWithImpl(this._self, this._then);

  final _PageStructure _self;
  final $Res Function(_PageStructure) _then;

  /// Create a copy of PageStructure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? totalCount = null,
  }) {
    return _then(_PageStructure(
      totalCount: null == totalCount
          ? _self.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
