// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diff_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiffQuery {

/// Version sequence or job ID for the "from" extraction.
 String get from;/// Version sequence or job ID for the "to" extraction.
 String get to;
/// Create a copy of DiffQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiffQueryCopyWith<DiffQuery> get copyWith => _$DiffQueryCopyWithImpl<DiffQuery>(this as DiffQuery, _$identity);

  /// Serializes this DiffQuery to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiffQuery&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to);

@override
String toString() {
  return 'DiffQuery(from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class $DiffQueryCopyWith<$Res>  {
  factory $DiffQueryCopyWith(DiffQuery value, $Res Function(DiffQuery) _then) = _$DiffQueryCopyWithImpl;
@useResult
$Res call({
 String from, String to
});




}
/// @nodoc
class _$DiffQueryCopyWithImpl<$Res>
    implements $DiffQueryCopyWith<$Res> {
  _$DiffQueryCopyWithImpl(this._self, this._then);

  final DiffQuery _self;
  final $Res Function(DiffQuery) _then;

/// Create a copy of DiffQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = null,}) {
  return _then(_self.copyWith(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DiffQuery].
extension DiffQueryPatterns on DiffQuery {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiffQuery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiffQuery() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiffQuery value)  $default,){
final _that = this;
switch (_that) {
case _DiffQuery():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiffQuery value)?  $default,){
final _that = this;
switch (_that) {
case _DiffQuery() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String from,  String to)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiffQuery() when $default != null:
return $default(_that.from,_that.to);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String from,  String to)  $default,) {final _that = this;
switch (_that) {
case _DiffQuery():
return $default(_that.from,_that.to);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String from,  String to)?  $default,) {final _that = this;
switch (_that) {
case _DiffQuery() when $default != null:
return $default(_that.from,_that.to);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DiffQuery implements DiffQuery {
  const _DiffQuery({required this.from, required this.to});
  factory _DiffQuery.fromJson(Map<String, dynamic> json) => _$DiffQueryFromJson(json);

/// Version sequence or job ID for the "from" extraction.
@override final  String from;
/// Version sequence or job ID for the "to" extraction.
@override final  String to;

/// Create a copy of DiffQuery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiffQueryCopyWith<_DiffQuery> get copyWith => __$DiffQueryCopyWithImpl<_DiffQuery>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiffQueryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiffQuery&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to);

@override
String toString() {
  return 'DiffQuery(from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class _$DiffQueryCopyWith<$Res> implements $DiffQueryCopyWith<$Res> {
  factory _$DiffQueryCopyWith(_DiffQuery value, $Res Function(_DiffQuery) _then) = __$DiffQueryCopyWithImpl;
@override @useResult
$Res call({
 String from, String to
});




}
/// @nodoc
class __$DiffQueryCopyWithImpl<$Res>
    implements _$DiffQueryCopyWith<$Res> {
  __$DiffQueryCopyWithImpl(this._self, this._then);

  final _DiffQuery _self;
  final $Res Function(_DiffQuery) _then;

/// Create a copy of DiffQuery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,}) {
  return _then(_DiffQuery(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
