// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'heading_context.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HeadingContext {

/// The heading hierarchy from document root to this chunk's section.
/// Index 0 is the outermost (h1), last element is the most specific.
 List<HeadingLevel> get headings;
/// Create a copy of HeadingContext
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HeadingContextCopyWith<HeadingContext> get copyWith => _$HeadingContextCopyWithImpl<HeadingContext>(this as HeadingContext, _$identity);

  /// Serializes this HeadingContext to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeadingContext&&const DeepCollectionEquality().equals(other.headings, headings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(headings));

@override
String toString() {
  return 'HeadingContext(headings: $headings)';
}


}

/// @nodoc
abstract mixin class $HeadingContextCopyWith<$Res>  {
  factory $HeadingContextCopyWith(HeadingContext value, $Res Function(HeadingContext) _then) = _$HeadingContextCopyWithImpl;
@useResult
$Res call({
 List<HeadingLevel> headings
});




}
/// @nodoc
class _$HeadingContextCopyWithImpl<$Res>
    implements $HeadingContextCopyWith<$Res> {
  _$HeadingContextCopyWithImpl(this._self, this._then);

  final HeadingContext _self;
  final $Res Function(HeadingContext) _then;

/// Create a copy of HeadingContext
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? headings = null,}) {
  return _then(_self.copyWith(
headings: null == headings ? _self.headings : headings // ignore: cast_nullable_to_non_nullable
as List<HeadingLevel>,
  ));
}

}


/// Adds pattern-matching-related methods to [HeadingContext].
extension HeadingContextPatterns on HeadingContext {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HeadingContext value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HeadingContext() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HeadingContext value)  $default,){
final _that = this;
switch (_that) {
case _HeadingContext():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HeadingContext value)?  $default,){
final _that = this;
switch (_that) {
case _HeadingContext() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<HeadingLevel> headings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HeadingContext() when $default != null:
return $default(_that.headings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<HeadingLevel> headings)  $default,) {final _that = this;
switch (_that) {
case _HeadingContext():
return $default(_that.headings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<HeadingLevel> headings)?  $default,) {final _that = this;
switch (_that) {
case _HeadingContext() when $default != null:
return $default(_that.headings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HeadingContext implements HeadingContext {
  const _HeadingContext({required final  List<HeadingLevel> headings}): _headings = headings;
  factory _HeadingContext.fromJson(Map<String, dynamic> json) => _$HeadingContextFromJson(json);

/// The heading hierarchy from document root to this chunk's section.
/// Index 0 is the outermost (h1), last element is the most specific.
 final  List<HeadingLevel> _headings;
/// The heading hierarchy from document root to this chunk's section.
/// Index 0 is the outermost (h1), last element is the most specific.
@override List<HeadingLevel> get headings {
  if (_headings is EqualUnmodifiableListView) return _headings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_headings);
}


/// Create a copy of HeadingContext
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HeadingContextCopyWith<_HeadingContext> get copyWith => __$HeadingContextCopyWithImpl<_HeadingContext>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HeadingContextToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HeadingContext&&const DeepCollectionEquality().equals(other._headings, _headings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_headings));

@override
String toString() {
  return 'HeadingContext(headings: $headings)';
}


}

/// @nodoc
abstract mixin class _$HeadingContextCopyWith<$Res> implements $HeadingContextCopyWith<$Res> {
  factory _$HeadingContextCopyWith(_HeadingContext value, $Res Function(_HeadingContext) _then) = __$HeadingContextCopyWithImpl;
@override @useResult
$Res call({
 List<HeadingLevel> headings
});




}
/// @nodoc
class __$HeadingContextCopyWithImpl<$Res>
    implements _$HeadingContextCopyWith<$Res> {
  __$HeadingContextCopyWithImpl(this._self, this._then);

  final _HeadingContext _self;
  final $Res Function(_HeadingContext) _then;

/// Create a copy of HeadingContext
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? headings = null,}) {
  return _then(_HeadingContext(
headings: null == headings ? _self._headings : headings // ignore: cast_nullable_to_non_nullable
as List<HeadingLevel>,
  ));
}


}

// dart format on
