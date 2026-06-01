// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grid_cell.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GridCell {

/// Zero-indexed column position.
 int get col;/// Cell text content.
 String get content;/// Zero-indexed row position.
 int get row;/// Bounding box for this cell (if available).
 BoundingBox? get bbox;/// Number of columns this cell spans.
@JsonKey(name: 'col_span') int? get colSpan;/// Whether this is a header cell.
@JsonKey(name: 'is_header') bool? get isHeader;/// Number of rows this cell spans.
@JsonKey(name: 'row_span') int? get rowSpan;
/// Create a copy of GridCell
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GridCellCopyWith<GridCell> get copyWith => _$GridCellCopyWithImpl<GridCell>(this as GridCell, _$identity);

  /// Serializes this GridCell to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GridCell&&(identical(other.col, col) || other.col == col)&&(identical(other.content, content) || other.content == content)&&(identical(other.row, row) || other.row == row)&&(identical(other.bbox, bbox) || other.bbox == bbox)&&(identical(other.colSpan, colSpan) || other.colSpan == colSpan)&&(identical(other.isHeader, isHeader) || other.isHeader == isHeader)&&(identical(other.rowSpan, rowSpan) || other.rowSpan == rowSpan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,col,content,row,bbox,colSpan,isHeader,rowSpan);

@override
String toString() {
  return 'GridCell(col: $col, content: $content, row: $row, bbox: $bbox, colSpan: $colSpan, isHeader: $isHeader, rowSpan: $rowSpan)';
}


}

/// @nodoc
abstract mixin class $GridCellCopyWith<$Res>  {
  factory $GridCellCopyWith(GridCell value, $Res Function(GridCell) _then) = _$GridCellCopyWithImpl;
@useResult
$Res call({
 int col, String content, int row, BoundingBox? bbox,@JsonKey(name: 'col_span') int? colSpan,@JsonKey(name: 'is_header') bool? isHeader,@JsonKey(name: 'row_span') int? rowSpan
});


$BoundingBoxCopyWith<$Res>? get bbox;

}
/// @nodoc
class _$GridCellCopyWithImpl<$Res>
    implements $GridCellCopyWith<$Res> {
  _$GridCellCopyWithImpl(this._self, this._then);

  final GridCell _self;
  final $Res Function(GridCell) _then;

/// Create a copy of GridCell
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? col = null,Object? content = null,Object? row = null,Object? bbox = freezed,Object? colSpan = freezed,Object? isHeader = freezed,Object? rowSpan = freezed,}) {
  return _then(_self.copyWith(
col: null == col ? _self.col : col // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,row: null == row ? _self.row : row // ignore: cast_nullable_to_non_nullable
as int,bbox: freezed == bbox ? _self.bbox : bbox // ignore: cast_nullable_to_non_nullable
as BoundingBox?,colSpan: freezed == colSpan ? _self.colSpan : colSpan // ignore: cast_nullable_to_non_nullable
as int?,isHeader: freezed == isHeader ? _self.isHeader : isHeader // ignore: cast_nullable_to_non_nullable
as bool?,rowSpan: freezed == rowSpan ? _self.rowSpan : rowSpan // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of GridCell
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoundingBoxCopyWith<$Res>? get bbox {
    if (_self.bbox == null) {
    return null;
  }

  return $BoundingBoxCopyWith<$Res>(_self.bbox!, (value) {
    return _then(_self.copyWith(bbox: value));
  });
}
}


/// Adds pattern-matching-related methods to [GridCell].
extension GridCellPatterns on GridCell {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GridCell value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GridCell() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GridCell value)  $default,){
final _that = this;
switch (_that) {
case _GridCell():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GridCell value)?  $default,){
final _that = this;
switch (_that) {
case _GridCell() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int col,  String content,  int row,  BoundingBox? bbox, @JsonKey(name: 'col_span')  int? colSpan, @JsonKey(name: 'is_header')  bool? isHeader, @JsonKey(name: 'row_span')  int? rowSpan)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GridCell() when $default != null:
return $default(_that.col,_that.content,_that.row,_that.bbox,_that.colSpan,_that.isHeader,_that.rowSpan);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int col,  String content,  int row,  BoundingBox? bbox, @JsonKey(name: 'col_span')  int? colSpan, @JsonKey(name: 'is_header')  bool? isHeader, @JsonKey(name: 'row_span')  int? rowSpan)  $default,) {final _that = this;
switch (_that) {
case _GridCell():
return $default(_that.col,_that.content,_that.row,_that.bbox,_that.colSpan,_that.isHeader,_that.rowSpan);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int col,  String content,  int row,  BoundingBox? bbox, @JsonKey(name: 'col_span')  int? colSpan, @JsonKey(name: 'is_header')  bool? isHeader, @JsonKey(name: 'row_span')  int? rowSpan)?  $default,) {final _that = this;
switch (_that) {
case _GridCell() when $default != null:
return $default(_that.col,_that.content,_that.row,_that.bbox,_that.colSpan,_that.isHeader,_that.rowSpan);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GridCell implements GridCell {
  const _GridCell({required this.col, required this.content, required this.row, this.bbox, @JsonKey(name: 'col_span') this.colSpan, @JsonKey(name: 'is_header') this.isHeader, @JsonKey(name: 'row_span') this.rowSpan});
  factory _GridCell.fromJson(Map<String, dynamic> json) => _$GridCellFromJson(json);

/// Zero-indexed column position.
@override final  int col;
/// Cell text content.
@override final  String content;
/// Zero-indexed row position.
@override final  int row;
/// Bounding box for this cell (if available).
@override final  BoundingBox? bbox;
/// Number of columns this cell spans.
@override@JsonKey(name: 'col_span') final  int? colSpan;
/// Whether this is a header cell.
@override@JsonKey(name: 'is_header') final  bool? isHeader;
/// Number of rows this cell spans.
@override@JsonKey(name: 'row_span') final  int? rowSpan;

/// Create a copy of GridCell
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GridCellCopyWith<_GridCell> get copyWith => __$GridCellCopyWithImpl<_GridCell>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GridCellToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GridCell&&(identical(other.col, col) || other.col == col)&&(identical(other.content, content) || other.content == content)&&(identical(other.row, row) || other.row == row)&&(identical(other.bbox, bbox) || other.bbox == bbox)&&(identical(other.colSpan, colSpan) || other.colSpan == colSpan)&&(identical(other.isHeader, isHeader) || other.isHeader == isHeader)&&(identical(other.rowSpan, rowSpan) || other.rowSpan == rowSpan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,col,content,row,bbox,colSpan,isHeader,rowSpan);

@override
String toString() {
  return 'GridCell(col: $col, content: $content, row: $row, bbox: $bbox, colSpan: $colSpan, isHeader: $isHeader, rowSpan: $rowSpan)';
}


}

/// @nodoc
abstract mixin class _$GridCellCopyWith<$Res> implements $GridCellCopyWith<$Res> {
  factory _$GridCellCopyWith(_GridCell value, $Res Function(_GridCell) _then) = __$GridCellCopyWithImpl;
@override @useResult
$Res call({
 int col, String content, int row, BoundingBox? bbox,@JsonKey(name: 'col_span') int? colSpan,@JsonKey(name: 'is_header') bool? isHeader,@JsonKey(name: 'row_span') int? rowSpan
});


@override $BoundingBoxCopyWith<$Res>? get bbox;

}
/// @nodoc
class __$GridCellCopyWithImpl<$Res>
    implements _$GridCellCopyWith<$Res> {
  __$GridCellCopyWithImpl(this._self, this._then);

  final _GridCell _self;
  final $Res Function(_GridCell) _then;

/// Create a copy of GridCell
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? col = null,Object? content = null,Object? row = null,Object? bbox = freezed,Object? colSpan = freezed,Object? isHeader = freezed,Object? rowSpan = freezed,}) {
  return _then(_GridCell(
col: null == col ? _self.col : col // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,row: null == row ? _self.row : row // ignore: cast_nullable_to_non_nullable
as int,bbox: freezed == bbox ? _self.bbox : bbox // ignore: cast_nullable_to_non_nullable
as BoundingBox?,colSpan: freezed == colSpan ? _self.colSpan : colSpan // ignore: cast_nullable_to_non_nullable
as int?,isHeader: freezed == isHeader ? _self.isHeader : isHeader // ignore: cast_nullable_to_non_nullable
as bool?,rowSpan: freezed == rowSpan ? _self.rowSpan : rowSpan // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of GridCell
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoundingBoxCopyWith<$Res>? get bbox {
    if (_self.bbox == null) {
    return null;
  }

  return $BoundingBoxCopyWith<$Res>(_self.bbox!, (value) {
    return _then(_self.copyWith(bbox: value));
  });
}
}

// dart format on
