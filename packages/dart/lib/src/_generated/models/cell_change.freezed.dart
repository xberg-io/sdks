// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cell_change.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CellChange {

/// Zero-based column index.
 int get col;/// Value before the change.
 String get from;/// Zero-based row index.
 int get row;/// Value after the change.
 String get to;
/// Create a copy of CellChange
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CellChangeCopyWith<CellChange> get copyWith => _$CellChangeCopyWithImpl<CellChange>(this as CellChange, _$identity);

  /// Serializes this CellChange to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CellChange&&(identical(other.col, col) || other.col == col)&&(identical(other.from, from) || other.from == from)&&(identical(other.row, row) || other.row == row)&&(identical(other.to, to) || other.to == to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,col,from,row,to);

@override
String toString() {
  return 'CellChange(col: $col, from: $from, row: $row, to: $to)';
}


}

/// @nodoc
abstract mixin class $CellChangeCopyWith<$Res>  {
  factory $CellChangeCopyWith(CellChange value, $Res Function(CellChange) _then) = _$CellChangeCopyWithImpl;
@useResult
$Res call({
 int col, String from, int row, String to
});




}
/// @nodoc
class _$CellChangeCopyWithImpl<$Res>
    implements $CellChangeCopyWith<$Res> {
  _$CellChangeCopyWithImpl(this._self, this._then);

  final CellChange _self;
  final $Res Function(CellChange) _then;

/// Create a copy of CellChange
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? col = null,Object? from = null,Object? row = null,Object? to = null,}) {
  return _then(_self.copyWith(
col: null == col ? _self.col : col // ignore: cast_nullable_to_non_nullable
as int,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,row: null == row ? _self.row : row // ignore: cast_nullable_to_non_nullable
as int,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CellChange].
extension CellChangePatterns on CellChange {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CellChange value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CellChange() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CellChange value)  $default,){
final _that = this;
switch (_that) {
case _CellChange():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CellChange value)?  $default,){
final _that = this;
switch (_that) {
case _CellChange() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int col,  String from,  int row,  String to)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CellChange() when $default != null:
return $default(_that.col,_that.from,_that.row,_that.to);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int col,  String from,  int row,  String to)  $default,) {final _that = this;
switch (_that) {
case _CellChange():
return $default(_that.col,_that.from,_that.row,_that.to);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int col,  String from,  int row,  String to)?  $default,) {final _that = this;
switch (_that) {
case _CellChange() when $default != null:
return $default(_that.col,_that.from,_that.row,_that.to);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CellChange implements CellChange {
  const _CellChange({required this.col, required this.from, required this.row, required this.to});
  factory _CellChange.fromJson(Map<String, dynamic> json) => _$CellChangeFromJson(json);

/// Zero-based column index.
@override final  int col;
/// Value before the change.
@override final  String from;
/// Zero-based row index.
@override final  int row;
/// Value after the change.
@override final  String to;

/// Create a copy of CellChange
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CellChangeCopyWith<_CellChange> get copyWith => __$CellChangeCopyWithImpl<_CellChange>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CellChangeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CellChange&&(identical(other.col, col) || other.col == col)&&(identical(other.from, from) || other.from == from)&&(identical(other.row, row) || other.row == row)&&(identical(other.to, to) || other.to == to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,col,from,row,to);

@override
String toString() {
  return 'CellChange(col: $col, from: $from, row: $row, to: $to)';
}


}

/// @nodoc
abstract mixin class _$CellChangeCopyWith<$Res> implements $CellChangeCopyWith<$Res> {
  factory _$CellChangeCopyWith(_CellChange value, $Res Function(_CellChange) _then) = __$CellChangeCopyWithImpl;
@override @useResult
$Res call({
 int col, String from, int row, String to
});




}
/// @nodoc
class __$CellChangeCopyWithImpl<$Res>
    implements _$CellChangeCopyWith<$Res> {
  __$CellChangeCopyWithImpl(this._self, this._then);

  final _CellChange _self;
  final $Res Function(_CellChange) _then;

/// Create a copy of CellChange
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? col = null,Object? from = null,Object? row = null,Object? to = null,}) {
  return _then(_CellChange(
col: null == col ? _self.col : col // ignore: cast_nullable_to_non_nullable
as int,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,row: null == row ? _self.row : row // ignore: cast_nullable_to_non_nullable
as int,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
