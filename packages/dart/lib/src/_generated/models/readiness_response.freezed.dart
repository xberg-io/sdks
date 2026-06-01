// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'readiness_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReadinessResponse {

/// Dependency check results
 ReadinessChecks get checks;/// Overall readiness status
 String get status;
/// Create a copy of ReadinessResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadinessResponseCopyWith<ReadinessResponse> get copyWith => _$ReadinessResponseCopyWithImpl<ReadinessResponse>(this as ReadinessResponse, _$identity);

  /// Serializes this ReadinessResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadinessResponse&&(identical(other.checks, checks) || other.checks == checks)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,checks,status);

@override
String toString() {
  return 'ReadinessResponse(checks: $checks, status: $status)';
}


}

/// @nodoc
abstract mixin class $ReadinessResponseCopyWith<$Res>  {
  factory $ReadinessResponseCopyWith(ReadinessResponse value, $Res Function(ReadinessResponse) _then) = _$ReadinessResponseCopyWithImpl;
@useResult
$Res call({
 ReadinessChecks checks, String status
});


$ReadinessChecksCopyWith<$Res> get checks;

}
/// @nodoc
class _$ReadinessResponseCopyWithImpl<$Res>
    implements $ReadinessResponseCopyWith<$Res> {
  _$ReadinessResponseCopyWithImpl(this._self, this._then);

  final ReadinessResponse _self;
  final $Res Function(ReadinessResponse) _then;

/// Create a copy of ReadinessResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? checks = null,Object? status = null,}) {
  return _then(_self.copyWith(
checks: null == checks ? _self.checks : checks // ignore: cast_nullable_to_non_nullable
as ReadinessChecks,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of ReadinessResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReadinessChecksCopyWith<$Res> get checks {
  
  return $ReadinessChecksCopyWith<$Res>(_self.checks, (value) {
    return _then(_self.copyWith(checks: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReadinessResponse].
extension ReadinessResponsePatterns on ReadinessResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadinessResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadinessResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadinessResponse value)  $default,){
final _that = this;
switch (_that) {
case _ReadinessResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadinessResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ReadinessResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReadinessChecks checks,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadinessResponse() when $default != null:
return $default(_that.checks,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReadinessChecks checks,  String status)  $default,) {final _that = this;
switch (_that) {
case _ReadinessResponse():
return $default(_that.checks,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReadinessChecks checks,  String status)?  $default,) {final _that = this;
switch (_that) {
case _ReadinessResponse() when $default != null:
return $default(_that.checks,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadinessResponse implements ReadinessResponse {
  const _ReadinessResponse({required this.checks, required this.status});
  factory _ReadinessResponse.fromJson(Map<String, dynamic> json) => _$ReadinessResponseFromJson(json);

/// Dependency check results
@override final  ReadinessChecks checks;
/// Overall readiness status
@override final  String status;

/// Create a copy of ReadinessResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadinessResponseCopyWith<_ReadinessResponse> get copyWith => __$ReadinessResponseCopyWithImpl<_ReadinessResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadinessResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadinessResponse&&(identical(other.checks, checks) || other.checks == checks)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,checks,status);

@override
String toString() {
  return 'ReadinessResponse(checks: $checks, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ReadinessResponseCopyWith<$Res> implements $ReadinessResponseCopyWith<$Res> {
  factory _$ReadinessResponseCopyWith(_ReadinessResponse value, $Res Function(_ReadinessResponse) _then) = __$ReadinessResponseCopyWithImpl;
@override @useResult
$Res call({
 ReadinessChecks checks, String status
});


@override $ReadinessChecksCopyWith<$Res> get checks;

}
/// @nodoc
class __$ReadinessResponseCopyWithImpl<$Res>
    implements _$ReadinessResponseCopyWith<$Res> {
  __$ReadinessResponseCopyWithImpl(this._self, this._then);

  final _ReadinessResponse _self;
  final $Res Function(_ReadinessResponse) _then;

/// Create a copy of ReadinessResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? checks = null,Object? status = null,}) {
  return _then(_ReadinessResponse(
checks: null == checks ? _self.checks : checks // ignore: cast_nullable_to_non_nullable
as ReadinessChecks,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of ReadinessResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReadinessChecksCopyWith<$Res> get checks {
  
  return $ReadinessChecksCopyWith<$Res>(_self.checks, (value) {
    return _then(_self.copyWith(checks: value));
  });
}
}

// dart format on
