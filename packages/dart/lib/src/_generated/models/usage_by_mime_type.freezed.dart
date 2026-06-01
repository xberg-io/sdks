// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'usage_by_mime_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UsageByMimeType {

/// Number of documents of this MIME type processed
 int get documents;/// Number of failed extractions for this MIME type
 int get failed;/// Total pages extracted from documents of this MIME type
 int get pages;
/// Create a copy of UsageByMimeType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsageByMimeTypeCopyWith<UsageByMimeType> get copyWith => _$UsageByMimeTypeCopyWithImpl<UsageByMimeType>(this as UsageByMimeType, _$identity);

  /// Serializes this UsageByMimeType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsageByMimeType&&(identical(other.documents, documents) || other.documents == documents)&&(identical(other.failed, failed) || other.failed == failed)&&(identical(other.pages, pages) || other.pages == pages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,documents,failed,pages);

@override
String toString() {
  return 'UsageByMimeType(documents: $documents, failed: $failed, pages: $pages)';
}


}

/// @nodoc
abstract mixin class $UsageByMimeTypeCopyWith<$Res>  {
  factory $UsageByMimeTypeCopyWith(UsageByMimeType value, $Res Function(UsageByMimeType) _then) = _$UsageByMimeTypeCopyWithImpl;
@useResult
$Res call({
 int documents, int failed, int pages
});




}
/// @nodoc
class _$UsageByMimeTypeCopyWithImpl<$Res>
    implements $UsageByMimeTypeCopyWith<$Res> {
  _$UsageByMimeTypeCopyWithImpl(this._self, this._then);

  final UsageByMimeType _self;
  final $Res Function(UsageByMimeType) _then;

/// Create a copy of UsageByMimeType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? documents = null,Object? failed = null,Object? pages = null,}) {
  return _then(_self.copyWith(
documents: null == documents ? _self.documents : documents // ignore: cast_nullable_to_non_nullable
as int,failed: null == failed ? _self.failed : failed // ignore: cast_nullable_to_non_nullable
as int,pages: null == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UsageByMimeType].
extension UsageByMimeTypePatterns on UsageByMimeType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UsageByMimeType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UsageByMimeType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UsageByMimeType value)  $default,){
final _that = this;
switch (_that) {
case _UsageByMimeType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UsageByMimeType value)?  $default,){
final _that = this;
switch (_that) {
case _UsageByMimeType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int documents,  int failed,  int pages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UsageByMimeType() when $default != null:
return $default(_that.documents,_that.failed,_that.pages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int documents,  int failed,  int pages)  $default,) {final _that = this;
switch (_that) {
case _UsageByMimeType():
return $default(_that.documents,_that.failed,_that.pages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int documents,  int failed,  int pages)?  $default,) {final _that = this;
switch (_that) {
case _UsageByMimeType() when $default != null:
return $default(_that.documents,_that.failed,_that.pages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UsageByMimeType implements UsageByMimeType {
  const _UsageByMimeType({required this.documents, required this.failed, required this.pages});
  factory _UsageByMimeType.fromJson(Map<String, dynamic> json) => _$UsageByMimeTypeFromJson(json);

/// Number of documents of this MIME type processed
@override final  int documents;
/// Number of failed extractions for this MIME type
@override final  int failed;
/// Total pages extracted from documents of this MIME type
@override final  int pages;

/// Create a copy of UsageByMimeType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UsageByMimeTypeCopyWith<_UsageByMimeType> get copyWith => __$UsageByMimeTypeCopyWithImpl<_UsageByMimeType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UsageByMimeTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UsageByMimeType&&(identical(other.documents, documents) || other.documents == documents)&&(identical(other.failed, failed) || other.failed == failed)&&(identical(other.pages, pages) || other.pages == pages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,documents,failed,pages);

@override
String toString() {
  return 'UsageByMimeType(documents: $documents, failed: $failed, pages: $pages)';
}


}

/// @nodoc
abstract mixin class _$UsageByMimeTypeCopyWith<$Res> implements $UsageByMimeTypeCopyWith<$Res> {
  factory _$UsageByMimeTypeCopyWith(_UsageByMimeType value, $Res Function(_UsageByMimeType) _then) = __$UsageByMimeTypeCopyWithImpl;
@override @useResult
$Res call({
 int documents, int failed, int pages
});




}
/// @nodoc
class __$UsageByMimeTypeCopyWithImpl<$Res>
    implements _$UsageByMimeTypeCopyWith<$Res> {
  __$UsageByMimeTypeCopyWithImpl(this._self, this._then);

  final _UsageByMimeType _self;
  final $Res Function(_UsageByMimeType) _then;

/// Create a copy of UsageByMimeType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? documents = null,Object? failed = null,Object? pages = null,}) {
  return _then(_UsageByMimeType(
documents: null == documents ? _self.documents : documents // ignore: cast_nullable_to_non_nullable
as int,failed: null == failed ? _self.failed : failed // ignore: cast_nullable_to_non_nullable
as int,pages: null == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
