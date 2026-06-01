// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_versions_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ListVersionsQuery {

/// Maximum number of versions to return (default 50, max 200).
 int? get limit;/// Number of versions to skip.
 int? get offset;
/// Create a copy of ListVersionsQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListVersionsQueryCopyWith<ListVersionsQuery> get copyWith => _$ListVersionsQueryCopyWithImpl<ListVersionsQuery>(this as ListVersionsQuery, _$identity);

  /// Serializes this ListVersionsQuery to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListVersionsQuery&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.offset, offset) || other.offset == offset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,limit,offset);

@override
String toString() {
  return 'ListVersionsQuery(limit: $limit, offset: $offset)';
}


}

/// @nodoc
abstract mixin class $ListVersionsQueryCopyWith<$Res>  {
  factory $ListVersionsQueryCopyWith(ListVersionsQuery value, $Res Function(ListVersionsQuery) _then) = _$ListVersionsQueryCopyWithImpl;
@useResult
$Res call({
 int? limit, int? offset
});




}
/// @nodoc
class _$ListVersionsQueryCopyWithImpl<$Res>
    implements $ListVersionsQueryCopyWith<$Res> {
  _$ListVersionsQueryCopyWithImpl(this._self, this._then);

  final ListVersionsQuery _self;
  final $Res Function(ListVersionsQuery) _then;

/// Create a copy of ListVersionsQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? limit = freezed,Object? offset = freezed,}) {
  return _then(_self.copyWith(
limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,offset: freezed == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ListVersionsQuery].
extension ListVersionsQueryPatterns on ListVersionsQuery {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListVersionsQuery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListVersionsQuery() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListVersionsQuery value)  $default,){
final _that = this;
switch (_that) {
case _ListVersionsQuery():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListVersionsQuery value)?  $default,){
final _that = this;
switch (_that) {
case _ListVersionsQuery() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? limit,  int? offset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListVersionsQuery() when $default != null:
return $default(_that.limit,_that.offset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? limit,  int? offset)  $default,) {final _that = this;
switch (_that) {
case _ListVersionsQuery():
return $default(_that.limit,_that.offset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? limit,  int? offset)?  $default,) {final _that = this;
switch (_that) {
case _ListVersionsQuery() when $default != null:
return $default(_that.limit,_that.offset);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListVersionsQuery implements ListVersionsQuery {
  const _ListVersionsQuery({this.limit, this.offset});
  factory _ListVersionsQuery.fromJson(Map<String, dynamic> json) => _$ListVersionsQueryFromJson(json);

/// Maximum number of versions to return (default 50, max 200).
@override final  int? limit;
/// Number of versions to skip.
@override final  int? offset;

/// Create a copy of ListVersionsQuery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListVersionsQueryCopyWith<_ListVersionsQuery> get copyWith => __$ListVersionsQueryCopyWithImpl<_ListVersionsQuery>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListVersionsQueryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListVersionsQuery&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.offset, offset) || other.offset == offset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,limit,offset);

@override
String toString() {
  return 'ListVersionsQuery(limit: $limit, offset: $offset)';
}


}

/// @nodoc
abstract mixin class _$ListVersionsQueryCopyWith<$Res> implements $ListVersionsQueryCopyWith<$Res> {
  factory _$ListVersionsQueryCopyWith(_ListVersionsQuery value, $Res Function(_ListVersionsQuery) _then) = __$ListVersionsQueryCopyWithImpl;
@override @useResult
$Res call({
 int? limit, int? offset
});




}
/// @nodoc
class __$ListVersionsQueryCopyWithImpl<$Res>
    implements _$ListVersionsQueryCopyWith<$Res> {
  __$ListVersionsQueryCopyWithImpl(this._self, this._then);

  final _ListVersionsQuery _self;
  final $Res Function(_ListVersionsQuery) _then;

/// Create a copy of ListVersionsQuery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? limit = freezed,Object? offset = freezed,}) {
  return _then(_ListVersionsQuery(
limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,offset: freezed == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
