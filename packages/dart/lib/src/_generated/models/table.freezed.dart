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

/// Table cells as a 2D vector (rows × columns)
 List<List<String>> get cells;/// Markdown representation of the table
 String get markdown;/// Page number where the table was found (1-indexed)
@JsonKey(name: 'page_number') int get pageNumber;/// Bounding box of the table on the page (PDF coordinates: x0=left, y0=bottom, x1=right, y1=top).
/// Only populated for PDF-extracted tables when position data is available.
@JsonKey(name: 'bounding_box') BoundingBox? get boundingBox;
/// Create a copy of Table
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TableCopyWith<Table> get copyWith => _$TableCopyWithImpl<Table>(this as Table, _$identity);

  /// Serializes this Table to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Table&&const DeepCollectionEquality().equals(other.cells, cells)&&(identical(other.markdown, markdown) || other.markdown == markdown)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.boundingBox, boundingBox) || other.boundingBox == boundingBox));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(cells),markdown,pageNumber,boundingBox);

@override
String toString() {
  return 'Table(cells: $cells, markdown: $markdown, pageNumber: $pageNumber, boundingBox: $boundingBox)';
}


}

/// @nodoc
abstract mixin class $TableCopyWith<$Res>  {
  factory $TableCopyWith(Table value, $Res Function(Table) _then) = _$TableCopyWithImpl;
@useResult
$Res call({
 List<List<String>> cells, String markdown,@JsonKey(name: 'page_number') int pageNumber,@JsonKey(name: 'bounding_box') BoundingBox? boundingBox
});


$BoundingBoxCopyWith<$Res>? get boundingBox;

}
/// @nodoc
class _$TableCopyWithImpl<$Res>
    implements $TableCopyWith<$Res> {
  _$TableCopyWithImpl(this._self, this._then);

  final Table _self;
  final $Res Function(Table) _then;

/// Create a copy of Table
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cells = null,Object? markdown = null,Object? pageNumber = null,Object? boundingBox = freezed,}) {
  return _then(_self.copyWith(
cells: null == cells ? _self.cells : cells // ignore: cast_nullable_to_non_nullable
as List<List<String>>,markdown: null == markdown ? _self.markdown : markdown // ignore: cast_nullable_to_non_nullable
as String,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,boundingBox: freezed == boundingBox ? _self.boundingBox : boundingBox // ignore: cast_nullable_to_non_nullable
as BoundingBox?,
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Table value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Table() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Table value)  $default,){
final _that = this;
switch (_that) {
case _Table():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Table value)?  $default,){
final _that = this;
switch (_that) {
case _Table() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<List<String>> cells,  String markdown, @JsonKey(name: 'page_number')  int pageNumber, @JsonKey(name: 'bounding_box')  BoundingBox? boundingBox)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Table() when $default != null:
return $default(_that.cells,_that.markdown,_that.pageNumber,_that.boundingBox);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<List<String>> cells,  String markdown, @JsonKey(name: 'page_number')  int pageNumber, @JsonKey(name: 'bounding_box')  BoundingBox? boundingBox)  $default,) {final _that = this;
switch (_that) {
case _Table():
return $default(_that.cells,_that.markdown,_that.pageNumber,_that.boundingBox);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<List<String>> cells,  String markdown, @JsonKey(name: 'page_number')  int pageNumber, @JsonKey(name: 'bounding_box')  BoundingBox? boundingBox)?  $default,) {final _that = this;
switch (_that) {
case _Table() when $default != null:
return $default(_that.cells,_that.markdown,_that.pageNumber,_that.boundingBox);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Table implements Table {
  const _Table({required final  List<List<String>> cells, required this.markdown, @JsonKey(name: 'page_number') required this.pageNumber, @JsonKey(name: 'bounding_box') this.boundingBox}): _cells = cells;
  factory _Table.fromJson(Map<String, dynamic> json) => _$TableFromJson(json);

/// Table cells as a 2D vector (rows × columns)
 final  List<List<String>> _cells;
/// Table cells as a 2D vector (rows × columns)
@override List<List<String>> get cells {
  if (_cells is EqualUnmodifiableListView) return _cells;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cells);
}

/// Markdown representation of the table
@override final  String markdown;
/// Page number where the table was found (1-indexed)
@override@JsonKey(name: 'page_number') final  int pageNumber;
/// Bounding box of the table on the page (PDF coordinates: x0=left, y0=bottom, x1=right, y1=top).
/// Only populated for PDF-extracted tables when position data is available.
@override@JsonKey(name: 'bounding_box') final  BoundingBox? boundingBox;

/// Create a copy of Table
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TableCopyWith<_Table> get copyWith => __$TableCopyWithImpl<_Table>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TableToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Table&&const DeepCollectionEquality().equals(other._cells, _cells)&&(identical(other.markdown, markdown) || other.markdown == markdown)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.boundingBox, boundingBox) || other.boundingBox == boundingBox));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cells),markdown,pageNumber,boundingBox);

@override
String toString() {
  return 'Table(cells: $cells, markdown: $markdown, pageNumber: $pageNumber, boundingBox: $boundingBox)';
}


}

/// @nodoc
abstract mixin class _$TableCopyWith<$Res> implements $TableCopyWith<$Res> {
  factory _$TableCopyWith(_Table value, $Res Function(_Table) _then) = __$TableCopyWithImpl;
@override @useResult
$Res call({
 List<List<String>> cells, String markdown,@JsonKey(name: 'page_number') int pageNumber,@JsonKey(name: 'bounding_box') BoundingBox? boundingBox
});


@override $BoundingBoxCopyWith<$Res>? get boundingBox;

}
/// @nodoc
class __$TableCopyWithImpl<$Res>
    implements _$TableCopyWith<$Res> {
  __$TableCopyWithImpl(this._self, this._then);

  final _Table _self;
  final $Res Function(_Table) _then;

/// Create a copy of Table
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cells = null,Object? markdown = null,Object? pageNumber = null,Object? boundingBox = freezed,}) {
  return _then(_Table(
cells: null == cells ? _self._cells : cells // ignore: cast_nullable_to_non_nullable
as List<List<String>>,markdown: null == markdown ? _self.markdown : markdown // ignore: cast_nullable_to_non_nullable
as String,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,boundingBox: freezed == boundingBox ? _self.boundingBox : boundingBox // ignore: cast_nullable_to_non_nullable
as BoundingBox?,
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
