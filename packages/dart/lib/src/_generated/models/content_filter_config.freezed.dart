// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_filter_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentFilterConfig {

/// Include running footers
@JsonKey(name: 'include_footers') bool? get includeFooters;/// Include running headers
@JsonKey(name: 'include_headers') bool? get includeHeaders;/// Include watermarks
@JsonKey(name: 'include_watermarks') bool? get includeWatermarks;/// Strip cross-page repeating text
@JsonKey(name: 'strip_repeating_text') bool? get stripRepeatingText;
/// Create a copy of ContentFilterConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentFilterConfigCopyWith<ContentFilterConfig> get copyWith => _$ContentFilterConfigCopyWithImpl<ContentFilterConfig>(this as ContentFilterConfig, _$identity);

  /// Serializes this ContentFilterConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentFilterConfig&&(identical(other.includeFooters, includeFooters) || other.includeFooters == includeFooters)&&(identical(other.includeHeaders, includeHeaders) || other.includeHeaders == includeHeaders)&&(identical(other.includeWatermarks, includeWatermarks) || other.includeWatermarks == includeWatermarks)&&(identical(other.stripRepeatingText, stripRepeatingText) || other.stripRepeatingText == stripRepeatingText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,includeFooters,includeHeaders,includeWatermarks,stripRepeatingText);

@override
String toString() {
  return 'ContentFilterConfig(includeFooters: $includeFooters, includeHeaders: $includeHeaders, includeWatermarks: $includeWatermarks, stripRepeatingText: $stripRepeatingText)';
}


}

/// @nodoc
abstract mixin class $ContentFilterConfigCopyWith<$Res>  {
  factory $ContentFilterConfigCopyWith(ContentFilterConfig value, $Res Function(ContentFilterConfig) _then) = _$ContentFilterConfigCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'include_footers') bool? includeFooters,@JsonKey(name: 'include_headers') bool? includeHeaders,@JsonKey(name: 'include_watermarks') bool? includeWatermarks,@JsonKey(name: 'strip_repeating_text') bool? stripRepeatingText
});




}
/// @nodoc
class _$ContentFilterConfigCopyWithImpl<$Res>
    implements $ContentFilterConfigCopyWith<$Res> {
  _$ContentFilterConfigCopyWithImpl(this._self, this._then);

  final ContentFilterConfig _self;
  final $Res Function(ContentFilterConfig) _then;

/// Create a copy of ContentFilterConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? includeFooters = freezed,Object? includeHeaders = freezed,Object? includeWatermarks = freezed,Object? stripRepeatingText = freezed,}) {
  return _then(_self.copyWith(
includeFooters: freezed == includeFooters ? _self.includeFooters : includeFooters // ignore: cast_nullable_to_non_nullable
as bool?,includeHeaders: freezed == includeHeaders ? _self.includeHeaders : includeHeaders // ignore: cast_nullable_to_non_nullable
as bool?,includeWatermarks: freezed == includeWatermarks ? _self.includeWatermarks : includeWatermarks // ignore: cast_nullable_to_non_nullable
as bool?,stripRepeatingText: freezed == stripRepeatingText ? _self.stripRepeatingText : stripRepeatingText // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentFilterConfig].
extension ContentFilterConfigPatterns on ContentFilterConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentFilterConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentFilterConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentFilterConfig value)  $default,){
final _that = this;
switch (_that) {
case _ContentFilterConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentFilterConfig value)?  $default,){
final _that = this;
switch (_that) {
case _ContentFilterConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'include_footers')  bool? includeFooters, @JsonKey(name: 'include_headers')  bool? includeHeaders, @JsonKey(name: 'include_watermarks')  bool? includeWatermarks, @JsonKey(name: 'strip_repeating_text')  bool? stripRepeatingText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentFilterConfig() when $default != null:
return $default(_that.includeFooters,_that.includeHeaders,_that.includeWatermarks,_that.stripRepeatingText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'include_footers')  bool? includeFooters, @JsonKey(name: 'include_headers')  bool? includeHeaders, @JsonKey(name: 'include_watermarks')  bool? includeWatermarks, @JsonKey(name: 'strip_repeating_text')  bool? stripRepeatingText)  $default,) {final _that = this;
switch (_that) {
case _ContentFilterConfig():
return $default(_that.includeFooters,_that.includeHeaders,_that.includeWatermarks,_that.stripRepeatingText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'include_footers')  bool? includeFooters, @JsonKey(name: 'include_headers')  bool? includeHeaders, @JsonKey(name: 'include_watermarks')  bool? includeWatermarks, @JsonKey(name: 'strip_repeating_text')  bool? stripRepeatingText)?  $default,) {final _that = this;
switch (_that) {
case _ContentFilterConfig() when $default != null:
return $default(_that.includeFooters,_that.includeHeaders,_that.includeWatermarks,_that.stripRepeatingText);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentFilterConfig implements ContentFilterConfig {
  const _ContentFilterConfig({@JsonKey(name: 'include_footers') this.includeFooters, @JsonKey(name: 'include_headers') this.includeHeaders, @JsonKey(name: 'include_watermarks') this.includeWatermarks, @JsonKey(name: 'strip_repeating_text') this.stripRepeatingText});
  factory _ContentFilterConfig.fromJson(Map<String, dynamic> json) => _$ContentFilterConfigFromJson(json);

/// Include running footers
@override@JsonKey(name: 'include_footers') final  bool? includeFooters;
/// Include running headers
@override@JsonKey(name: 'include_headers') final  bool? includeHeaders;
/// Include watermarks
@override@JsonKey(name: 'include_watermarks') final  bool? includeWatermarks;
/// Strip cross-page repeating text
@override@JsonKey(name: 'strip_repeating_text') final  bool? stripRepeatingText;

/// Create a copy of ContentFilterConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentFilterConfigCopyWith<_ContentFilterConfig> get copyWith => __$ContentFilterConfigCopyWithImpl<_ContentFilterConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentFilterConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentFilterConfig&&(identical(other.includeFooters, includeFooters) || other.includeFooters == includeFooters)&&(identical(other.includeHeaders, includeHeaders) || other.includeHeaders == includeHeaders)&&(identical(other.includeWatermarks, includeWatermarks) || other.includeWatermarks == includeWatermarks)&&(identical(other.stripRepeatingText, stripRepeatingText) || other.stripRepeatingText == stripRepeatingText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,includeFooters,includeHeaders,includeWatermarks,stripRepeatingText);

@override
String toString() {
  return 'ContentFilterConfig(includeFooters: $includeFooters, includeHeaders: $includeHeaders, includeWatermarks: $includeWatermarks, stripRepeatingText: $stripRepeatingText)';
}


}

/// @nodoc
abstract mixin class _$ContentFilterConfigCopyWith<$Res> implements $ContentFilterConfigCopyWith<$Res> {
  factory _$ContentFilterConfigCopyWith(_ContentFilterConfig value, $Res Function(_ContentFilterConfig) _then) = __$ContentFilterConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'include_footers') bool? includeFooters,@JsonKey(name: 'include_headers') bool? includeHeaders,@JsonKey(name: 'include_watermarks') bool? includeWatermarks,@JsonKey(name: 'strip_repeating_text') bool? stripRepeatingText
});




}
/// @nodoc
class __$ContentFilterConfigCopyWithImpl<$Res>
    implements _$ContentFilterConfigCopyWith<$Res> {
  __$ContentFilterConfigCopyWithImpl(this._self, this._then);

  final _ContentFilterConfig _self;
  final $Res Function(_ContentFilterConfig) _then;

/// Create a copy of ContentFilterConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? includeFooters = freezed,Object? includeHeaders = freezed,Object? includeWatermarks = freezed,Object? stripRepeatingText = freezed,}) {
  return _then(_ContentFilterConfig(
includeFooters: freezed == includeFooters ? _self.includeFooters : includeFooters // ignore: cast_nullable_to_non_nullable
as bool?,includeHeaders: freezed == includeHeaders ? _self.includeHeaders : includeHeaders // ignore: cast_nullable_to_non_nullable
as bool?,includeWatermarks: freezed == includeWatermarks ? _self.includeWatermarks : includeWatermarks // ignore: cast_nullable_to_non_nullable
as bool?,stripRepeatingText: freezed == stripRepeatingText ? _self.stripRepeatingText : stripRepeatingText // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
