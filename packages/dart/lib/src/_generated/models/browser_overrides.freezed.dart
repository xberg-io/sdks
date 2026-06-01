// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'browser_overrides.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BrowserOverrides {

/// Browser backend: "native" (lightweight Rust-based) or "chromiumoxide" (Chrome-based)
 String? get backend;/// Browser mode: "auto" (default, use browser if needed), "always" (always use), or "never" (never use)
 String? get mode;/// Enable browser stealth mode (TLS fingerprint + UA spoof) — only honored by native backend
 bool? get stealth;
/// Create a copy of BrowserOverrides
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BrowserOverridesCopyWith<BrowserOverrides> get copyWith => _$BrowserOverridesCopyWithImpl<BrowserOverrides>(this as BrowserOverrides, _$identity);

  /// Serializes this BrowserOverrides to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BrowserOverrides&&(identical(other.backend, backend) || other.backend == backend)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.stealth, stealth) || other.stealth == stealth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,backend,mode,stealth);

@override
String toString() {
  return 'BrowserOverrides(backend: $backend, mode: $mode, stealth: $stealth)';
}


}

/// @nodoc
abstract mixin class $BrowserOverridesCopyWith<$Res>  {
  factory $BrowserOverridesCopyWith(BrowserOverrides value, $Res Function(BrowserOverrides) _then) = _$BrowserOverridesCopyWithImpl;
@useResult
$Res call({
 String? backend, String? mode, bool? stealth
});




}
/// @nodoc
class _$BrowserOverridesCopyWithImpl<$Res>
    implements $BrowserOverridesCopyWith<$Res> {
  _$BrowserOverridesCopyWithImpl(this._self, this._then);

  final BrowserOverrides _self;
  final $Res Function(BrowserOverrides) _then;

/// Create a copy of BrowserOverrides
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? backend = freezed,Object? mode = freezed,Object? stealth = freezed,}) {
  return _then(_self.copyWith(
backend: freezed == backend ? _self.backend : backend // ignore: cast_nullable_to_non_nullable
as String?,mode: freezed == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String?,stealth: freezed == stealth ? _self.stealth : stealth // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [BrowserOverrides].
extension BrowserOverridesPatterns on BrowserOverrides {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BrowserOverrides value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BrowserOverrides() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BrowserOverrides value)  $default,){
final _that = this;
switch (_that) {
case _BrowserOverrides():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BrowserOverrides value)?  $default,){
final _that = this;
switch (_that) {
case _BrowserOverrides() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? backend,  String? mode,  bool? stealth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BrowserOverrides() when $default != null:
return $default(_that.backend,_that.mode,_that.stealth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? backend,  String? mode,  bool? stealth)  $default,) {final _that = this;
switch (_that) {
case _BrowserOverrides():
return $default(_that.backend,_that.mode,_that.stealth);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? backend,  String? mode,  bool? stealth)?  $default,) {final _that = this;
switch (_that) {
case _BrowserOverrides() when $default != null:
return $default(_that.backend,_that.mode,_that.stealth);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BrowserOverrides implements BrowserOverrides {
  const _BrowserOverrides({this.backend, this.mode, this.stealth});
  factory _BrowserOverrides.fromJson(Map<String, dynamic> json) => _$BrowserOverridesFromJson(json);

/// Browser backend: "native" (lightweight Rust-based) or "chromiumoxide" (Chrome-based)
@override final  String? backend;
/// Browser mode: "auto" (default, use browser if needed), "always" (always use), or "never" (never use)
@override final  String? mode;
/// Enable browser stealth mode (TLS fingerprint + UA spoof) — only honored by native backend
@override final  bool? stealth;

/// Create a copy of BrowserOverrides
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BrowserOverridesCopyWith<_BrowserOverrides> get copyWith => __$BrowserOverridesCopyWithImpl<_BrowserOverrides>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BrowserOverridesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BrowserOverrides&&(identical(other.backend, backend) || other.backend == backend)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.stealth, stealth) || other.stealth == stealth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,backend,mode,stealth);

@override
String toString() {
  return 'BrowserOverrides(backend: $backend, mode: $mode, stealth: $stealth)';
}


}

/// @nodoc
abstract mixin class _$BrowserOverridesCopyWith<$Res> implements $BrowserOverridesCopyWith<$Res> {
  factory _$BrowserOverridesCopyWith(_BrowserOverrides value, $Res Function(_BrowserOverrides) _then) = __$BrowserOverridesCopyWithImpl;
@override @useResult
$Res call({
 String? backend, String? mode, bool? stealth
});




}
/// @nodoc
class __$BrowserOverridesCopyWithImpl<$Res>
    implements _$BrowserOverridesCopyWith<$Res> {
  __$BrowserOverridesCopyWithImpl(this._self, this._then);

  final _BrowserOverrides _self;
  final $Res Function(_BrowserOverrides) _then;

/// Create a copy of BrowserOverrides
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? backend = freezed,Object? mode = freezed,Object? stealth = freezed,}) {
  return _then(_BrowserOverrides(
backend: freezed == backend ? _self.backend : backend // ignore: cast_nullable_to_non_nullable
as String?,mode: freezed == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String?,stealth: freezed == stealth ? _self.stealth : stealth // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
