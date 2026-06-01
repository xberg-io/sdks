// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'processing_warning.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProcessingWarning {

/// Human-readable description of what went wrong.
 String get message;/// The pipeline stage or feature that produced this warning.
/// (e.g., "embedding", "chunking", "language_detection", "output_format").
 String get source;
/// Create a copy of ProcessingWarning
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProcessingWarningCopyWith<ProcessingWarning> get copyWith => _$ProcessingWarningCopyWithImpl<ProcessingWarning>(this as ProcessingWarning, _$identity);

  /// Serializes this ProcessingWarning to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProcessingWarning&&(identical(other.message, message) || other.message == message)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,source);

@override
String toString() {
  return 'ProcessingWarning(message: $message, source: $source)';
}


}

/// @nodoc
abstract mixin class $ProcessingWarningCopyWith<$Res>  {
  factory $ProcessingWarningCopyWith(ProcessingWarning value, $Res Function(ProcessingWarning) _then) = _$ProcessingWarningCopyWithImpl;
@useResult
$Res call({
 String message, String source
});




}
/// @nodoc
class _$ProcessingWarningCopyWithImpl<$Res>
    implements $ProcessingWarningCopyWith<$Res> {
  _$ProcessingWarningCopyWithImpl(this._self, this._then);

  final ProcessingWarning _self;
  final $Res Function(ProcessingWarning) _then;

/// Create a copy of ProcessingWarning
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? source = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProcessingWarning].
extension ProcessingWarningPatterns on ProcessingWarning {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProcessingWarning value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProcessingWarning() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProcessingWarning value)  $default,){
final _that = this;
switch (_that) {
case _ProcessingWarning():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProcessingWarning value)?  $default,){
final _that = this;
switch (_that) {
case _ProcessingWarning() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  String source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProcessingWarning() when $default != null:
return $default(_that.message,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  String source)  $default,) {final _that = this;
switch (_that) {
case _ProcessingWarning():
return $default(_that.message,_that.source);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  String source)?  $default,) {final _that = this;
switch (_that) {
case _ProcessingWarning() when $default != null:
return $default(_that.message,_that.source);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProcessingWarning implements ProcessingWarning {
  const _ProcessingWarning({required this.message, required this.source});
  factory _ProcessingWarning.fromJson(Map<String, dynamic> json) => _$ProcessingWarningFromJson(json);

/// Human-readable description of what went wrong.
@override final  String message;
/// The pipeline stage or feature that produced this warning.
/// (e.g., "embedding", "chunking", "language_detection", "output_format").
@override final  String source;

/// Create a copy of ProcessingWarning
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProcessingWarningCopyWith<_ProcessingWarning> get copyWith => __$ProcessingWarningCopyWithImpl<_ProcessingWarning>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProcessingWarningToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProcessingWarning&&(identical(other.message, message) || other.message == message)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,source);

@override
String toString() {
  return 'ProcessingWarning(message: $message, source: $source)';
}


}

/// @nodoc
abstract mixin class _$ProcessingWarningCopyWith<$Res> implements $ProcessingWarningCopyWith<$Res> {
  factory _$ProcessingWarningCopyWith(_ProcessingWarning value, $Res Function(_ProcessingWarning) _then) = __$ProcessingWarningCopyWithImpl;
@override @useResult
$Res call({
 String message, String source
});




}
/// @nodoc
class __$ProcessingWarningCopyWithImpl<$Res>
    implements _$ProcessingWarningCopyWith<$Res> {
  __$ProcessingWarningCopyWithImpl(this._self, this._then);

  final _ProcessingWarning _self;
  final $Res Function(_ProcessingWarning) _then;

/// Create a copy of ProcessingWarning
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? source = null,}) {
  return _then(_ProcessingWarning(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
