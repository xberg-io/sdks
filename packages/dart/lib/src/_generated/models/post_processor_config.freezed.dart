// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_processor_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostProcessorConfig {

/// Blacklist of processors to disable (None = none)
@JsonKey(name: 'disabled_processors') List<String>? get disabledProcessors;/// Enable post-processors
 bool? get enabled;/// Whitelist of processors to enable (None = all)
@JsonKey(name: 'enabled_processors') List<String>? get enabledProcessors;
/// Create a copy of PostProcessorConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostProcessorConfigCopyWith<PostProcessorConfig> get copyWith => _$PostProcessorConfigCopyWithImpl<PostProcessorConfig>(this as PostProcessorConfig, _$identity);

  /// Serializes this PostProcessorConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostProcessorConfig&&const DeepCollectionEquality().equals(other.disabledProcessors, disabledProcessors)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&const DeepCollectionEquality().equals(other.enabledProcessors, enabledProcessors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(disabledProcessors),enabled,const DeepCollectionEquality().hash(enabledProcessors));

@override
String toString() {
  return 'PostProcessorConfig(disabledProcessors: $disabledProcessors, enabled: $enabled, enabledProcessors: $enabledProcessors)';
}


}

/// @nodoc
abstract mixin class $PostProcessorConfigCopyWith<$Res>  {
  factory $PostProcessorConfigCopyWith(PostProcessorConfig value, $Res Function(PostProcessorConfig) _then) = _$PostProcessorConfigCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'disabled_processors') List<String>? disabledProcessors, bool? enabled,@JsonKey(name: 'enabled_processors') List<String>? enabledProcessors
});




}
/// @nodoc
class _$PostProcessorConfigCopyWithImpl<$Res>
    implements $PostProcessorConfigCopyWith<$Res> {
  _$PostProcessorConfigCopyWithImpl(this._self, this._then);

  final PostProcessorConfig _self;
  final $Res Function(PostProcessorConfig) _then;

/// Create a copy of PostProcessorConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? disabledProcessors = freezed,Object? enabled = freezed,Object? enabledProcessors = freezed,}) {
  return _then(_self.copyWith(
disabledProcessors: freezed == disabledProcessors ? _self.disabledProcessors : disabledProcessors // ignore: cast_nullable_to_non_nullable
as List<String>?,enabled: freezed == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool?,enabledProcessors: freezed == enabledProcessors ? _self.enabledProcessors : enabledProcessors // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [PostProcessorConfig].
extension PostProcessorConfigPatterns on PostProcessorConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostProcessorConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostProcessorConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostProcessorConfig value)  $default,){
final _that = this;
switch (_that) {
case _PostProcessorConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostProcessorConfig value)?  $default,){
final _that = this;
switch (_that) {
case _PostProcessorConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'disabled_processors')  List<String>? disabledProcessors,  bool? enabled, @JsonKey(name: 'enabled_processors')  List<String>? enabledProcessors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostProcessorConfig() when $default != null:
return $default(_that.disabledProcessors,_that.enabled,_that.enabledProcessors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'disabled_processors')  List<String>? disabledProcessors,  bool? enabled, @JsonKey(name: 'enabled_processors')  List<String>? enabledProcessors)  $default,) {final _that = this;
switch (_that) {
case _PostProcessorConfig():
return $default(_that.disabledProcessors,_that.enabled,_that.enabledProcessors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'disabled_processors')  List<String>? disabledProcessors,  bool? enabled, @JsonKey(name: 'enabled_processors')  List<String>? enabledProcessors)?  $default,) {final _that = this;
switch (_that) {
case _PostProcessorConfig() when $default != null:
return $default(_that.disabledProcessors,_that.enabled,_that.enabledProcessors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostProcessorConfig implements PostProcessorConfig {
  const _PostProcessorConfig({@JsonKey(name: 'disabled_processors') final  List<String>? disabledProcessors, this.enabled, @JsonKey(name: 'enabled_processors') final  List<String>? enabledProcessors}): _disabledProcessors = disabledProcessors,_enabledProcessors = enabledProcessors;
  factory _PostProcessorConfig.fromJson(Map<String, dynamic> json) => _$PostProcessorConfigFromJson(json);

/// Blacklist of processors to disable (None = none)
 final  List<String>? _disabledProcessors;
/// Blacklist of processors to disable (None = none)
@override@JsonKey(name: 'disabled_processors') List<String>? get disabledProcessors {
  final value = _disabledProcessors;
  if (value == null) return null;
  if (_disabledProcessors is EqualUnmodifiableListView) return _disabledProcessors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Enable post-processors
@override final  bool? enabled;
/// Whitelist of processors to enable (None = all)
 final  List<String>? _enabledProcessors;
/// Whitelist of processors to enable (None = all)
@override@JsonKey(name: 'enabled_processors') List<String>? get enabledProcessors {
  final value = _enabledProcessors;
  if (value == null) return null;
  if (_enabledProcessors is EqualUnmodifiableListView) return _enabledProcessors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of PostProcessorConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostProcessorConfigCopyWith<_PostProcessorConfig> get copyWith => __$PostProcessorConfigCopyWithImpl<_PostProcessorConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostProcessorConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostProcessorConfig&&const DeepCollectionEquality().equals(other._disabledProcessors, _disabledProcessors)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&const DeepCollectionEquality().equals(other._enabledProcessors, _enabledProcessors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_disabledProcessors),enabled,const DeepCollectionEquality().hash(_enabledProcessors));

@override
String toString() {
  return 'PostProcessorConfig(disabledProcessors: $disabledProcessors, enabled: $enabled, enabledProcessors: $enabledProcessors)';
}


}

/// @nodoc
abstract mixin class _$PostProcessorConfigCopyWith<$Res> implements $PostProcessorConfigCopyWith<$Res> {
  factory _$PostProcessorConfigCopyWith(_PostProcessorConfig value, $Res Function(_PostProcessorConfig) _then) = __$PostProcessorConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'disabled_processors') List<String>? disabledProcessors, bool? enabled,@JsonKey(name: 'enabled_processors') List<String>? enabledProcessors
});




}
/// @nodoc
class __$PostProcessorConfigCopyWithImpl<$Res>
    implements _$PostProcessorConfigCopyWith<$Res> {
  __$PostProcessorConfigCopyWithImpl(this._self, this._then);

  final _PostProcessorConfig _self;
  final $Res Function(_PostProcessorConfig) _then;

/// Create a copy of PostProcessorConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? disabledProcessors = freezed,Object? enabled = freezed,Object? enabledProcessors = freezed,}) {
  return _then(_PostProcessorConfig(
disabledProcessors: freezed == disabledProcessors ? _self._disabledProcessors : disabledProcessors // ignore: cast_nullable_to_non_nullable
as List<String>?,enabled: freezed == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool?,enabledProcessors: freezed == enabledProcessors ? _self._enabledProcessors : enabledProcessors // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
