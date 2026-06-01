// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bypass_request_override.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BypassRequestOverride {

/// Whether cloud provides vendor credentials (managed) or caller does (byo).
 BypassMode get mode;/// Vendor identifier — must be registered in bypass-providers/registry.
/// Today: "bright_data" | "zyte" | "scrapingbee".
 String get vendor;/// Per-vendor credentials JSON. Required when mode = byo; ignored for.
/// managed (cloud uses its own credentials from Secret Manager).
 dynamic get credentials;
/// Create a copy of BypassRequestOverride
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BypassRequestOverrideCopyWith<BypassRequestOverride> get copyWith => _$BypassRequestOverrideCopyWithImpl<BypassRequestOverride>(this as BypassRequestOverride, _$identity);

  /// Serializes this BypassRequestOverride to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BypassRequestOverride&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.vendor, vendor) || other.vendor == vendor)&&const DeepCollectionEquality().equals(other.credentials, credentials));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mode,vendor,const DeepCollectionEquality().hash(credentials));

@override
String toString() {
  return 'BypassRequestOverride(mode: $mode, vendor: $vendor, credentials: $credentials)';
}


}

/// @nodoc
abstract mixin class $BypassRequestOverrideCopyWith<$Res>  {
  factory $BypassRequestOverrideCopyWith(BypassRequestOverride value, $Res Function(BypassRequestOverride) _then) = _$BypassRequestOverrideCopyWithImpl;
@useResult
$Res call({
 BypassMode mode, String vendor, dynamic credentials
});




}
/// @nodoc
class _$BypassRequestOverrideCopyWithImpl<$Res>
    implements $BypassRequestOverrideCopyWith<$Res> {
  _$BypassRequestOverrideCopyWithImpl(this._self, this._then);

  final BypassRequestOverride _self;
  final $Res Function(BypassRequestOverride) _then;

/// Create a copy of BypassRequestOverride
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? vendor = null,Object? credentials = freezed,}) {
  return _then(_self.copyWith(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as BypassMode,vendor: null == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as String,credentials: freezed == credentials ? _self.credentials : credentials // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [BypassRequestOverride].
extension BypassRequestOverridePatterns on BypassRequestOverride {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BypassRequestOverride value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BypassRequestOverride() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BypassRequestOverride value)  $default,){
final _that = this;
switch (_that) {
case _BypassRequestOverride():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BypassRequestOverride value)?  $default,){
final _that = this;
switch (_that) {
case _BypassRequestOverride() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BypassMode mode,  String vendor,  dynamic credentials)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BypassRequestOverride() when $default != null:
return $default(_that.mode,_that.vendor,_that.credentials);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BypassMode mode,  String vendor,  dynamic credentials)  $default,) {final _that = this;
switch (_that) {
case _BypassRequestOverride():
return $default(_that.mode,_that.vendor,_that.credentials);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BypassMode mode,  String vendor,  dynamic credentials)?  $default,) {final _that = this;
switch (_that) {
case _BypassRequestOverride() when $default != null:
return $default(_that.mode,_that.vendor,_that.credentials);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BypassRequestOverride implements BypassRequestOverride {
  const _BypassRequestOverride({required this.mode, required this.vendor, this.credentials});
  factory _BypassRequestOverride.fromJson(Map<String, dynamic> json) => _$BypassRequestOverrideFromJson(json);

/// Whether cloud provides vendor credentials (managed) or caller does (byo).
@override final  BypassMode mode;
/// Vendor identifier — must be registered in bypass-providers/registry.
/// Today: "bright_data" | "zyte" | "scrapingbee".
@override final  String vendor;
/// Per-vendor credentials JSON. Required when mode = byo; ignored for.
/// managed (cloud uses its own credentials from Secret Manager).
@override final  dynamic credentials;

/// Create a copy of BypassRequestOverride
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BypassRequestOverrideCopyWith<_BypassRequestOverride> get copyWith => __$BypassRequestOverrideCopyWithImpl<_BypassRequestOverride>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BypassRequestOverrideToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BypassRequestOverride&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.vendor, vendor) || other.vendor == vendor)&&const DeepCollectionEquality().equals(other.credentials, credentials));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mode,vendor,const DeepCollectionEquality().hash(credentials));

@override
String toString() {
  return 'BypassRequestOverride(mode: $mode, vendor: $vendor, credentials: $credentials)';
}


}

/// @nodoc
abstract mixin class _$BypassRequestOverrideCopyWith<$Res> implements $BypassRequestOverrideCopyWith<$Res> {
  factory _$BypassRequestOverrideCopyWith(_BypassRequestOverride value, $Res Function(_BypassRequestOverride) _then) = __$BypassRequestOverrideCopyWithImpl;
@override @useResult
$Res call({
 BypassMode mode, String vendor, dynamic credentials
});




}
/// @nodoc
class __$BypassRequestOverrideCopyWithImpl<$Res>
    implements _$BypassRequestOverrideCopyWith<$Res> {
  __$BypassRequestOverrideCopyWithImpl(this._self, this._then);

  final _BypassRequestOverride _self;
  final $Res Function(_BypassRequestOverride) _then;

/// Create a copy of BypassRequestOverride
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? vendor = null,Object? credentials = freezed,}) {
  return _then(_BypassRequestOverride(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as BypassMode,vendor: null == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as String,credentials: freezed == credentials ? _self.credentials : credentials // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
