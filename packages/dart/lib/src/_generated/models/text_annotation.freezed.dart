// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text_annotation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TextAnnotation {

/// End byte offset in the node's text content (exclusive).
 int get end;/// Annotation type.
 AnnotationKind get kind;/// Start byte offset in the node's text content (inclusive).
 int get start;
/// Create a copy of TextAnnotation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextAnnotationCopyWith<TextAnnotation> get copyWith => _$TextAnnotationCopyWithImpl<TextAnnotation>(this as TextAnnotation, _$identity);

  /// Serializes this TextAnnotation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextAnnotation&&(identical(other.end, end) || other.end == end)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.start, start) || other.start == start));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,end,kind,start);

@override
String toString() {
  return 'TextAnnotation(end: $end, kind: $kind, start: $start)';
}


}

/// @nodoc
abstract mixin class $TextAnnotationCopyWith<$Res>  {
  factory $TextAnnotationCopyWith(TextAnnotation value, $Res Function(TextAnnotation) _then) = _$TextAnnotationCopyWithImpl;
@useResult
$Res call({
 int end, AnnotationKind kind, int start
});


$AnnotationKindCopyWith<$Res> get kind;

}
/// @nodoc
class _$TextAnnotationCopyWithImpl<$Res>
    implements $TextAnnotationCopyWith<$Res> {
  _$TextAnnotationCopyWithImpl(this._self, this._then);

  final TextAnnotation _self;
  final $Res Function(TextAnnotation) _then;

/// Create a copy of TextAnnotation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? end = null,Object? kind = null,Object? start = null,}) {
  return _then(_self.copyWith(
end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as AnnotationKind,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of TextAnnotation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnnotationKindCopyWith<$Res> get kind {
  
  return $AnnotationKindCopyWith<$Res>(_self.kind, (value) {
    return _then(_self.copyWith(kind: value));
  });
}
}


/// Adds pattern-matching-related methods to [TextAnnotation].
extension TextAnnotationPatterns on TextAnnotation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TextAnnotation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TextAnnotation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TextAnnotation value)  $default,){
final _that = this;
switch (_that) {
case _TextAnnotation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TextAnnotation value)?  $default,){
final _that = this;
switch (_that) {
case _TextAnnotation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int end,  AnnotationKind kind,  int start)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TextAnnotation() when $default != null:
return $default(_that.end,_that.kind,_that.start);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int end,  AnnotationKind kind,  int start)  $default,) {final _that = this;
switch (_that) {
case _TextAnnotation():
return $default(_that.end,_that.kind,_that.start);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int end,  AnnotationKind kind,  int start)?  $default,) {final _that = this;
switch (_that) {
case _TextAnnotation() when $default != null:
return $default(_that.end,_that.kind,_that.start);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TextAnnotation implements TextAnnotation {
  const _TextAnnotation({required this.end, required this.kind, required this.start});
  factory _TextAnnotation.fromJson(Map<String, dynamic> json) => _$TextAnnotationFromJson(json);

/// End byte offset in the node's text content (exclusive).
@override final  int end;
/// Annotation type.
@override final  AnnotationKind kind;
/// Start byte offset in the node's text content (inclusive).
@override final  int start;

/// Create a copy of TextAnnotation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TextAnnotationCopyWith<_TextAnnotation> get copyWith => __$TextAnnotationCopyWithImpl<_TextAnnotation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TextAnnotationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TextAnnotation&&(identical(other.end, end) || other.end == end)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.start, start) || other.start == start));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,end,kind,start);

@override
String toString() {
  return 'TextAnnotation(end: $end, kind: $kind, start: $start)';
}


}

/// @nodoc
abstract mixin class _$TextAnnotationCopyWith<$Res> implements $TextAnnotationCopyWith<$Res> {
  factory _$TextAnnotationCopyWith(_TextAnnotation value, $Res Function(_TextAnnotation) _then) = __$TextAnnotationCopyWithImpl;
@override @useResult
$Res call({
 int end, AnnotationKind kind, int start
});


@override $AnnotationKindCopyWith<$Res> get kind;

}
/// @nodoc
class __$TextAnnotationCopyWithImpl<$Res>
    implements _$TextAnnotationCopyWith<$Res> {
  __$TextAnnotationCopyWithImpl(this._self, this._then);

  final _TextAnnotation _self;
  final $Res Function(_TextAnnotation) _then;

/// Create a copy of TextAnnotation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? end = null,Object? kind = null,Object? start = null,}) {
  return _then(_TextAnnotation(
end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as AnnotationKind,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of TextAnnotation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnnotationKindCopyWith<$Res> get kind {
  
  return $AnnotationKindCopyWith<$Res>(_self.kind, (value) {
    return _then(_self.copyWith(kind: value));
  });
}
}

// dart format on
