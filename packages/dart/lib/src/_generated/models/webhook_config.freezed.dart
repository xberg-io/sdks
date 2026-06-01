// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'webhook_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WebhookConfig {

/// URL to deliver results to
 String get url;/// Optional key-value metadata to include in the webhook payload
 Map<String, String>? get metadata;/// Optional HMAC secret for signing the webhook payload
 String? get secret;
/// Create a copy of WebhookConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WebhookConfigCopyWith<WebhookConfig> get copyWith => _$WebhookConfigCopyWithImpl<WebhookConfig>(this as WebhookConfig, _$identity);

  /// Serializes this WebhookConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WebhookConfig&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.secret, secret) || other.secret == secret));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,const DeepCollectionEquality().hash(metadata),secret);

@override
String toString() {
  return 'WebhookConfig(url: $url, metadata: $metadata, secret: $secret)';
}


}

/// @nodoc
abstract mixin class $WebhookConfigCopyWith<$Res>  {
  factory $WebhookConfigCopyWith(WebhookConfig value, $Res Function(WebhookConfig) _then) = _$WebhookConfigCopyWithImpl;
@useResult
$Res call({
 String url, Map<String, String>? metadata, String? secret
});




}
/// @nodoc
class _$WebhookConfigCopyWithImpl<$Res>
    implements $WebhookConfigCopyWith<$Res> {
  _$WebhookConfigCopyWithImpl(this._self, this._then);

  final WebhookConfig _self;
  final $Res Function(WebhookConfig) _then;

/// Create a copy of WebhookConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? metadata = freezed,Object? secret = freezed,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,secret: freezed == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WebhookConfig].
extension WebhookConfigPatterns on WebhookConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WebhookConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WebhookConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WebhookConfig value)  $default,){
final _that = this;
switch (_that) {
case _WebhookConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WebhookConfig value)?  $default,){
final _that = this;
switch (_that) {
case _WebhookConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  Map<String, String>? metadata,  String? secret)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WebhookConfig() when $default != null:
return $default(_that.url,_that.metadata,_that.secret);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  Map<String, String>? metadata,  String? secret)  $default,) {final _that = this;
switch (_that) {
case _WebhookConfig():
return $default(_that.url,_that.metadata,_that.secret);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  Map<String, String>? metadata,  String? secret)?  $default,) {final _that = this;
switch (_that) {
case _WebhookConfig() when $default != null:
return $default(_that.url,_that.metadata,_that.secret);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WebhookConfig implements WebhookConfig {
  const _WebhookConfig({required this.url, final  Map<String, String>? metadata, this.secret}): _metadata = metadata;
  factory _WebhookConfig.fromJson(Map<String, dynamic> json) => _$WebhookConfigFromJson(json);

/// URL to deliver results to
@override final  String url;
/// Optional key-value metadata to include in the webhook payload
 final  Map<String, String>? _metadata;
/// Optional key-value metadata to include in the webhook payload
@override Map<String, String>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Optional HMAC secret for signing the webhook payload
@override final  String? secret;

/// Create a copy of WebhookConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WebhookConfigCopyWith<_WebhookConfig> get copyWith => __$WebhookConfigCopyWithImpl<_WebhookConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WebhookConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WebhookConfig&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.secret, secret) || other.secret == secret));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,const DeepCollectionEquality().hash(_metadata),secret);

@override
String toString() {
  return 'WebhookConfig(url: $url, metadata: $metadata, secret: $secret)';
}


}

/// @nodoc
abstract mixin class _$WebhookConfigCopyWith<$Res> implements $WebhookConfigCopyWith<$Res> {
  factory _$WebhookConfigCopyWith(_WebhookConfig value, $Res Function(_WebhookConfig) _then) = __$WebhookConfigCopyWithImpl;
@override @useResult
$Res call({
 String url, Map<String, String>? metadata, String? secret
});




}
/// @nodoc
class __$WebhookConfigCopyWithImpl<$Res>
    implements _$WebhookConfigCopyWith<$Res> {
  __$WebhookConfigCopyWithImpl(this._self, this._then);

  final _WebhookConfig _self;
  final $Res Function(_WebhookConfig) _then;

/// Create a copy of WebhookConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? metadata = freezed,Object? secret = freezed,}) {
  return _then(_WebhookConfig(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,secret: freezed == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
