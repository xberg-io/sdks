// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diff_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiffResponse {

/// Timestamp when the diff was computed.
@JsonKey(name: 'computed_at') DateTime get computedAt;/// The computed diff between the two extraction results.
///
/// Serialized to the wire as the full `kreuzberg::diff::ExtractionDiff`.
/// shape. The OpenAPI schema declares this as an opaque object because.
/// the underlying type recurses through `EmbeddedDiff -> Box<ExtractionDiff>`.
/// and utoipa's schema collector goes into a stack-overflow on inlined.
/// recursion. SDKs that want a typed surface here should decode the.
/// JSON manually against kreuzberg's published schema.
 dynamic get diff;/// Document ID being diffed.
@JsonKey(name: 'document_id') String get documentId;/// Job ID of the "from" (older) version.
@JsonKey(name: 'from_job_id') String get fromJobId;/// Version sequence number of the "from" version.
@JsonKey(name: 'from_version') int get fromVersion;/// Job ID of the "to" (newer) version.
@JsonKey(name: 'to_job_id') String get toJobId;/// Version sequence number of the "to" version.
@JsonKey(name: 'to_version') int get toVersion;
/// Create a copy of DiffResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiffResponseCopyWith<DiffResponse> get copyWith => _$DiffResponseCopyWithImpl<DiffResponse>(this as DiffResponse, _$identity);

  /// Serializes this DiffResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiffResponse&&(identical(other.computedAt, computedAt) || other.computedAt == computedAt)&&const DeepCollectionEquality().equals(other.diff, diff)&&(identical(other.documentId, documentId) || other.documentId == documentId)&&(identical(other.fromJobId, fromJobId) || other.fromJobId == fromJobId)&&(identical(other.fromVersion, fromVersion) || other.fromVersion == fromVersion)&&(identical(other.toJobId, toJobId) || other.toJobId == toJobId)&&(identical(other.toVersion, toVersion) || other.toVersion == toVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,computedAt,const DeepCollectionEquality().hash(diff),documentId,fromJobId,fromVersion,toJobId,toVersion);

@override
String toString() {
  return 'DiffResponse(computedAt: $computedAt, diff: $diff, documentId: $documentId, fromJobId: $fromJobId, fromVersion: $fromVersion, toJobId: $toJobId, toVersion: $toVersion)';
}


}

/// @nodoc
abstract mixin class $DiffResponseCopyWith<$Res>  {
  factory $DiffResponseCopyWith(DiffResponse value, $Res Function(DiffResponse) _then) = _$DiffResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'computed_at') DateTime computedAt, dynamic diff,@JsonKey(name: 'document_id') String documentId,@JsonKey(name: 'from_job_id') String fromJobId,@JsonKey(name: 'from_version') int fromVersion,@JsonKey(name: 'to_job_id') String toJobId,@JsonKey(name: 'to_version') int toVersion
});




}
/// @nodoc
class _$DiffResponseCopyWithImpl<$Res>
    implements $DiffResponseCopyWith<$Res> {
  _$DiffResponseCopyWithImpl(this._self, this._then);

  final DiffResponse _self;
  final $Res Function(DiffResponse) _then;

/// Create a copy of DiffResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? computedAt = null,Object? diff = freezed,Object? documentId = null,Object? fromJobId = null,Object? fromVersion = null,Object? toJobId = null,Object? toVersion = null,}) {
  return _then(_self.copyWith(
computedAt: null == computedAt ? _self.computedAt : computedAt // ignore: cast_nullable_to_non_nullable
as DateTime,diff: freezed == diff ? _self.diff : diff // ignore: cast_nullable_to_non_nullable
as dynamic,documentId: null == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as String,fromJobId: null == fromJobId ? _self.fromJobId : fromJobId // ignore: cast_nullable_to_non_nullable
as String,fromVersion: null == fromVersion ? _self.fromVersion : fromVersion // ignore: cast_nullable_to_non_nullable
as int,toJobId: null == toJobId ? _self.toJobId : toJobId // ignore: cast_nullable_to_non_nullable
as String,toVersion: null == toVersion ? _self.toVersion : toVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DiffResponse].
extension DiffResponsePatterns on DiffResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiffResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiffResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiffResponse value)  $default,){
final _that = this;
switch (_that) {
case _DiffResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiffResponse value)?  $default,){
final _that = this;
switch (_that) {
case _DiffResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'computed_at')  DateTime computedAt,  dynamic diff, @JsonKey(name: 'document_id')  String documentId, @JsonKey(name: 'from_job_id')  String fromJobId, @JsonKey(name: 'from_version')  int fromVersion, @JsonKey(name: 'to_job_id')  String toJobId, @JsonKey(name: 'to_version')  int toVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiffResponse() when $default != null:
return $default(_that.computedAt,_that.diff,_that.documentId,_that.fromJobId,_that.fromVersion,_that.toJobId,_that.toVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'computed_at')  DateTime computedAt,  dynamic diff, @JsonKey(name: 'document_id')  String documentId, @JsonKey(name: 'from_job_id')  String fromJobId, @JsonKey(name: 'from_version')  int fromVersion, @JsonKey(name: 'to_job_id')  String toJobId, @JsonKey(name: 'to_version')  int toVersion)  $default,) {final _that = this;
switch (_that) {
case _DiffResponse():
return $default(_that.computedAt,_that.diff,_that.documentId,_that.fromJobId,_that.fromVersion,_that.toJobId,_that.toVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'computed_at')  DateTime computedAt,  dynamic diff, @JsonKey(name: 'document_id')  String documentId, @JsonKey(name: 'from_job_id')  String fromJobId, @JsonKey(name: 'from_version')  int fromVersion, @JsonKey(name: 'to_job_id')  String toJobId, @JsonKey(name: 'to_version')  int toVersion)?  $default,) {final _that = this;
switch (_that) {
case _DiffResponse() when $default != null:
return $default(_that.computedAt,_that.diff,_that.documentId,_that.fromJobId,_that.fromVersion,_that.toJobId,_that.toVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DiffResponse implements DiffResponse {
  const _DiffResponse({@JsonKey(name: 'computed_at') required this.computedAt, required this.diff, @JsonKey(name: 'document_id') required this.documentId, @JsonKey(name: 'from_job_id') required this.fromJobId, @JsonKey(name: 'from_version') required this.fromVersion, @JsonKey(name: 'to_job_id') required this.toJobId, @JsonKey(name: 'to_version') required this.toVersion});
  factory _DiffResponse.fromJson(Map<String, dynamic> json) => _$DiffResponseFromJson(json);

/// Timestamp when the diff was computed.
@override@JsonKey(name: 'computed_at') final  DateTime computedAt;
/// The computed diff between the two extraction results.
///
/// Serialized to the wire as the full `kreuzberg::diff::ExtractionDiff`.
/// shape. The OpenAPI schema declares this as an opaque object because.
/// the underlying type recurses through `EmbeddedDiff -> Box<ExtractionDiff>`.
/// and utoipa's schema collector goes into a stack-overflow on inlined.
/// recursion. SDKs that want a typed surface here should decode the.
/// JSON manually against kreuzberg's published schema.
@override final  dynamic diff;
/// Document ID being diffed.
@override@JsonKey(name: 'document_id') final  String documentId;
/// Job ID of the "from" (older) version.
@override@JsonKey(name: 'from_job_id') final  String fromJobId;
/// Version sequence number of the "from" version.
@override@JsonKey(name: 'from_version') final  int fromVersion;
/// Job ID of the "to" (newer) version.
@override@JsonKey(name: 'to_job_id') final  String toJobId;
/// Version sequence number of the "to" version.
@override@JsonKey(name: 'to_version') final  int toVersion;

/// Create a copy of DiffResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiffResponseCopyWith<_DiffResponse> get copyWith => __$DiffResponseCopyWithImpl<_DiffResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiffResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiffResponse&&(identical(other.computedAt, computedAt) || other.computedAt == computedAt)&&const DeepCollectionEquality().equals(other.diff, diff)&&(identical(other.documentId, documentId) || other.documentId == documentId)&&(identical(other.fromJobId, fromJobId) || other.fromJobId == fromJobId)&&(identical(other.fromVersion, fromVersion) || other.fromVersion == fromVersion)&&(identical(other.toJobId, toJobId) || other.toJobId == toJobId)&&(identical(other.toVersion, toVersion) || other.toVersion == toVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,computedAt,const DeepCollectionEquality().hash(diff),documentId,fromJobId,fromVersion,toJobId,toVersion);

@override
String toString() {
  return 'DiffResponse(computedAt: $computedAt, diff: $diff, documentId: $documentId, fromJobId: $fromJobId, fromVersion: $fromVersion, toJobId: $toJobId, toVersion: $toVersion)';
}


}

/// @nodoc
abstract mixin class _$DiffResponseCopyWith<$Res> implements $DiffResponseCopyWith<$Res> {
  factory _$DiffResponseCopyWith(_DiffResponse value, $Res Function(_DiffResponse) _then) = __$DiffResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'computed_at') DateTime computedAt, dynamic diff,@JsonKey(name: 'document_id') String documentId,@JsonKey(name: 'from_job_id') String fromJobId,@JsonKey(name: 'from_version') int fromVersion,@JsonKey(name: 'to_job_id') String toJobId,@JsonKey(name: 'to_version') int toVersion
});




}
/// @nodoc
class __$DiffResponseCopyWithImpl<$Res>
    implements _$DiffResponseCopyWith<$Res> {
  __$DiffResponseCopyWithImpl(this._self, this._then);

  final _DiffResponse _self;
  final $Res Function(_DiffResponse) _then;

/// Create a copy of DiffResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? computedAt = null,Object? diff = freezed,Object? documentId = null,Object? fromJobId = null,Object? fromVersion = null,Object? toJobId = null,Object? toVersion = null,}) {
  return _then(_DiffResponse(
computedAt: null == computedAt ? _self.computedAt : computedAt // ignore: cast_nullable_to_non_nullable
as DateTime,diff: freezed == diff ? _self.diff : diff // ignore: cast_nullable_to_non_nullable
as dynamic,documentId: null == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as String,fromJobId: null == fromJobId ? _self.fromJobId : fromJobId // ignore: cast_nullable_to_non_nullable
as String,fromVersion: null == fromVersion ? _self.fromVersion : fromVersion // ignore: cast_nullable_to_non_nullable
as int,toJobId: null == toJobId ? _self.toJobId : toJobId // ignore: cast_nullable_to_non_nullable
as String,toVersion: null == toVersion ? _self.toVersion : toVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
