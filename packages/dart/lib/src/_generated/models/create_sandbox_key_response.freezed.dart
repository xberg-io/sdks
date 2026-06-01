// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_sandbox_key_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateSandboxKeyResponse {

/// The sandbox API key (use in Authorization: Bearer header)
@JsonKey(name: 'api_key') String get apiKey;/// When the key expires (RFC3339 format)
@JsonKey(name: 'expires_at') DateTime get expiresAt;/// Page extraction quota for this key
@JsonKey(name: 'pages_remaining') int get pagesRemaining;
/// Create a copy of CreateSandboxKeyResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateSandboxKeyResponseCopyWith<CreateSandboxKeyResponse> get copyWith => _$CreateSandboxKeyResponseCopyWithImpl<CreateSandboxKeyResponse>(this as CreateSandboxKeyResponse, _$identity);

  /// Serializes this CreateSandboxKeyResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateSandboxKeyResponse&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.pagesRemaining, pagesRemaining) || other.pagesRemaining == pagesRemaining));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,apiKey,expiresAt,pagesRemaining);

@override
String toString() {
  return 'CreateSandboxKeyResponse(apiKey: $apiKey, expiresAt: $expiresAt, pagesRemaining: $pagesRemaining)';
}


}

/// @nodoc
abstract mixin class $CreateSandboxKeyResponseCopyWith<$Res>  {
  factory $CreateSandboxKeyResponseCopyWith(CreateSandboxKeyResponse value, $Res Function(CreateSandboxKeyResponse) _then) = _$CreateSandboxKeyResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'api_key') String apiKey,@JsonKey(name: 'expires_at') DateTime expiresAt,@JsonKey(name: 'pages_remaining') int pagesRemaining
});




}
/// @nodoc
class _$CreateSandboxKeyResponseCopyWithImpl<$Res>
    implements $CreateSandboxKeyResponseCopyWith<$Res> {
  _$CreateSandboxKeyResponseCopyWithImpl(this._self, this._then);

  final CreateSandboxKeyResponse _self;
  final $Res Function(CreateSandboxKeyResponse) _then;

/// Create a copy of CreateSandboxKeyResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? apiKey = null,Object? expiresAt = null,Object? pagesRemaining = null,}) {
  return _then(_self.copyWith(
apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,pagesRemaining: null == pagesRemaining ? _self.pagesRemaining : pagesRemaining // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateSandboxKeyResponse].
extension CreateSandboxKeyResponsePatterns on CreateSandboxKeyResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateSandboxKeyResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateSandboxKeyResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateSandboxKeyResponse value)  $default,){
final _that = this;
switch (_that) {
case _CreateSandboxKeyResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateSandboxKeyResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CreateSandboxKeyResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'api_key')  String apiKey, @JsonKey(name: 'expires_at')  DateTime expiresAt, @JsonKey(name: 'pages_remaining')  int pagesRemaining)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateSandboxKeyResponse() when $default != null:
return $default(_that.apiKey,_that.expiresAt,_that.pagesRemaining);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'api_key')  String apiKey, @JsonKey(name: 'expires_at')  DateTime expiresAt, @JsonKey(name: 'pages_remaining')  int pagesRemaining)  $default,) {final _that = this;
switch (_that) {
case _CreateSandboxKeyResponse():
return $default(_that.apiKey,_that.expiresAt,_that.pagesRemaining);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'api_key')  String apiKey, @JsonKey(name: 'expires_at')  DateTime expiresAt, @JsonKey(name: 'pages_remaining')  int pagesRemaining)?  $default,) {final _that = this;
switch (_that) {
case _CreateSandboxKeyResponse() when $default != null:
return $default(_that.apiKey,_that.expiresAt,_that.pagesRemaining);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateSandboxKeyResponse implements CreateSandboxKeyResponse {
  const _CreateSandboxKeyResponse({@JsonKey(name: 'api_key') required this.apiKey, @JsonKey(name: 'expires_at') required this.expiresAt, @JsonKey(name: 'pages_remaining') required this.pagesRemaining});
  factory _CreateSandboxKeyResponse.fromJson(Map<String, dynamic> json) => _$CreateSandboxKeyResponseFromJson(json);

/// The sandbox API key (use in Authorization: Bearer header)
@override@JsonKey(name: 'api_key') final  String apiKey;
/// When the key expires (RFC3339 format)
@override@JsonKey(name: 'expires_at') final  DateTime expiresAt;
/// Page extraction quota for this key
@override@JsonKey(name: 'pages_remaining') final  int pagesRemaining;

/// Create a copy of CreateSandboxKeyResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateSandboxKeyResponseCopyWith<_CreateSandboxKeyResponse> get copyWith => __$CreateSandboxKeyResponseCopyWithImpl<_CreateSandboxKeyResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateSandboxKeyResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateSandboxKeyResponse&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.pagesRemaining, pagesRemaining) || other.pagesRemaining == pagesRemaining));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,apiKey,expiresAt,pagesRemaining);

@override
String toString() {
  return 'CreateSandboxKeyResponse(apiKey: $apiKey, expiresAt: $expiresAt, pagesRemaining: $pagesRemaining)';
}


}

/// @nodoc
abstract mixin class _$CreateSandboxKeyResponseCopyWith<$Res> implements $CreateSandboxKeyResponseCopyWith<$Res> {
  factory _$CreateSandboxKeyResponseCopyWith(_CreateSandboxKeyResponse value, $Res Function(_CreateSandboxKeyResponse) _then) = __$CreateSandboxKeyResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'api_key') String apiKey,@JsonKey(name: 'expires_at') DateTime expiresAt,@JsonKey(name: 'pages_remaining') int pagesRemaining
});




}
/// @nodoc
class __$CreateSandboxKeyResponseCopyWithImpl<$Res>
    implements _$CreateSandboxKeyResponseCopyWith<$Res> {
  __$CreateSandboxKeyResponseCopyWithImpl(this._self, this._then);

  final _CreateSandboxKeyResponse _self;
  final $Res Function(_CreateSandboxKeyResponse) _then;

/// Create a copy of CreateSandboxKeyResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? apiKey = null,Object? expiresAt = null,Object? pagesRemaining = null,}) {
  return _then(_CreateSandboxKeyResponse(
apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,pagesRemaining: null == pagesRemaining ? _self.pagesRemaining : pagesRemaining // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
