// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'csv_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CsvMetadata {

@JsonKey(name: 'column_count') int get columnCount;@JsonKey(name: 'has_header') bool get hasHeader;@JsonKey(name: 'row_count') int get rowCount;@JsonKey(name: 'column_types') List<String>? get columnTypes; String? get delimiter;
/// Create a copy of CsvMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CsvMetadataCopyWith<CsvMetadata> get copyWith => _$CsvMetadataCopyWithImpl<CsvMetadata>(this as CsvMetadata, _$identity);

  /// Serializes this CsvMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CsvMetadata&&(identical(other.columnCount, columnCount) || other.columnCount == columnCount)&&(identical(other.hasHeader, hasHeader) || other.hasHeader == hasHeader)&&(identical(other.rowCount, rowCount) || other.rowCount == rowCount)&&const DeepCollectionEquality().equals(other.columnTypes, columnTypes)&&(identical(other.delimiter, delimiter) || other.delimiter == delimiter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,columnCount,hasHeader,rowCount,const DeepCollectionEquality().hash(columnTypes),delimiter);

@override
String toString() {
  return 'CsvMetadata(columnCount: $columnCount, hasHeader: $hasHeader, rowCount: $rowCount, columnTypes: $columnTypes, delimiter: $delimiter)';
}


}

/// @nodoc
abstract mixin class $CsvMetadataCopyWith<$Res>  {
  factory $CsvMetadataCopyWith(CsvMetadata value, $Res Function(CsvMetadata) _then) = _$CsvMetadataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'column_count') int columnCount,@JsonKey(name: 'has_header') bool hasHeader,@JsonKey(name: 'row_count') int rowCount,@JsonKey(name: 'column_types') List<String>? columnTypes, String? delimiter
});




}
/// @nodoc
class _$CsvMetadataCopyWithImpl<$Res>
    implements $CsvMetadataCopyWith<$Res> {
  _$CsvMetadataCopyWithImpl(this._self, this._then);

  final CsvMetadata _self;
  final $Res Function(CsvMetadata) _then;

/// Create a copy of CsvMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? columnCount = null,Object? hasHeader = null,Object? rowCount = null,Object? columnTypes = freezed,Object? delimiter = freezed,}) {
  return _then(_self.copyWith(
columnCount: null == columnCount ? _self.columnCount : columnCount // ignore: cast_nullable_to_non_nullable
as int,hasHeader: null == hasHeader ? _self.hasHeader : hasHeader // ignore: cast_nullable_to_non_nullable
as bool,rowCount: null == rowCount ? _self.rowCount : rowCount // ignore: cast_nullable_to_non_nullable
as int,columnTypes: freezed == columnTypes ? _self.columnTypes : columnTypes // ignore: cast_nullable_to_non_nullable
as List<String>?,delimiter: freezed == delimiter ? _self.delimiter : delimiter // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CsvMetadata].
extension CsvMetadataPatterns on CsvMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CsvMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CsvMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CsvMetadata value)  $default,){
final _that = this;
switch (_that) {
case _CsvMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CsvMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _CsvMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'column_count')  int columnCount, @JsonKey(name: 'has_header')  bool hasHeader, @JsonKey(name: 'row_count')  int rowCount, @JsonKey(name: 'column_types')  List<String>? columnTypes,  String? delimiter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CsvMetadata() when $default != null:
return $default(_that.columnCount,_that.hasHeader,_that.rowCount,_that.columnTypes,_that.delimiter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'column_count')  int columnCount, @JsonKey(name: 'has_header')  bool hasHeader, @JsonKey(name: 'row_count')  int rowCount, @JsonKey(name: 'column_types')  List<String>? columnTypes,  String? delimiter)  $default,) {final _that = this;
switch (_that) {
case _CsvMetadata():
return $default(_that.columnCount,_that.hasHeader,_that.rowCount,_that.columnTypes,_that.delimiter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'column_count')  int columnCount, @JsonKey(name: 'has_header')  bool hasHeader, @JsonKey(name: 'row_count')  int rowCount, @JsonKey(name: 'column_types')  List<String>? columnTypes,  String? delimiter)?  $default,) {final _that = this;
switch (_that) {
case _CsvMetadata() when $default != null:
return $default(_that.columnCount,_that.hasHeader,_that.rowCount,_that.columnTypes,_that.delimiter);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CsvMetadata implements CsvMetadata {
  const _CsvMetadata({@JsonKey(name: 'column_count') required this.columnCount, @JsonKey(name: 'has_header') required this.hasHeader, @JsonKey(name: 'row_count') required this.rowCount, @JsonKey(name: 'column_types') final  List<String>? columnTypes, this.delimiter}): _columnTypes = columnTypes;
  factory _CsvMetadata.fromJson(Map<String, dynamic> json) => _$CsvMetadataFromJson(json);

@override@JsonKey(name: 'column_count') final  int columnCount;
@override@JsonKey(name: 'has_header') final  bool hasHeader;
@override@JsonKey(name: 'row_count') final  int rowCount;
 final  List<String>? _columnTypes;
@override@JsonKey(name: 'column_types') List<String>? get columnTypes {
  final value = _columnTypes;
  if (value == null) return null;
  if (_columnTypes is EqualUnmodifiableListView) return _columnTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? delimiter;

/// Create a copy of CsvMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CsvMetadataCopyWith<_CsvMetadata> get copyWith => __$CsvMetadataCopyWithImpl<_CsvMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CsvMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CsvMetadata&&(identical(other.columnCount, columnCount) || other.columnCount == columnCount)&&(identical(other.hasHeader, hasHeader) || other.hasHeader == hasHeader)&&(identical(other.rowCount, rowCount) || other.rowCount == rowCount)&&const DeepCollectionEquality().equals(other._columnTypes, _columnTypes)&&(identical(other.delimiter, delimiter) || other.delimiter == delimiter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,columnCount,hasHeader,rowCount,const DeepCollectionEquality().hash(_columnTypes),delimiter);

@override
String toString() {
  return 'CsvMetadata(columnCount: $columnCount, hasHeader: $hasHeader, rowCount: $rowCount, columnTypes: $columnTypes, delimiter: $delimiter)';
}


}

/// @nodoc
abstract mixin class _$CsvMetadataCopyWith<$Res> implements $CsvMetadataCopyWith<$Res> {
  factory _$CsvMetadataCopyWith(_CsvMetadata value, $Res Function(_CsvMetadata) _then) = __$CsvMetadataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'column_count') int columnCount,@JsonKey(name: 'has_header') bool hasHeader,@JsonKey(name: 'row_count') int rowCount,@JsonKey(name: 'column_types') List<String>? columnTypes, String? delimiter
});




}
/// @nodoc
class __$CsvMetadataCopyWithImpl<$Res>
    implements _$CsvMetadataCopyWith<$Res> {
  __$CsvMetadataCopyWithImpl(this._self, this._then);

  final _CsvMetadata _self;
  final $Res Function(_CsvMetadata) _then;

/// Create a copy of CsvMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? columnCount = null,Object? hasHeader = null,Object? rowCount = null,Object? columnTypes = freezed,Object? delimiter = freezed,}) {
  return _then(_CsvMetadata(
columnCount: null == columnCount ? _self.columnCount : columnCount // ignore: cast_nullable_to_non_nullable
as int,hasHeader: null == hasHeader ? _self.hasHeader : hasHeader // ignore: cast_nullable_to_non_nullable
as bool,rowCount: null == rowCount ? _self.rowCount : rowCount // ignore: cast_nullable_to_non_nullable
as int,columnTypes: freezed == columnTypes ? _self._columnTypes : columnTypes // ignore: cast_nullable_to_non_nullable
as List<String>?,delimiter: freezed == delimiter ? _self.delimiter : delimiter // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
