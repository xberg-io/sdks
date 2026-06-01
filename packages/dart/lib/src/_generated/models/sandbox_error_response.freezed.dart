// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sandbox_error_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SandboxErrorResponse {

/// Error code
 String get error;/// Human-readable error message
 String get message;
/// Create a copy of SandboxErrorResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SandboxErrorResponseCopyWith<SandboxErrorResponse> get copyWith => _$SandboxErrorResponseCopyWithImpl<SandboxErrorResponse>(this as SandboxErrorResponse, _$identity);

  /// Serializes this SandboxErrorResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SandboxErrorResponse&&(identical(other.error, error) || other.error == error)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,error,message);

@override
String toString() {
  return 'SandboxErrorResponse(error: $error, message: $message)';
}


}

/// @nodoc
abstract mixin class $SandboxErrorResponseCopyWith<$Res>  {
  factory $SandboxErrorResponseCopyWith(SandboxErrorResponse value, $Res Function(SandboxErrorResponse) _then) = _$SandboxErrorResponseCopyWithImpl;
@useResult
$Res call({
 String error, String message
});




}
/// @nodoc
class _$SandboxErrorResponseCopyWithImpl<$Res>
    implements $SandboxErrorResponseCopyWith<$Res> {
  _$SandboxErrorResponseCopyWithImpl(this._self, this._then);

  final SandboxErrorResponse _self;
  final $Res Function(SandboxErrorResponse) _then;

/// Create a copy of SandboxErrorResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? error = null,Object? message = null,}) {
  return _then(_self.copyWith(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SandboxErrorResponse].
extension SandboxErrorResponsePatterns on SandboxErrorResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SandboxErrorResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SandboxErrorResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SandboxErrorResponse value)  $default,){
final _that = this;
switch (_that) {
case _SandboxErrorResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SandboxErrorResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SandboxErrorResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String error,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SandboxErrorResponse() when $default != null:
return $default(_that.error,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String error,  String message)  $default,) {final _that = this;
switch (_that) {
case _SandboxErrorResponse():
return $default(_that.error,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String error,  String message)?  $default,) {final _that = this;
switch (_that) {
case _SandboxErrorResponse() when $default != null:
return $default(_that.error,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SandboxErrorResponse implements SandboxErrorResponse {
  const _SandboxErrorResponse({required this.error, required this.message});
  factory _SandboxErrorResponse.fromJson(Map<String, dynamic> json) => _$SandboxErrorResponseFromJson(json);

/// Error code
@override final  String error;
/// Human-readable error message
@override final  String message;

/// Create a copy of SandboxErrorResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SandboxErrorResponseCopyWith<_SandboxErrorResponse> get copyWith => __$SandboxErrorResponseCopyWithImpl<_SandboxErrorResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SandboxErrorResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SandboxErrorResponse&&(identical(other.error, error) || other.error == error)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,error,message);

@override
String toString() {
  return 'SandboxErrorResponse(error: $error, message: $message)';
}


}

/// @nodoc
abstract mixin class _$SandboxErrorResponseCopyWith<$Res> implements $SandboxErrorResponseCopyWith<$Res> {
  factory _$SandboxErrorResponseCopyWith(_SandboxErrorResponse value, $Res Function(_SandboxErrorResponse) _then) = __$SandboxErrorResponseCopyWithImpl;
@override @useResult
$Res call({
 String error, String message
});




}
/// @nodoc
class __$SandboxErrorResponseCopyWithImpl<$Res>
    implements _$SandboxErrorResponseCopyWith<$Res> {
  __$SandboxErrorResponseCopyWithImpl(this._self, this._then);

  final _SandboxErrorResponse _self;
  final $Res Function(_SandboxErrorResponse) _then;

/// Create a copy of SandboxErrorResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? error = null,Object? message = null,}) {
  return _then(_SandboxErrorResponse(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
