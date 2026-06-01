// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_boundary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PageBoundary {

/// Byte offset where this page ends in the content string (UTF-8 valid boundary, exclusive)
@JsonKey(name: 'byte_end') int get byteEnd;/// Byte offset where this page starts in the content string (UTF-8 valid boundary, inclusive)
@JsonKey(name: 'byte_start') int get byteStart;/// Page number (1-indexed)
@JsonKey(name: 'page_number') int get pageNumber;
/// Create a copy of PageBoundary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageBoundaryCopyWith<PageBoundary> get copyWith => _$PageBoundaryCopyWithImpl<PageBoundary>(this as PageBoundary, _$identity);

  /// Serializes this PageBoundary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageBoundary&&(identical(other.byteEnd, byteEnd) || other.byteEnd == byteEnd)&&(identical(other.byteStart, byteStart) || other.byteStart == byteStart)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,byteEnd,byteStart,pageNumber);

@override
String toString() {
  return 'PageBoundary(byteEnd: $byteEnd, byteStart: $byteStart, pageNumber: $pageNumber)';
}


}

/// @nodoc
abstract mixin class $PageBoundaryCopyWith<$Res>  {
  factory $PageBoundaryCopyWith(PageBoundary value, $Res Function(PageBoundary) _then) = _$PageBoundaryCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'byte_end') int byteEnd,@JsonKey(name: 'byte_start') int byteStart,@JsonKey(name: 'page_number') int pageNumber
});




}
/// @nodoc
class _$PageBoundaryCopyWithImpl<$Res>
    implements $PageBoundaryCopyWith<$Res> {
  _$PageBoundaryCopyWithImpl(this._self, this._then);

  final PageBoundary _self;
  final $Res Function(PageBoundary) _then;

/// Create a copy of PageBoundary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? byteEnd = null,Object? byteStart = null,Object? pageNumber = null,}) {
  return _then(_self.copyWith(
byteEnd: null == byteEnd ? _self.byteEnd : byteEnd // ignore: cast_nullable_to_non_nullable
as int,byteStart: null == byteStart ? _self.byteStart : byteStart // ignore: cast_nullable_to_non_nullable
as int,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PageBoundary].
extension PageBoundaryPatterns on PageBoundary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PageBoundary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PageBoundary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PageBoundary value)  $default,){
final _that = this;
switch (_that) {
case _PageBoundary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PageBoundary value)?  $default,){
final _that = this;
switch (_that) {
case _PageBoundary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'byte_end')  int byteEnd, @JsonKey(name: 'byte_start')  int byteStart, @JsonKey(name: 'page_number')  int pageNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PageBoundary() when $default != null:
return $default(_that.byteEnd,_that.byteStart,_that.pageNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'byte_end')  int byteEnd, @JsonKey(name: 'byte_start')  int byteStart, @JsonKey(name: 'page_number')  int pageNumber)  $default,) {final _that = this;
switch (_that) {
case _PageBoundary():
return $default(_that.byteEnd,_that.byteStart,_that.pageNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'byte_end')  int byteEnd, @JsonKey(name: 'byte_start')  int byteStart, @JsonKey(name: 'page_number')  int pageNumber)?  $default,) {final _that = this;
switch (_that) {
case _PageBoundary() when $default != null:
return $default(_that.byteEnd,_that.byteStart,_that.pageNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PageBoundary implements PageBoundary {
  const _PageBoundary({@JsonKey(name: 'byte_end') required this.byteEnd, @JsonKey(name: 'byte_start') required this.byteStart, @JsonKey(name: 'page_number') required this.pageNumber});
  factory _PageBoundary.fromJson(Map<String, dynamic> json) => _$PageBoundaryFromJson(json);

/// Byte offset where this page ends in the content string (UTF-8 valid boundary, exclusive)
@override@JsonKey(name: 'byte_end') final  int byteEnd;
/// Byte offset where this page starts in the content string (UTF-8 valid boundary, inclusive)
@override@JsonKey(name: 'byte_start') final  int byteStart;
/// Page number (1-indexed)
@override@JsonKey(name: 'page_number') final  int pageNumber;

/// Create a copy of PageBoundary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageBoundaryCopyWith<_PageBoundary> get copyWith => __$PageBoundaryCopyWithImpl<_PageBoundary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageBoundaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageBoundary&&(identical(other.byteEnd, byteEnd) || other.byteEnd == byteEnd)&&(identical(other.byteStart, byteStart) || other.byteStart == byteStart)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,byteEnd,byteStart,pageNumber);

@override
String toString() {
  return 'PageBoundary(byteEnd: $byteEnd, byteStart: $byteStart, pageNumber: $pageNumber)';
}


}

/// @nodoc
abstract mixin class _$PageBoundaryCopyWith<$Res> implements $PageBoundaryCopyWith<$Res> {
  factory _$PageBoundaryCopyWith(_PageBoundary value, $Res Function(_PageBoundary) _then) = __$PageBoundaryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'byte_end') int byteEnd,@JsonKey(name: 'byte_start') int byteStart,@JsonKey(name: 'page_number') int pageNumber
});




}
/// @nodoc
class __$PageBoundaryCopyWithImpl<$Res>
    implements _$PageBoundaryCopyWith<$Res> {
  __$PageBoundaryCopyWithImpl(this._self, this._then);

  final _PageBoundary _self;
  final $Res Function(_PageBoundary) _then;

/// Create a copy of PageBoundary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? byteEnd = null,Object? byteStart = null,Object? pageNumber = null,}) {
  return _then(_PageBoundary(
byteEnd: null == byteEnd ? _self.byteEnd : byteEnd // ignore: cast_nullable_to_non_nullable
as int,byteStart: null == byteStart ? _self.byteStart : byteStart // ignore: cast_nullable_to_non_nullable
as int,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
