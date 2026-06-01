// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ErrorMetadata {

@JsonKey(name: 'error_type') String get errorType; String get message;
/// Create a copy of ErrorMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorMetadataCopyWith<ErrorMetadata> get copyWith => _$ErrorMetadataCopyWithImpl<ErrorMetadata>(this as ErrorMetadata, _$identity);

  /// Serializes this ErrorMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorMetadata&&(identical(other.errorType, errorType) || other.errorType == errorType)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,errorType,message);

@override
String toString() {
  return 'ErrorMetadata(errorType: $errorType, message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorMetadataCopyWith<$Res>  {
  factory $ErrorMetadataCopyWith(ErrorMetadata value, $Res Function(ErrorMetadata) _then) = _$ErrorMetadataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'error_type') String errorType, String message
});




}
/// @nodoc
class _$ErrorMetadataCopyWithImpl<$Res>
    implements $ErrorMetadataCopyWith<$Res> {
  _$ErrorMetadataCopyWithImpl(this._self, this._then);

  final ErrorMetadata _self;
  final $Res Function(ErrorMetadata) _then;

/// Create a copy of ErrorMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? errorType = null,Object? message = null,}) {
  return _then(_self.copyWith(
errorType: null == errorType ? _self.errorType : errorType // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ErrorMetadata].
extension ErrorMetadataPatterns on ErrorMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ErrorMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ErrorMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ErrorMetadata value)  $default,){
final _that = this;
switch (_that) {
case _ErrorMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ErrorMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _ErrorMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'error_type')  String errorType,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ErrorMetadata() when $default != null:
return $default(_that.errorType,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'error_type')  String errorType,  String message)  $default,) {final _that = this;
switch (_that) {
case _ErrorMetadata():
return $default(_that.errorType,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'error_type')  String errorType,  String message)?  $default,) {final _that = this;
switch (_that) {
case _ErrorMetadata() when $default != null:
return $default(_that.errorType,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ErrorMetadata implements ErrorMetadata {
  const _ErrorMetadata({@JsonKey(name: 'error_type') required this.errorType, required this.message});
  factory _ErrorMetadata.fromJson(Map<String, dynamic> json) => _$ErrorMetadataFromJson(json);

@override@JsonKey(name: 'error_type') final  String errorType;
@override final  String message;

/// Create a copy of ErrorMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorMetadataCopyWith<_ErrorMetadata> get copyWith => __$ErrorMetadataCopyWithImpl<_ErrorMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ErrorMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ErrorMetadata&&(identical(other.errorType, errorType) || other.errorType == errorType)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,errorType,message);

@override
String toString() {
  return 'ErrorMetadata(errorType: $errorType, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorMetadataCopyWith<$Res> implements $ErrorMetadataCopyWith<$Res> {
  factory _$ErrorMetadataCopyWith(_ErrorMetadata value, $Res Function(_ErrorMetadata) _then) = __$ErrorMetadataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'error_type') String errorType, String message
});




}
/// @nodoc
class __$ErrorMetadataCopyWithImpl<$Res>
    implements _$ErrorMetadataCopyWith<$Res> {
  __$ErrorMetadataCopyWithImpl(this._self, this._then);

  final _ErrorMetadata _self;
  final $Res Function(_ErrorMetadata) _then;

/// Create a copy of ErrorMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? errorType = null,Object? message = null,}) {
  return _then(_ErrorMetadata(
errorType: null == errorType ? _self.errorType : errorType // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
