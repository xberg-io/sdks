// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diff_async_accepted.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiffAsyncAccepted {

/// The ID of the diff job for polling.
@JsonKey(name: 'diff_job_id') String get diffJobId;/// Current status of the job.
 DiffJobStatus get status;
/// Create a copy of DiffAsyncAccepted
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiffAsyncAcceptedCopyWith<DiffAsyncAccepted> get copyWith => _$DiffAsyncAcceptedCopyWithImpl<DiffAsyncAccepted>(this as DiffAsyncAccepted, _$identity);

  /// Serializes this DiffAsyncAccepted to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiffAsyncAccepted&&(identical(other.diffJobId, diffJobId) || other.diffJobId == diffJobId)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,diffJobId,status);

@override
String toString() {
  return 'DiffAsyncAccepted(diffJobId: $diffJobId, status: $status)';
}


}

/// @nodoc
abstract mixin class $DiffAsyncAcceptedCopyWith<$Res>  {
  factory $DiffAsyncAcceptedCopyWith(DiffAsyncAccepted value, $Res Function(DiffAsyncAccepted) _then) = _$DiffAsyncAcceptedCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'diff_job_id') String diffJobId, DiffJobStatus status
});




}
/// @nodoc
class _$DiffAsyncAcceptedCopyWithImpl<$Res>
    implements $DiffAsyncAcceptedCopyWith<$Res> {
  _$DiffAsyncAcceptedCopyWithImpl(this._self, this._then);

  final DiffAsyncAccepted _self;
  final $Res Function(DiffAsyncAccepted) _then;

/// Create a copy of DiffAsyncAccepted
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? diffJobId = null,Object? status = null,}) {
  return _then(_self.copyWith(
diffJobId: null == diffJobId ? _self.diffJobId : diffJobId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DiffJobStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [DiffAsyncAccepted].
extension DiffAsyncAcceptedPatterns on DiffAsyncAccepted {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiffAsyncAccepted value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiffAsyncAccepted() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiffAsyncAccepted value)  $default,){
final _that = this;
switch (_that) {
case _DiffAsyncAccepted():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiffAsyncAccepted value)?  $default,){
final _that = this;
switch (_that) {
case _DiffAsyncAccepted() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'diff_job_id')  String diffJobId,  DiffJobStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiffAsyncAccepted() when $default != null:
return $default(_that.diffJobId,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'diff_job_id')  String diffJobId,  DiffJobStatus status)  $default,) {final _that = this;
switch (_that) {
case _DiffAsyncAccepted():
return $default(_that.diffJobId,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'diff_job_id')  String diffJobId,  DiffJobStatus status)?  $default,) {final _that = this;
switch (_that) {
case _DiffAsyncAccepted() when $default != null:
return $default(_that.diffJobId,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DiffAsyncAccepted implements DiffAsyncAccepted {
  const _DiffAsyncAccepted({@JsonKey(name: 'diff_job_id') required this.diffJobId, required this.status});
  factory _DiffAsyncAccepted.fromJson(Map<String, dynamic> json) => _$DiffAsyncAcceptedFromJson(json);

/// The ID of the diff job for polling.
@override@JsonKey(name: 'diff_job_id') final  String diffJobId;
/// Current status of the job.
@override final  DiffJobStatus status;

/// Create a copy of DiffAsyncAccepted
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiffAsyncAcceptedCopyWith<_DiffAsyncAccepted> get copyWith => __$DiffAsyncAcceptedCopyWithImpl<_DiffAsyncAccepted>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiffAsyncAcceptedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiffAsyncAccepted&&(identical(other.diffJobId, diffJobId) || other.diffJobId == diffJobId)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,diffJobId,status);

@override
String toString() {
  return 'DiffAsyncAccepted(diffJobId: $diffJobId, status: $status)';
}


}

/// @nodoc
abstract mixin class _$DiffAsyncAcceptedCopyWith<$Res> implements $DiffAsyncAcceptedCopyWith<$Res> {
  factory _$DiffAsyncAcceptedCopyWith(_DiffAsyncAccepted value, $Res Function(_DiffAsyncAccepted) _then) = __$DiffAsyncAcceptedCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'diff_job_id') String diffJobId, DiffJobStatus status
});




}
/// @nodoc
class __$DiffAsyncAcceptedCopyWithImpl<$Res>
    implements _$DiffAsyncAcceptedCopyWith<$Res> {
  __$DiffAsyncAcceptedCopyWithImpl(this._self, this._then);

  final _DiffAsyncAccepted _self;
  final $Res Function(_DiffAsyncAccepted) _then;

/// Create a copy of DiffAsyncAccepted
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? diffJobId = null,Object? status = null,}) {
  return _then(_DiffAsyncAccepted(
diffJobId: null == diffJobId ? _self.diffJobId : diffJobId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DiffJobStatus,
  ));
}


}

// dart format on
