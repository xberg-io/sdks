// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'proxy_override.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProxyOverride {

/// Full proxy URL — `http://`, `https://`, `socks5://` or `socks5h://`.
 String get url;/// Optional password for proxy auth.
 String? get password;/// Optional username for proxy auth.
 String? get username;
/// Create a copy of ProxyOverride
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProxyOverrideCopyWith<ProxyOverride> get copyWith => _$ProxyOverrideCopyWithImpl<ProxyOverride>(this as ProxyOverride, _$identity);

  /// Serializes this ProxyOverride to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProxyOverride&&(identical(other.url, url) || other.url == url)&&(identical(other.password, password) || other.password == password)&&(identical(other.username, username) || other.username == username));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,password,username);

@override
String toString() {
  return 'ProxyOverride(url: $url, password: $password, username: $username)';
}


}

/// @nodoc
abstract mixin class $ProxyOverrideCopyWith<$Res>  {
  factory $ProxyOverrideCopyWith(ProxyOverride value, $Res Function(ProxyOverride) _then) = _$ProxyOverrideCopyWithImpl;
@useResult
$Res call({
 String url, String? password, String? username
});




}
/// @nodoc
class _$ProxyOverrideCopyWithImpl<$Res>
    implements $ProxyOverrideCopyWith<$Res> {
  _$ProxyOverrideCopyWithImpl(this._self, this._then);

  final ProxyOverride _self;
  final $Res Function(ProxyOverride) _then;

/// Create a copy of ProxyOverride
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? password = freezed,Object? username = freezed,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProxyOverride].
extension ProxyOverridePatterns on ProxyOverride {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProxyOverride value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProxyOverride() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProxyOverride value)  $default,){
final _that = this;
switch (_that) {
case _ProxyOverride():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProxyOverride value)?  $default,){
final _that = this;
switch (_that) {
case _ProxyOverride() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  String? password,  String? username)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProxyOverride() when $default != null:
return $default(_that.url,_that.password,_that.username);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  String? password,  String? username)  $default,) {final _that = this;
switch (_that) {
case _ProxyOverride():
return $default(_that.url,_that.password,_that.username);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  String? password,  String? username)?  $default,) {final _that = this;
switch (_that) {
case _ProxyOverride() when $default != null:
return $default(_that.url,_that.password,_that.username);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProxyOverride implements ProxyOverride {
  const _ProxyOverride({required this.url, this.password, this.username});
  factory _ProxyOverride.fromJson(Map<String, dynamic> json) => _$ProxyOverrideFromJson(json);

/// Full proxy URL — `http://`, `https://`, `socks5://` or `socks5h://`.
@override final  String url;
/// Optional password for proxy auth.
@override final  String? password;
/// Optional username for proxy auth.
@override final  String? username;

/// Create a copy of ProxyOverride
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProxyOverrideCopyWith<_ProxyOverride> get copyWith => __$ProxyOverrideCopyWithImpl<_ProxyOverride>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProxyOverrideToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProxyOverride&&(identical(other.url, url) || other.url == url)&&(identical(other.password, password) || other.password == password)&&(identical(other.username, username) || other.username == username));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,password,username);

@override
String toString() {
  return 'ProxyOverride(url: $url, password: $password, username: $username)';
}


}

/// @nodoc
abstract mixin class _$ProxyOverrideCopyWith<$Res> implements $ProxyOverrideCopyWith<$Res> {
  factory _$ProxyOverrideCopyWith(_ProxyOverride value, $Res Function(_ProxyOverride) _then) = __$ProxyOverrideCopyWithImpl;
@override @useResult
$Res call({
 String url, String? password, String? username
});




}
/// @nodoc
class __$ProxyOverrideCopyWithImpl<$Res>
    implements _$ProxyOverrideCopyWith<$Res> {
  __$ProxyOverrideCopyWithImpl(this._self, this._then);

  final _ProxyOverride _self;
  final $Res Function(_ProxyOverride) _then;

/// Create a copy of ProxyOverride
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? password = freezed,Object? username = freezed,}) {
  return _then(_ProxyOverride(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
