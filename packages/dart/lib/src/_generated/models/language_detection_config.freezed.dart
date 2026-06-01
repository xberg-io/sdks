// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'language_detection_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LanguageDetectionConfig {

/// Detect multiple languages in document
@JsonKey(name: 'detect_multiple') bool? get detectMultiple;/// Enable language detection
 bool? get enabled;/// Minimum confidence threshold (0.0-1.0)
@JsonKey(name: 'min_confidence') double? get minConfidence;
/// Create a copy of LanguageDetectionConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LanguageDetectionConfigCopyWith<LanguageDetectionConfig> get copyWith => _$LanguageDetectionConfigCopyWithImpl<LanguageDetectionConfig>(this as LanguageDetectionConfig, _$identity);

  /// Serializes this LanguageDetectionConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LanguageDetectionConfig&&(identical(other.detectMultiple, detectMultiple) || other.detectMultiple == detectMultiple)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.minConfidence, minConfidence) || other.minConfidence == minConfidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,detectMultiple,enabled,minConfidence);

@override
String toString() {
  return 'LanguageDetectionConfig(detectMultiple: $detectMultiple, enabled: $enabled, minConfidence: $minConfidence)';
}


}

/// @nodoc
abstract mixin class $LanguageDetectionConfigCopyWith<$Res>  {
  factory $LanguageDetectionConfigCopyWith(LanguageDetectionConfig value, $Res Function(LanguageDetectionConfig) _then) = _$LanguageDetectionConfigCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'detect_multiple') bool? detectMultiple, bool? enabled,@JsonKey(name: 'min_confidence') double? minConfidence
});




}
/// @nodoc
class _$LanguageDetectionConfigCopyWithImpl<$Res>
    implements $LanguageDetectionConfigCopyWith<$Res> {
  _$LanguageDetectionConfigCopyWithImpl(this._self, this._then);

  final LanguageDetectionConfig _self;
  final $Res Function(LanguageDetectionConfig) _then;

/// Create a copy of LanguageDetectionConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? detectMultiple = freezed,Object? enabled = freezed,Object? minConfidence = freezed,}) {
  return _then(_self.copyWith(
detectMultiple: freezed == detectMultiple ? _self.detectMultiple : detectMultiple // ignore: cast_nullable_to_non_nullable
as bool?,enabled: freezed == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool?,minConfidence: freezed == minConfidence ? _self.minConfidence : minConfidence // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [LanguageDetectionConfig].
extension LanguageDetectionConfigPatterns on LanguageDetectionConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LanguageDetectionConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LanguageDetectionConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LanguageDetectionConfig value)  $default,){
final _that = this;
switch (_that) {
case _LanguageDetectionConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LanguageDetectionConfig value)?  $default,){
final _that = this;
switch (_that) {
case _LanguageDetectionConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'detect_multiple')  bool? detectMultiple,  bool? enabled, @JsonKey(name: 'min_confidence')  double? minConfidence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LanguageDetectionConfig() when $default != null:
return $default(_that.detectMultiple,_that.enabled,_that.minConfidence);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'detect_multiple')  bool? detectMultiple,  bool? enabled, @JsonKey(name: 'min_confidence')  double? minConfidence)  $default,) {final _that = this;
switch (_that) {
case _LanguageDetectionConfig():
return $default(_that.detectMultiple,_that.enabled,_that.minConfidence);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'detect_multiple')  bool? detectMultiple,  bool? enabled, @JsonKey(name: 'min_confidence')  double? minConfidence)?  $default,) {final _that = this;
switch (_that) {
case _LanguageDetectionConfig() when $default != null:
return $default(_that.detectMultiple,_that.enabled,_that.minConfidence);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LanguageDetectionConfig implements LanguageDetectionConfig {
  const _LanguageDetectionConfig({@JsonKey(name: 'detect_multiple') this.detectMultiple, this.enabled, @JsonKey(name: 'min_confidence') this.minConfidence});
  factory _LanguageDetectionConfig.fromJson(Map<String, dynamic> json) => _$LanguageDetectionConfigFromJson(json);

/// Detect multiple languages in document
@override@JsonKey(name: 'detect_multiple') final  bool? detectMultiple;
/// Enable language detection
@override final  bool? enabled;
/// Minimum confidence threshold (0.0-1.0)
@override@JsonKey(name: 'min_confidence') final  double? minConfidence;

/// Create a copy of LanguageDetectionConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LanguageDetectionConfigCopyWith<_LanguageDetectionConfig> get copyWith => __$LanguageDetectionConfigCopyWithImpl<_LanguageDetectionConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LanguageDetectionConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LanguageDetectionConfig&&(identical(other.detectMultiple, detectMultiple) || other.detectMultiple == detectMultiple)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.minConfidence, minConfidence) || other.minConfidence == minConfidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,detectMultiple,enabled,minConfidence);

@override
String toString() {
  return 'LanguageDetectionConfig(detectMultiple: $detectMultiple, enabled: $enabled, minConfidence: $minConfidence)';
}


}

/// @nodoc
abstract mixin class _$LanguageDetectionConfigCopyWith<$Res> implements $LanguageDetectionConfigCopyWith<$Res> {
  factory _$LanguageDetectionConfigCopyWith(_LanguageDetectionConfig value, $Res Function(_LanguageDetectionConfig) _then) = __$LanguageDetectionConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'detect_multiple') bool? detectMultiple, bool? enabled,@JsonKey(name: 'min_confidence') double? minConfidence
});




}
/// @nodoc
class __$LanguageDetectionConfigCopyWithImpl<$Res>
    implements _$LanguageDetectionConfigCopyWith<$Res> {
  __$LanguageDetectionConfigCopyWithImpl(this._self, this._then);

  final _LanguageDetectionConfig _self;
  final $Res Function(_LanguageDetectionConfig) _then;

/// Create a copy of LanguageDetectionConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? detectMultiple = freezed,Object? enabled = freezed,Object? minConfidence = freezed,}) {
  return _then(_LanguageDetectionConfig(
detectMultiple: freezed == detectMultiple ? _self.detectMultiple : detectMultiple // ignore: cast_nullable_to_non_nullable
as bool?,enabled: freezed == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool?,minConfidence: freezed == minConfidence ? _self.minConfidence : minConfidence // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
