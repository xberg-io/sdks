// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'heading_level.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HeadingLevel {

/// Heading depth (1 = h1, 2 = h2, etc.)
 int get level;/// The text content of the heading.
 String get text;
/// Create a copy of HeadingLevel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HeadingLevelCopyWith<HeadingLevel> get copyWith => _$HeadingLevelCopyWithImpl<HeadingLevel>(this as HeadingLevel, _$identity);

  /// Serializes this HeadingLevel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeadingLevel&&(identical(other.level, level) || other.level == level)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,level,text);

@override
String toString() {
  return 'HeadingLevel(level: $level, text: $text)';
}


}

/// @nodoc
abstract mixin class $HeadingLevelCopyWith<$Res>  {
  factory $HeadingLevelCopyWith(HeadingLevel value, $Res Function(HeadingLevel) _then) = _$HeadingLevelCopyWithImpl;
@useResult
$Res call({
 int level, String text
});




}
/// @nodoc
class _$HeadingLevelCopyWithImpl<$Res>
    implements $HeadingLevelCopyWith<$Res> {
  _$HeadingLevelCopyWithImpl(this._self, this._then);

  final HeadingLevel _self;
  final $Res Function(HeadingLevel) _then;

/// Create a copy of HeadingLevel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? level = null,Object? text = null,}) {
  return _then(_self.copyWith(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HeadingLevel].
extension HeadingLevelPatterns on HeadingLevel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HeadingLevel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HeadingLevel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HeadingLevel value)  $default,){
final _that = this;
switch (_that) {
case _HeadingLevel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HeadingLevel value)?  $default,){
final _that = this;
switch (_that) {
case _HeadingLevel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int level,  String text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HeadingLevel() when $default != null:
return $default(_that.level,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int level,  String text)  $default,) {final _that = this;
switch (_that) {
case _HeadingLevel():
return $default(_that.level,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int level,  String text)?  $default,) {final _that = this;
switch (_that) {
case _HeadingLevel() when $default != null:
return $default(_that.level,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HeadingLevel implements HeadingLevel {
  const _HeadingLevel({required this.level, required this.text});
  factory _HeadingLevel.fromJson(Map<String, dynamic> json) => _$HeadingLevelFromJson(json);

/// Heading depth (1 = h1, 2 = h2, etc.)
@override final  int level;
/// The text content of the heading.
@override final  String text;

/// Create a copy of HeadingLevel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HeadingLevelCopyWith<_HeadingLevel> get copyWith => __$HeadingLevelCopyWithImpl<_HeadingLevel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HeadingLevelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HeadingLevel&&(identical(other.level, level) || other.level == level)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,level,text);

@override
String toString() {
  return 'HeadingLevel(level: $level, text: $text)';
}


}

/// @nodoc
abstract mixin class _$HeadingLevelCopyWith<$Res> implements $HeadingLevelCopyWith<$Res> {
  factory _$HeadingLevelCopyWith(_HeadingLevel value, $Res Function(_HeadingLevel) _then) = __$HeadingLevelCopyWithImpl;
@override @useResult
$Res call({
 int level, String text
});




}
/// @nodoc
class __$HeadingLevelCopyWithImpl<$Res>
    implements _$HeadingLevelCopyWith<$Res> {
  __$HeadingLevelCopyWithImpl(this._self, this._then);

  final _HeadingLevel _self;
  final $Res Function(_HeadingLevel) _then;

/// Create a copy of HeadingLevel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? level = null,Object? text = null,}) {
  return _then(_HeadingLevel(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
