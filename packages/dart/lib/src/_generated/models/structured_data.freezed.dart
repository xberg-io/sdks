// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'structured_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StructuredData {

/// Type of structured data
@JsonKey(name: 'data_type') StructuredDataType get dataType;/// Raw JSON string representation
@JsonKey(name: 'raw_json') String get rawJson;/// Schema type if detectable (e.g., "Article", "Event", "Product")
@JsonKey(name: 'schema_type') String? get schemaType;
/// Create a copy of StructuredData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StructuredDataCopyWith<StructuredData> get copyWith => _$StructuredDataCopyWithImpl<StructuredData>(this as StructuredData, _$identity);

  /// Serializes this StructuredData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StructuredData&&(identical(other.dataType, dataType) || other.dataType == dataType)&&(identical(other.rawJson, rawJson) || other.rawJson == rawJson)&&(identical(other.schemaType, schemaType) || other.schemaType == schemaType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dataType,rawJson,schemaType);

@override
String toString() {
  return 'StructuredData(dataType: $dataType, rawJson: $rawJson, schemaType: $schemaType)';
}


}

/// @nodoc
abstract mixin class $StructuredDataCopyWith<$Res>  {
  factory $StructuredDataCopyWith(StructuredData value, $Res Function(StructuredData) _then) = _$StructuredDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'data_type') StructuredDataType dataType,@JsonKey(name: 'raw_json') String rawJson,@JsonKey(name: 'schema_type') String? schemaType
});




}
/// @nodoc
class _$StructuredDataCopyWithImpl<$Res>
    implements $StructuredDataCopyWith<$Res> {
  _$StructuredDataCopyWithImpl(this._self, this._then);

  final StructuredData _self;
  final $Res Function(StructuredData) _then;

/// Create a copy of StructuredData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dataType = null,Object? rawJson = null,Object? schemaType = freezed,}) {
  return _then(_self.copyWith(
dataType: null == dataType ? _self.dataType : dataType // ignore: cast_nullable_to_non_nullable
as StructuredDataType,rawJson: null == rawJson ? _self.rawJson : rawJson // ignore: cast_nullable_to_non_nullable
as String,schemaType: freezed == schemaType ? _self.schemaType : schemaType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StructuredData].
extension StructuredDataPatterns on StructuredData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StructuredData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StructuredData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StructuredData value)  $default,){
final _that = this;
switch (_that) {
case _StructuredData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StructuredData value)?  $default,){
final _that = this;
switch (_that) {
case _StructuredData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'data_type')  StructuredDataType dataType, @JsonKey(name: 'raw_json')  String rawJson, @JsonKey(name: 'schema_type')  String? schemaType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StructuredData() when $default != null:
return $default(_that.dataType,_that.rawJson,_that.schemaType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'data_type')  StructuredDataType dataType, @JsonKey(name: 'raw_json')  String rawJson, @JsonKey(name: 'schema_type')  String? schemaType)  $default,) {final _that = this;
switch (_that) {
case _StructuredData():
return $default(_that.dataType,_that.rawJson,_that.schemaType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'data_type')  StructuredDataType dataType, @JsonKey(name: 'raw_json')  String rawJson, @JsonKey(name: 'schema_type')  String? schemaType)?  $default,) {final _that = this;
switch (_that) {
case _StructuredData() when $default != null:
return $default(_that.dataType,_that.rawJson,_that.schemaType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StructuredData implements StructuredData {
  const _StructuredData({@JsonKey(name: 'data_type') required this.dataType, @JsonKey(name: 'raw_json') required this.rawJson, @JsonKey(name: 'schema_type') this.schemaType});
  factory _StructuredData.fromJson(Map<String, dynamic> json) => _$StructuredDataFromJson(json);

/// Type of structured data
@override@JsonKey(name: 'data_type') final  StructuredDataType dataType;
/// Raw JSON string representation
@override@JsonKey(name: 'raw_json') final  String rawJson;
/// Schema type if detectable (e.g., "Article", "Event", "Product")
@override@JsonKey(name: 'schema_type') final  String? schemaType;

/// Create a copy of StructuredData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StructuredDataCopyWith<_StructuredData> get copyWith => __$StructuredDataCopyWithImpl<_StructuredData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StructuredDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StructuredData&&(identical(other.dataType, dataType) || other.dataType == dataType)&&(identical(other.rawJson, rawJson) || other.rawJson == rawJson)&&(identical(other.schemaType, schemaType) || other.schemaType == schemaType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dataType,rawJson,schemaType);

@override
String toString() {
  return 'StructuredData(dataType: $dataType, rawJson: $rawJson, schemaType: $schemaType)';
}


}

/// @nodoc
abstract mixin class _$StructuredDataCopyWith<$Res> implements $StructuredDataCopyWith<$Res> {
  factory _$StructuredDataCopyWith(_StructuredData value, $Res Function(_StructuredData) _then) = __$StructuredDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'data_type') StructuredDataType dataType,@JsonKey(name: 'raw_json') String rawJson,@JsonKey(name: 'schema_type') String? schemaType
});




}
/// @nodoc
class __$StructuredDataCopyWithImpl<$Res>
    implements _$StructuredDataCopyWith<$Res> {
  __$StructuredDataCopyWithImpl(this._self, this._then);

  final _StructuredData _self;
  final $Res Function(_StructuredData) _then;

/// Create a copy of StructuredData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dataType = null,Object? rawJson = null,Object? schemaType = freezed,}) {
  return _then(_StructuredData(
dataType: null == dataType ? _self.dataType : dataType // ignore: cast_nullable_to_non_nullable
as StructuredDataType,rawJson: null == rawJson ? _self.rawJson : rawJson // ignore: cast_nullable_to_non_nullable
as String,schemaType: freezed == schemaType ? _self.schemaType : schemaType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
