// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_reduction_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokenReductionConfig {

/// Reduction mode: "off", "light", "moderate", "aggressive", "maximum"
 String? get mode;/// Preserve capitalized/technical terms
@JsonKey(name: 'preserve_important_words') bool? get preserveImportantWords;
/// Create a copy of TokenReductionConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenReductionConfigCopyWith<TokenReductionConfig> get copyWith => _$TokenReductionConfigCopyWithImpl<TokenReductionConfig>(this as TokenReductionConfig, _$identity);

  /// Serializes this TokenReductionConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenReductionConfig&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.preserveImportantWords, preserveImportantWords) || other.preserveImportantWords == preserveImportantWords));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mode,preserveImportantWords);

@override
String toString() {
  return 'TokenReductionConfig(mode: $mode, preserveImportantWords: $preserveImportantWords)';
}


}

/// @nodoc
abstract mixin class $TokenReductionConfigCopyWith<$Res>  {
  factory $TokenReductionConfigCopyWith(TokenReductionConfig value, $Res Function(TokenReductionConfig) _then) = _$TokenReductionConfigCopyWithImpl;
@useResult
$Res call({
 String? mode,@JsonKey(name: 'preserve_important_words') bool? preserveImportantWords
});




}
/// @nodoc
class _$TokenReductionConfigCopyWithImpl<$Res>
    implements $TokenReductionConfigCopyWith<$Res> {
  _$TokenReductionConfigCopyWithImpl(this._self, this._then);

  final TokenReductionConfig _self;
  final $Res Function(TokenReductionConfig) _then;

/// Create a copy of TokenReductionConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = freezed,Object? preserveImportantWords = freezed,}) {
  return _then(_self.copyWith(
mode: freezed == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String?,preserveImportantWords: freezed == preserveImportantWords ? _self.preserveImportantWords : preserveImportantWords // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [TokenReductionConfig].
extension TokenReductionConfigPatterns on TokenReductionConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenReductionConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenReductionConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenReductionConfig value)  $default,){
final _that = this;
switch (_that) {
case _TokenReductionConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenReductionConfig value)?  $default,){
final _that = this;
switch (_that) {
case _TokenReductionConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? mode, @JsonKey(name: 'preserve_important_words')  bool? preserveImportantWords)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenReductionConfig() when $default != null:
return $default(_that.mode,_that.preserveImportantWords);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? mode, @JsonKey(name: 'preserve_important_words')  bool? preserveImportantWords)  $default,) {final _that = this;
switch (_that) {
case _TokenReductionConfig():
return $default(_that.mode,_that.preserveImportantWords);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? mode, @JsonKey(name: 'preserve_important_words')  bool? preserveImportantWords)?  $default,) {final _that = this;
switch (_that) {
case _TokenReductionConfig() when $default != null:
return $default(_that.mode,_that.preserveImportantWords);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TokenReductionConfig implements TokenReductionConfig {
  const _TokenReductionConfig({this.mode, @JsonKey(name: 'preserve_important_words') this.preserveImportantWords});
  factory _TokenReductionConfig.fromJson(Map<String, dynamic> json) => _$TokenReductionConfigFromJson(json);

/// Reduction mode: "off", "light", "moderate", "aggressive", "maximum"
@override final  String? mode;
/// Preserve capitalized/technical terms
@override@JsonKey(name: 'preserve_important_words') final  bool? preserveImportantWords;

/// Create a copy of TokenReductionConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenReductionConfigCopyWith<_TokenReductionConfig> get copyWith => __$TokenReductionConfigCopyWithImpl<_TokenReductionConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TokenReductionConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenReductionConfig&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.preserveImportantWords, preserveImportantWords) || other.preserveImportantWords == preserveImportantWords));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mode,preserveImportantWords);

@override
String toString() {
  return 'TokenReductionConfig(mode: $mode, preserveImportantWords: $preserveImportantWords)';
}


}

/// @nodoc
abstract mixin class _$TokenReductionConfigCopyWith<$Res> implements $TokenReductionConfigCopyWith<$Res> {
  factory _$TokenReductionConfigCopyWith(_TokenReductionConfig value, $Res Function(_TokenReductionConfig) _then) = __$TokenReductionConfigCopyWithImpl;
@override @useResult
$Res call({
 String? mode,@JsonKey(name: 'preserve_important_words') bool? preserveImportantWords
});




}
/// @nodoc
class __$TokenReductionConfigCopyWithImpl<$Res>
    implements _$TokenReductionConfigCopyWith<$Res> {
  __$TokenReductionConfigCopyWithImpl(this._self, this._then);

  final _TokenReductionConfig _self;
  final $Res Function(_TokenReductionConfig) _then;

/// Create a copy of TokenReductionConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = freezed,Object? preserveImportantWords = freezed,}) {
  return _then(_TokenReductionConfig(
mode: freezed == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String?,preserveImportantWords: freezed == preserveImportantWords ? _self.preserveImportantWords : preserveImportantWords // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
