// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'excel_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExcelMetadata {

/// Number of sheets in the workbook.
@JsonKey(name: 'sheet_count') int? get sheetCount;/// Names of all sheets in the workbook.
@JsonKey(name: 'sheet_names') List<String>? get sheetNames;
/// Create a copy of ExcelMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExcelMetadataCopyWith<ExcelMetadata> get copyWith => _$ExcelMetadataCopyWithImpl<ExcelMetadata>(this as ExcelMetadata, _$identity);

  /// Serializes this ExcelMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExcelMetadata&&(identical(other.sheetCount, sheetCount) || other.sheetCount == sheetCount)&&const DeepCollectionEquality().equals(other.sheetNames, sheetNames));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sheetCount,const DeepCollectionEquality().hash(sheetNames));

@override
String toString() {
  return 'ExcelMetadata(sheetCount: $sheetCount, sheetNames: $sheetNames)';
}


}

/// @nodoc
abstract mixin class $ExcelMetadataCopyWith<$Res>  {
  factory $ExcelMetadataCopyWith(ExcelMetadata value, $Res Function(ExcelMetadata) _then) = _$ExcelMetadataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'sheet_count') int? sheetCount,@JsonKey(name: 'sheet_names') List<String>? sheetNames
});




}
/// @nodoc
class _$ExcelMetadataCopyWithImpl<$Res>
    implements $ExcelMetadataCopyWith<$Res> {
  _$ExcelMetadataCopyWithImpl(this._self, this._then);

  final ExcelMetadata _self;
  final $Res Function(ExcelMetadata) _then;

/// Create a copy of ExcelMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sheetCount = freezed,Object? sheetNames = freezed,}) {
  return _then(_self.copyWith(
sheetCount: freezed == sheetCount ? _self.sheetCount : sheetCount // ignore: cast_nullable_to_non_nullable
as int?,sheetNames: freezed == sheetNames ? _self.sheetNames : sheetNames // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExcelMetadata].
extension ExcelMetadataPatterns on ExcelMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExcelMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExcelMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExcelMetadata value)  $default,){
final _that = this;
switch (_that) {
case _ExcelMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExcelMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _ExcelMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'sheet_count')  int? sheetCount, @JsonKey(name: 'sheet_names')  List<String>? sheetNames)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExcelMetadata() when $default != null:
return $default(_that.sheetCount,_that.sheetNames);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'sheet_count')  int? sheetCount, @JsonKey(name: 'sheet_names')  List<String>? sheetNames)  $default,) {final _that = this;
switch (_that) {
case _ExcelMetadata():
return $default(_that.sheetCount,_that.sheetNames);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'sheet_count')  int? sheetCount, @JsonKey(name: 'sheet_names')  List<String>? sheetNames)?  $default,) {final _that = this;
switch (_that) {
case _ExcelMetadata() when $default != null:
return $default(_that.sheetCount,_that.sheetNames);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExcelMetadata implements ExcelMetadata {
  const _ExcelMetadata({@JsonKey(name: 'sheet_count') this.sheetCount, @JsonKey(name: 'sheet_names') final  List<String>? sheetNames}): _sheetNames = sheetNames;
  factory _ExcelMetadata.fromJson(Map<String, dynamic> json) => _$ExcelMetadataFromJson(json);

/// Number of sheets in the workbook.
@override@JsonKey(name: 'sheet_count') final  int? sheetCount;
/// Names of all sheets in the workbook.
 final  List<String>? _sheetNames;
/// Names of all sheets in the workbook.
@override@JsonKey(name: 'sheet_names') List<String>? get sheetNames {
  final value = _sheetNames;
  if (value == null) return null;
  if (_sheetNames is EqualUnmodifiableListView) return _sheetNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ExcelMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExcelMetadataCopyWith<_ExcelMetadata> get copyWith => __$ExcelMetadataCopyWithImpl<_ExcelMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExcelMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExcelMetadata&&(identical(other.sheetCount, sheetCount) || other.sheetCount == sheetCount)&&const DeepCollectionEquality().equals(other._sheetNames, _sheetNames));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sheetCount,const DeepCollectionEquality().hash(_sheetNames));

@override
String toString() {
  return 'ExcelMetadata(sheetCount: $sheetCount, sheetNames: $sheetNames)';
}


}

/// @nodoc
abstract mixin class _$ExcelMetadataCopyWith<$Res> implements $ExcelMetadataCopyWith<$Res> {
  factory _$ExcelMetadataCopyWith(_ExcelMetadata value, $Res Function(_ExcelMetadata) _then) = __$ExcelMetadataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'sheet_count') int? sheetCount,@JsonKey(name: 'sheet_names') List<String>? sheetNames
});




}
/// @nodoc
class __$ExcelMetadataCopyWithImpl<$Res>
    implements _$ExcelMetadataCopyWith<$Res> {
  __$ExcelMetadataCopyWithImpl(this._self, this._then);

  final _ExcelMetadata _self;
  final $Res Function(_ExcelMetadata) _then;

/// Create a copy of ExcelMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sheetCount = freezed,Object? sheetNames = freezed,}) {
  return _then(_ExcelMetadata(
sheetCount: freezed == sheetCount ? _self.sheetCount : sheetCount // ignore: cast_nullable_to_non_nullable
as int?,sheetNames: freezed == sheetNames ? _self._sheetNames : sheetNames // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
