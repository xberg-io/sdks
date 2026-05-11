// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'table.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Table {
  /// Bounding box on the page
  @JsonKey(name: 'bounding_box')
  BoundingBox? get boundingBox;

  /// 2D grid of cells (rows of string values)
  List<Row>? get cells;

  /// Markdown representation of the table
  String? get markdown;

  /// Page number (0-indexed)
  @JsonKey(name: 'page_number')
  int? get pageNumber;

  /// Create a copy of Table
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TableCopyWith<Table> get copyWith =>
      _$TableCopyWithImpl<Table>(this as Table, _$identity);

  /// Serializes this Table to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Table &&
            (identical(other.boundingBox, boundingBox) ||
                other.boundingBox == boundingBox) &&
            const DeepCollectionEquality().equals(other.cells, cells) &&
            (identical(other.markdown, markdown) ||
                other.markdown == markdown) &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, boundingBox,
      const DeepCollectionEquality().hash(cells), markdown, pageNumber);

  @override
  String toString() {
    return 'Table(boundingBox: $boundingBox, cells: $cells, markdown: $markdown, pageNumber: $pageNumber)';
  }
}

/// @nodoc
abstract mixin class $TableCopyWith<$Res> {
  factory $TableCopyWith(Table value, $Res Function(Table) _then) =
      _$TableCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'bounding_box') BoundingBox? boundingBox,
      List<Row>? cells,
      String? markdown,
      @JsonKey(name: 'page_number') int? pageNumber});

  $BoundingBoxCopyWith<$Res>? get boundingBox;
}

/// @nodoc
class _$TableCopyWithImpl<$Res> implements $TableCopyWith<$Res> {
  _$TableCopyWithImpl(this._self, this._then);

  final Table _self;
  final $Res Function(Table) _then;

  /// Create a copy of Table
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? boundingBox = freezed,
    Object? cells = freezed,
    Object? markdown = freezed,
    Object? pageNumber = freezed,
  }) {
    return _then(_self.copyWith(
      boundingBox: freezed == boundingBox
          ? _self.boundingBox
          : boundingBox // ignore: cast_nullable_to_non_nullable
              as BoundingBox?,
      cells: freezed == cells
          ? _self.cells
          : cells // ignore: cast_nullable_to_non_nullable
              as List<Row>?,
      markdown: freezed == markdown
          ? _self.markdown
          : markdown // ignore: cast_nullable_to_non_nullable
              as String?,
      pageNumber: freezed == pageNumber
          ? _self.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of Table
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BoundingBoxCopyWith<$Res>? get boundingBox {
    if (_self.boundingBox == null) {
      return null;
    }

    return $BoundingBoxCopyWith<$Res>(_self.boundingBox!, (value) {
      return _then(_self.copyWith(boundingBox: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Table].
extension TablePatterns on Table {
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
    TResult Function(_Table value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Table() when $default != null:
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
    TResult Function(_Table value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Table():
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
    TResult? Function(_Table value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Table() when $default != null:
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
            @JsonKey(name: 'bounding_box') BoundingBox? boundingBox,
            List<Row>? cells,
            String? markdown,
            @JsonKey(name: 'page_number') int? pageNumber)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Table() when $default != null:
        return $default(
            _that.boundingBox, _that.cells, _that.markdown, _that.pageNumber);
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
            @JsonKey(name: 'bounding_box') BoundingBox? boundingBox,
            List<Row>? cells,
            String? markdown,
            @JsonKey(name: 'page_number') int? pageNumber)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Table():
        return $default(
            _that.boundingBox, _that.cells, _that.markdown, _that.pageNumber);
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
            @JsonKey(name: 'bounding_box') BoundingBox? boundingBox,
            List<Row>? cells,
            String? markdown,
            @JsonKey(name: 'page_number') int? pageNumber)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Table() when $default != null:
        return $default(
            _that.boundingBox, _that.cells, _that.markdown, _that.pageNumber);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Table implements Table {
  const _Table(
      {@JsonKey(name: 'bounding_box') this.boundingBox,
      final List<Row>? cells,
      this.markdown,
      @JsonKey(name: 'page_number') this.pageNumber})
      : _cells = cells;
  factory _Table.fromJson(Map<String, dynamic> json) => _$TableFromJson(json);

  /// Bounding box on the page
  @override
  @JsonKey(name: 'bounding_box')
  final BoundingBox? boundingBox;

  /// 2D grid of cells (rows of string values)
  final List<Row>? _cells;

  /// 2D grid of cells (rows of string values)
  @override
  List<Row>? get cells {
    final value = _cells;
    if (value == null) return null;
    if (_cells is EqualUnmodifiableListView) return _cells;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Markdown representation of the table
  @override
  final String? markdown;

  /// Page number (0-indexed)
  @override
  @JsonKey(name: 'page_number')
  final int? pageNumber;

  /// Create a copy of Table
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TableCopyWith<_Table> get copyWith =>
      __$TableCopyWithImpl<_Table>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TableToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Table &&
            (identical(other.boundingBox, boundingBox) ||
                other.boundingBox == boundingBox) &&
            const DeepCollectionEquality().equals(other._cells, _cells) &&
            (identical(other.markdown, markdown) ||
                other.markdown == markdown) &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, boundingBox,
      const DeepCollectionEquality().hash(_cells), markdown, pageNumber);

  @override
  String toString() {
    return 'Table(boundingBox: $boundingBox, cells: $cells, markdown: $markdown, pageNumber: $pageNumber)';
  }
}

/// @nodoc
abstract mixin class _$TableCopyWith<$Res> implements $TableCopyWith<$Res> {
  factory _$TableCopyWith(_Table value, $Res Function(_Table) _then) =
      __$TableCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'bounding_box') BoundingBox? boundingBox,
      List<Row>? cells,
      String? markdown,
      @JsonKey(name: 'page_number') int? pageNumber});

  @override
  $BoundingBoxCopyWith<$Res>? get boundingBox;
}

/// @nodoc
class __$TableCopyWithImpl<$Res> implements _$TableCopyWith<$Res> {
  __$TableCopyWithImpl(this._self, this._then);

  final _Table _self;
  final $Res Function(_Table) _then;

  /// Create a copy of Table
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? boundingBox = freezed,
    Object? cells = freezed,
    Object? markdown = freezed,
    Object? pageNumber = freezed,
  }) {
    return _then(_Table(
      boundingBox: freezed == boundingBox
          ? _self.boundingBox
          : boundingBox // ignore: cast_nullable_to_non_nullable
              as BoundingBox?,
      cells: freezed == cells
          ? _self._cells
          : cells // ignore: cast_nullable_to_non_nullable
              as List<Row>?,
      markdown: freezed == markdown
          ? _self.markdown
          : markdown // ignore: cast_nullable_to_non_nullable
              as String?,
      pageNumber: freezed == pageNumber
          ? _self.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of Table
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BoundingBoxCopyWith<$Res>? get boundingBox {
    if (_self.boundingBox == null) {
      return null;
    }

    return $BoundingBoxCopyWith<$Res>(_self.boundingBox!, (value) {
      return _then(_self.copyWith(boundingBox: value));
    });
  }
}

// dart format on
