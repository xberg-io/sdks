// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'extract_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExtractResponse {

/// Job status
 String get status;/// Crawl job IDs (one per URL group)
@JsonKey(name: 'crawl_job_ids') List<String>? get crawlJobIds;/// Detailed document submissions (new, includes lineage when present)
 List<DocumentSubmission>? get documents;/// Job IDs for direct file extractions (backward compat)
@JsonKey(name: 'job_ids') List<String>? get jobIds;
/// Create a copy of ExtractResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExtractResponseCopyWith<ExtractResponse> get copyWith => _$ExtractResponseCopyWithImpl<ExtractResponse>(this as ExtractResponse, _$identity);

  /// Serializes this ExtractResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExtractResponse&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.crawlJobIds, crawlJobIds)&&const DeepCollectionEquality().equals(other.documents, documents)&&const DeepCollectionEquality().equals(other.jobIds, jobIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(crawlJobIds),const DeepCollectionEquality().hash(documents),const DeepCollectionEquality().hash(jobIds));

@override
String toString() {
  return 'ExtractResponse(status: $status, crawlJobIds: $crawlJobIds, documents: $documents, jobIds: $jobIds)';
}


}

/// @nodoc
abstract mixin class $ExtractResponseCopyWith<$Res>  {
  factory $ExtractResponseCopyWith(ExtractResponse value, $Res Function(ExtractResponse) _then) = _$ExtractResponseCopyWithImpl;
@useResult
$Res call({
 String status,@JsonKey(name: 'crawl_job_ids') List<String>? crawlJobIds, List<DocumentSubmission>? documents,@JsonKey(name: 'job_ids') List<String>? jobIds
});




}
/// @nodoc
class _$ExtractResponseCopyWithImpl<$Res>
    implements $ExtractResponseCopyWith<$Res> {
  _$ExtractResponseCopyWithImpl(this._self, this._then);

  final ExtractResponse _self;
  final $Res Function(ExtractResponse) _then;

/// Create a copy of ExtractResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? crawlJobIds = freezed,Object? documents = freezed,Object? jobIds = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,crawlJobIds: freezed == crawlJobIds ? _self.crawlJobIds : crawlJobIds // ignore: cast_nullable_to_non_nullable
as List<String>?,documents: freezed == documents ? _self.documents : documents // ignore: cast_nullable_to_non_nullable
as List<DocumentSubmission>?,jobIds: freezed == jobIds ? _self.jobIds : jobIds // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExtractResponse].
extension ExtractResponsePatterns on ExtractResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExtractResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExtractResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExtractResponse value)  $default,){
final _that = this;
switch (_that) {
case _ExtractResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExtractResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ExtractResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status, @JsonKey(name: 'crawl_job_ids')  List<String>? crawlJobIds,  List<DocumentSubmission>? documents, @JsonKey(name: 'job_ids')  List<String>? jobIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExtractResponse() when $default != null:
return $default(_that.status,_that.crawlJobIds,_that.documents,_that.jobIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status, @JsonKey(name: 'crawl_job_ids')  List<String>? crawlJobIds,  List<DocumentSubmission>? documents, @JsonKey(name: 'job_ids')  List<String>? jobIds)  $default,) {final _that = this;
switch (_that) {
case _ExtractResponse():
return $default(_that.status,_that.crawlJobIds,_that.documents,_that.jobIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status, @JsonKey(name: 'crawl_job_ids')  List<String>? crawlJobIds,  List<DocumentSubmission>? documents, @JsonKey(name: 'job_ids')  List<String>? jobIds)?  $default,) {final _that = this;
switch (_that) {
case _ExtractResponse() when $default != null:
return $default(_that.status,_that.crawlJobIds,_that.documents,_that.jobIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExtractResponse implements ExtractResponse {
  const _ExtractResponse({required this.status, @JsonKey(name: 'crawl_job_ids') final  List<String>? crawlJobIds, final  List<DocumentSubmission>? documents, @JsonKey(name: 'job_ids') final  List<String>? jobIds}): _crawlJobIds = crawlJobIds,_documents = documents,_jobIds = jobIds;
  factory _ExtractResponse.fromJson(Map<String, dynamic> json) => _$ExtractResponseFromJson(json);

/// Job status
@override final  String status;
/// Crawl job IDs (one per URL group)
 final  List<String>? _crawlJobIds;
/// Crawl job IDs (one per URL group)
@override@JsonKey(name: 'crawl_job_ids') List<String>? get crawlJobIds {
  final value = _crawlJobIds;
  if (value == null) return null;
  if (_crawlJobIds is EqualUnmodifiableListView) return _crawlJobIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Detailed document submissions (new, includes lineage when present)
 final  List<DocumentSubmission>? _documents;
/// Detailed document submissions (new, includes lineage when present)
@override List<DocumentSubmission>? get documents {
  final value = _documents;
  if (value == null) return null;
  if (_documents is EqualUnmodifiableListView) return _documents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Job IDs for direct file extractions (backward compat)
 final  List<String>? _jobIds;
/// Job IDs for direct file extractions (backward compat)
@override@JsonKey(name: 'job_ids') List<String>? get jobIds {
  final value = _jobIds;
  if (value == null) return null;
  if (_jobIds is EqualUnmodifiableListView) return _jobIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ExtractResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExtractResponseCopyWith<_ExtractResponse> get copyWith => __$ExtractResponseCopyWithImpl<_ExtractResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExtractResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExtractResponse&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._crawlJobIds, _crawlJobIds)&&const DeepCollectionEquality().equals(other._documents, _documents)&&const DeepCollectionEquality().equals(other._jobIds, _jobIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_crawlJobIds),const DeepCollectionEquality().hash(_documents),const DeepCollectionEquality().hash(_jobIds));

@override
String toString() {
  return 'ExtractResponse(status: $status, crawlJobIds: $crawlJobIds, documents: $documents, jobIds: $jobIds)';
}


}

/// @nodoc
abstract mixin class _$ExtractResponseCopyWith<$Res> implements $ExtractResponseCopyWith<$Res> {
  factory _$ExtractResponseCopyWith(_ExtractResponse value, $Res Function(_ExtractResponse) _then) = __$ExtractResponseCopyWithImpl;
@override @useResult
$Res call({
 String status,@JsonKey(name: 'crawl_job_ids') List<String>? crawlJobIds, List<DocumentSubmission>? documents,@JsonKey(name: 'job_ids') List<String>? jobIds
});




}
/// @nodoc
class __$ExtractResponseCopyWithImpl<$Res>
    implements _$ExtractResponseCopyWith<$Res> {
  __$ExtractResponseCopyWithImpl(this._self, this._then);

  final _ExtractResponse _self;
  final $Res Function(_ExtractResponse) _then;

/// Create a copy of ExtractResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? crawlJobIds = freezed,Object? documents = freezed,Object? jobIds = freezed,}) {
  return _then(_ExtractResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,crawlJobIds: freezed == crawlJobIds ? _self._crawlJobIds : crawlJobIds // ignore: cast_nullable_to_non_nullable
as List<String>?,documents: freezed == documents ? _self._documents : documents // ignore: cast_nullable_to_non_nullable
as List<DocumentSubmission>?,jobIds: freezed == jobIds ? _self._jobIds : jobIds // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
