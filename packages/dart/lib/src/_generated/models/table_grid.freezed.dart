// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'table_grid.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TableGrid {

/// All cells in row-major order.
 List<GridCell> get cells;/// Number of columns in the table.
 int get cols;/// Number of rows in the table.
 int get rows;
/// Create a copy of TableGrid
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TableGridCopyWith<TableGrid> get copyWith => _$TableGridCopyWithImpl<TableGrid>(this as TableGrid, _$identity);

  /// Serializes this TableGrid to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TableGrid&&const DeepCollectionEquality().equals(other.cells, cells)&&(identical(other.cols, cols) || other.cols == cols)&&(identical(other.rows, rows) || other.rows == rows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(cells),cols,rows);

@override
String toString() {
  return 'TableGrid(cells: $cells, cols: $cols, rows: $rows)';
}


}

/// @nodoc
abstract mixin class $TableGridCopyWith<$Res>  {
  factory $TableGridCopyWith(TableGrid value, $Res Function(TableGrid) _then) = _$TableGridCopyWithImpl;
@useResult
$Res call({
 List<GridCell> cells, int cols, int rows
});




}
/// @nodoc
class _$TableGridCopyWithImpl<$Res>
    implements $TableGridCopyWith<$Res> {
  _$TableGridCopyWithImpl(this._self, this._then);

  final TableGrid _self;
  final $Res Function(TableGrid) _then;

/// Create a copy of TableGrid
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cells = null,Object? cols = null,Object? rows = null,}) {
  return _then(_self.copyWith(
cells: null == cells ? _self.cells : cells // ignore: cast_nullable_to_non_nullable
as List<GridCell>,cols: null == cols ? _self.cols : cols // ignore: cast_nullable_to_non_nullable
as int,rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TableGrid].
extension TableGridPatterns on TableGrid {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TableGrid value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TableGrid() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TableGrid value)  $default,){
final _that = this;
switch (_that) {
case _TableGrid():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TableGrid value)?  $default,){
final _that = this;
switch (_that) {
case _TableGrid() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<GridCell> cells,  int cols,  int rows)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TableGrid() when $default != null:
return $default(_that.cells,_that.cols,_that.rows);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<GridCell> cells,  int cols,  int rows)  $default,) {final _that = this;
switch (_that) {
case _TableGrid():
return $default(_that.cells,_that.cols,_that.rows);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<GridCell> cells,  int cols,  int rows)?  $default,) {final _that = this;
switch (_that) {
case _TableGrid() when $default != null:
return $default(_that.cells,_that.cols,_that.rows);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TableGrid implements TableGrid {
  const _TableGrid({required final  List<GridCell> cells, required this.cols, required this.rows}): _cells = cells;
  factory _TableGrid.fromJson(Map<String, dynamic> json) => _$TableGridFromJson(json);

/// All cells in row-major order.
 final  List<GridCell> _cells;
/// All cells in row-major order.
@override List<GridCell> get cells {
  if (_cells is EqualUnmodifiableListView) return _cells;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cells);
}

/// Number of columns in the table.
@override final  int cols;
/// Number of rows in the table.
@override final  int rows;

/// Create a copy of TableGrid
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TableGridCopyWith<_TableGrid> get copyWith => __$TableGridCopyWithImpl<_TableGrid>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TableGridToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TableGrid&&const DeepCollectionEquality().equals(other._cells, _cells)&&(identical(other.cols, cols) || other.cols == cols)&&(identical(other.rows, rows) || other.rows == rows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cells),cols,rows);

@override
String toString() {
  return 'TableGrid(cells: $cells, cols: $cols, rows: $rows)';
}


}

/// @nodoc
abstract mixin class _$TableGridCopyWith<$Res> implements $TableGridCopyWith<$Res> {
  factory _$TableGridCopyWith(_TableGrid value, $Res Function(_TableGrid) _then) = __$TableGridCopyWithImpl;
@override @useResult
$Res call({
 List<GridCell> cells, int cols, int rows
});




}
/// @nodoc
class __$TableGridCopyWithImpl<$Res>
    implements _$TableGridCopyWith<$Res> {
  __$TableGridCopyWithImpl(this._self, this._then);

  final _TableGrid _self;
  final $Res Function(_TableGrid) _then;

/// Create a copy of TableGrid
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cells = null,Object? cols = null,Object? rows = null,}) {
  return _then(_TableGrid(
cells: null == cells ? _self._cells : cells // ignore: cast_nullable_to_non_nullable
as List<GridCell>,cols: null == cols ? _self.cols : cols // ignore: cast_nullable_to_non_nullable
as int,rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
