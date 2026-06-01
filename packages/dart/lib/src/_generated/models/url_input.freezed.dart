// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'url_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UrlInput {

/// URL to crawl and extract documents from
 String get url;/// Per-URL crawl config override (merged with top-level crawl_config)
@JsonKey(name: 'crawl_config') CrawlConfig? get crawlConfig;
/// Create a copy of UrlInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UrlInputCopyWith<UrlInput> get copyWith => _$UrlInputCopyWithImpl<UrlInput>(this as UrlInput, _$identity);

  /// Serializes this UrlInput to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UrlInput&&(identical(other.url, url) || other.url == url)&&(identical(other.crawlConfig, crawlConfig) || other.crawlConfig == crawlConfig));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,crawlConfig);

@override
String toString() {
  return 'UrlInput(url: $url, crawlConfig: $crawlConfig)';
}


}

/// @nodoc
abstract mixin class $UrlInputCopyWith<$Res>  {
  factory $UrlInputCopyWith(UrlInput value, $Res Function(UrlInput) _then) = _$UrlInputCopyWithImpl;
@useResult
$Res call({
 String url,@JsonKey(name: 'crawl_config') CrawlConfig? crawlConfig
});


$CrawlConfigCopyWith<$Res>? get crawlConfig;

}
/// @nodoc
class _$UrlInputCopyWithImpl<$Res>
    implements $UrlInputCopyWith<$Res> {
  _$UrlInputCopyWithImpl(this._self, this._then);

  final UrlInput _self;
  final $Res Function(UrlInput) _then;

/// Create a copy of UrlInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? crawlConfig = freezed,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,crawlConfig: freezed == crawlConfig ? _self.crawlConfig : crawlConfig // ignore: cast_nullable_to_non_nullable
as CrawlConfig?,
  ));
}
/// Create a copy of UrlInput
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CrawlConfigCopyWith<$Res>? get crawlConfig {
    if (_self.crawlConfig == null) {
    return null;
  }

  return $CrawlConfigCopyWith<$Res>(_self.crawlConfig!, (value) {
    return _then(_self.copyWith(crawlConfig: value));
  });
}
}


/// Adds pattern-matching-related methods to [UrlInput].
extension UrlInputPatterns on UrlInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UrlInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UrlInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UrlInput value)  $default,){
final _that = this;
switch (_that) {
case _UrlInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UrlInput value)?  $default,){
final _that = this;
switch (_that) {
case _UrlInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url, @JsonKey(name: 'crawl_config')  CrawlConfig? crawlConfig)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UrlInput() when $default != null:
return $default(_that.url,_that.crawlConfig);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url, @JsonKey(name: 'crawl_config')  CrawlConfig? crawlConfig)  $default,) {final _that = this;
switch (_that) {
case _UrlInput():
return $default(_that.url,_that.crawlConfig);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url, @JsonKey(name: 'crawl_config')  CrawlConfig? crawlConfig)?  $default,) {final _that = this;
switch (_that) {
case _UrlInput() when $default != null:
return $default(_that.url,_that.crawlConfig);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UrlInput implements UrlInput {
  const _UrlInput({required this.url, @JsonKey(name: 'crawl_config') this.crawlConfig});
  factory _UrlInput.fromJson(Map<String, dynamic> json) => _$UrlInputFromJson(json);

/// URL to crawl and extract documents from
@override final  String url;
/// Per-URL crawl config override (merged with top-level crawl_config)
@override@JsonKey(name: 'crawl_config') final  CrawlConfig? crawlConfig;

/// Create a copy of UrlInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UrlInputCopyWith<_UrlInput> get copyWith => __$UrlInputCopyWithImpl<_UrlInput>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UrlInputToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UrlInput&&(identical(other.url, url) || other.url == url)&&(identical(other.crawlConfig, crawlConfig) || other.crawlConfig == crawlConfig));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,crawlConfig);

@override
String toString() {
  return 'UrlInput(url: $url, crawlConfig: $crawlConfig)';
}


}

/// @nodoc
abstract mixin class _$UrlInputCopyWith<$Res> implements $UrlInputCopyWith<$Res> {
  factory _$UrlInputCopyWith(_UrlInput value, $Res Function(_UrlInput) _then) = __$UrlInputCopyWithImpl;
@override @useResult
$Res call({
 String url,@JsonKey(name: 'crawl_config') CrawlConfig? crawlConfig
});


@override $CrawlConfigCopyWith<$Res>? get crawlConfig;

}
/// @nodoc
class __$UrlInputCopyWithImpl<$Res>
    implements _$UrlInputCopyWith<$Res> {
  __$UrlInputCopyWithImpl(this._self, this._then);

  final _UrlInput _self;
  final $Res Function(_UrlInput) _then;

/// Create a copy of UrlInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? crawlConfig = freezed,}) {
  return _then(_UrlInput(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,crawlConfig: freezed == crawlConfig ? _self.crawlConfig : crawlConfig // ignore: cast_nullable_to_non_nullable
as CrawlConfig?,
  ));
}

/// Create a copy of UrlInput
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CrawlConfigCopyWith<$Res>? get crawlConfig {
    if (_self.crawlConfig == null) {
    return null;
  }

  return $CrawlConfigCopyWith<$Res>(_self.crawlConfig!, (value) {
    return _then(_self.copyWith(crawlConfig: value));
  });
}
}

// dart format on
