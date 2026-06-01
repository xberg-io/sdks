// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_submission.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DocumentSubmission {

/// Job ID for the submitted document
@JsonKey(name: 'job_id') String get jobId;/// Optional document ID from lineage (None for non-lineage jobs)
@JsonKey(name: 'document_id') String? get documentId;/// Optional version sequence for lineage (None for non-lineage jobs)
@JsonKey(name: 'version_sequence') int? get versionSequence;
/// Create a copy of DocumentSubmission
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentSubmissionCopyWith<DocumentSubmission> get copyWith => _$DocumentSubmissionCopyWithImpl<DocumentSubmission>(this as DocumentSubmission, _$identity);

  /// Serializes this DocumentSubmission to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentSubmission&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.documentId, documentId) || other.documentId == documentId)&&(identical(other.versionSequence, versionSequence) || other.versionSequence == versionSequence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,jobId,documentId,versionSequence);

@override
String toString() {
  return 'DocumentSubmission(jobId: $jobId, documentId: $documentId, versionSequence: $versionSequence)';
}


}

/// @nodoc
abstract mixin class $DocumentSubmissionCopyWith<$Res>  {
  factory $DocumentSubmissionCopyWith(DocumentSubmission value, $Res Function(DocumentSubmission) _then) = _$DocumentSubmissionCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'job_id') String jobId,@JsonKey(name: 'document_id') String? documentId,@JsonKey(name: 'version_sequence') int? versionSequence
});




}
/// @nodoc
class _$DocumentSubmissionCopyWithImpl<$Res>
    implements $DocumentSubmissionCopyWith<$Res> {
  _$DocumentSubmissionCopyWithImpl(this._self, this._then);

  final DocumentSubmission _self;
  final $Res Function(DocumentSubmission) _then;

/// Create a copy of DocumentSubmission
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? jobId = null,Object? documentId = freezed,Object? versionSequence = freezed,}) {
  return _then(_self.copyWith(
jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,documentId: freezed == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as String?,versionSequence: freezed == versionSequence ? _self.versionSequence : versionSequence // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [DocumentSubmission].
extension DocumentSubmissionPatterns on DocumentSubmission {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DocumentSubmission value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DocumentSubmission() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DocumentSubmission value)  $default,){
final _that = this;
switch (_that) {
case _DocumentSubmission():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DocumentSubmission value)?  $default,){
final _that = this;
switch (_that) {
case _DocumentSubmission() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'job_id')  String jobId, @JsonKey(name: 'document_id')  String? documentId, @JsonKey(name: 'version_sequence')  int? versionSequence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DocumentSubmission() when $default != null:
return $default(_that.jobId,_that.documentId,_that.versionSequence);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'job_id')  String jobId, @JsonKey(name: 'document_id')  String? documentId, @JsonKey(name: 'version_sequence')  int? versionSequence)  $default,) {final _that = this;
switch (_that) {
case _DocumentSubmission():
return $default(_that.jobId,_that.documentId,_that.versionSequence);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'job_id')  String jobId, @JsonKey(name: 'document_id')  String? documentId, @JsonKey(name: 'version_sequence')  int? versionSequence)?  $default,) {final _that = this;
switch (_that) {
case _DocumentSubmission() when $default != null:
return $default(_that.jobId,_that.documentId,_that.versionSequence);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DocumentSubmission implements DocumentSubmission {
  const _DocumentSubmission({@JsonKey(name: 'job_id') required this.jobId, @JsonKey(name: 'document_id') this.documentId, @JsonKey(name: 'version_sequence') this.versionSequence});
  factory _DocumentSubmission.fromJson(Map<String, dynamic> json) => _$DocumentSubmissionFromJson(json);

/// Job ID for the submitted document
@override@JsonKey(name: 'job_id') final  String jobId;
/// Optional document ID from lineage (None for non-lineage jobs)
@override@JsonKey(name: 'document_id') final  String? documentId;
/// Optional version sequence for lineage (None for non-lineage jobs)
@override@JsonKey(name: 'version_sequence') final  int? versionSequence;

/// Create a copy of DocumentSubmission
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentSubmissionCopyWith<_DocumentSubmission> get copyWith => __$DocumentSubmissionCopyWithImpl<_DocumentSubmission>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentSubmissionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentSubmission&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.documentId, documentId) || other.documentId == documentId)&&(identical(other.versionSequence, versionSequence) || other.versionSequence == versionSequence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,jobId,documentId,versionSequence);

@override
String toString() {
  return 'DocumentSubmission(jobId: $jobId, documentId: $documentId, versionSequence: $versionSequence)';
}


}

/// @nodoc
abstract mixin class _$DocumentSubmissionCopyWith<$Res> implements $DocumentSubmissionCopyWith<$Res> {
  factory _$DocumentSubmissionCopyWith(_DocumentSubmission value, $Res Function(_DocumentSubmission) _then) = __$DocumentSubmissionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'job_id') String jobId,@JsonKey(name: 'document_id') String? documentId,@JsonKey(name: 'version_sequence') int? versionSequence
});




}
/// @nodoc
class __$DocumentSubmissionCopyWithImpl<$Res>
    implements _$DocumentSubmissionCopyWith<$Res> {
  __$DocumentSubmissionCopyWithImpl(this._self, this._then);

  final _DocumentSubmission _self;
  final $Res Function(_DocumentSubmission) _then;

/// Create a copy of DocumentSubmission
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? jobId = null,Object? documentId = freezed,Object? versionSequence = freezed,}) {
  return _then(_DocumentSubmission(
jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,documentId: freezed == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as String?,versionSequence: freezed == versionSequence ? _self.versionSequence : versionSequence // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
