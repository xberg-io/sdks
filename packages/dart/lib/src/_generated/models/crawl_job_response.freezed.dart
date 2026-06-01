// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crawl_job_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CrawlJobResponse {

/// Creation timestamp (RFC3339)
@JsonKey(name: 'created_at') DateTime get createdAt;/// Crawl job ID
 String get id;/// Output mode this job was submitted with (scrape, crawl, or extract)
@JsonKey(name: 'output_mode') String get outputMode;/// Crawl progress counters
 CrawlProgress get progress;/// Seed URLs that were submitted
@JsonKey(name: 'seed_urls') List<String> get seedUrls;/// Crawl job status
 CrawlJobStatus get status;/// Child extraction jobs (populated when output_mode=extract)
 List<CrawlChildJob>? get jobs;/// Crawled raw pages (populated when output_mode=scrape|crawl)
 List<CrawledPage>? get pages;
/// Create a copy of CrawlJobResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrawlJobResponseCopyWith<CrawlJobResponse> get copyWith => _$CrawlJobResponseCopyWithImpl<CrawlJobResponse>(this as CrawlJobResponse, _$identity);

  /// Serializes this CrawlJobResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrawlJobResponse&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.id, id) || other.id == id)&&(identical(other.outputMode, outputMode) || other.outputMode == outputMode)&&(identical(other.progress, progress) || other.progress == progress)&&const DeepCollectionEquality().equals(other.seedUrls, seedUrls)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.jobs, jobs)&&const DeepCollectionEquality().equals(other.pages, pages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,createdAt,id,outputMode,progress,const DeepCollectionEquality().hash(seedUrls),status,const DeepCollectionEquality().hash(jobs),const DeepCollectionEquality().hash(pages));

@override
String toString() {
  return 'CrawlJobResponse(createdAt: $createdAt, id: $id, outputMode: $outputMode, progress: $progress, seedUrls: $seedUrls, status: $status, jobs: $jobs, pages: $pages)';
}


}

/// @nodoc
abstract mixin class $CrawlJobResponseCopyWith<$Res>  {
  factory $CrawlJobResponseCopyWith(CrawlJobResponse value, $Res Function(CrawlJobResponse) _then) = _$CrawlJobResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'created_at') DateTime createdAt, String id,@JsonKey(name: 'output_mode') String outputMode, CrawlProgress progress,@JsonKey(name: 'seed_urls') List<String> seedUrls, CrawlJobStatus status, List<CrawlChildJob>? jobs, List<CrawledPage>? pages
});


$CrawlProgressCopyWith<$Res> get progress;

}
/// @nodoc
class _$CrawlJobResponseCopyWithImpl<$Res>
    implements $CrawlJobResponseCopyWith<$Res> {
  _$CrawlJobResponseCopyWithImpl(this._self, this._then);

  final CrawlJobResponse _self;
  final $Res Function(CrawlJobResponse) _then;

/// Create a copy of CrawlJobResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? createdAt = null,Object? id = null,Object? outputMode = null,Object? progress = null,Object? seedUrls = null,Object? status = null,Object? jobs = freezed,Object? pages = freezed,}) {
  return _then(_self.copyWith(
createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,outputMode: null == outputMode ? _self.outputMode : outputMode // ignore: cast_nullable_to_non_nullable
as String,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as CrawlProgress,seedUrls: null == seedUrls ? _self.seedUrls : seedUrls // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CrawlJobStatus,jobs: freezed == jobs ? _self.jobs : jobs // ignore: cast_nullable_to_non_nullable
as List<CrawlChildJob>?,pages: freezed == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as List<CrawledPage>?,
  ));
}
/// Create a copy of CrawlJobResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CrawlProgressCopyWith<$Res> get progress {
  
  return $CrawlProgressCopyWith<$Res>(_self.progress, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}


/// Adds pattern-matching-related methods to [CrawlJobResponse].
extension CrawlJobResponsePatterns on CrawlJobResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CrawlJobResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CrawlJobResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CrawlJobResponse value)  $default,){
final _that = this;
switch (_that) {
case _CrawlJobResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CrawlJobResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CrawlJobResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'created_at')  DateTime createdAt,  String id, @JsonKey(name: 'output_mode')  String outputMode,  CrawlProgress progress, @JsonKey(name: 'seed_urls')  List<String> seedUrls,  CrawlJobStatus status,  List<CrawlChildJob>? jobs,  List<CrawledPage>? pages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CrawlJobResponse() when $default != null:
return $default(_that.createdAt,_that.id,_that.outputMode,_that.progress,_that.seedUrls,_that.status,_that.jobs,_that.pages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'created_at')  DateTime createdAt,  String id, @JsonKey(name: 'output_mode')  String outputMode,  CrawlProgress progress, @JsonKey(name: 'seed_urls')  List<String> seedUrls,  CrawlJobStatus status,  List<CrawlChildJob>? jobs,  List<CrawledPage>? pages)  $default,) {final _that = this;
switch (_that) {
case _CrawlJobResponse():
return $default(_that.createdAt,_that.id,_that.outputMode,_that.progress,_that.seedUrls,_that.status,_that.jobs,_that.pages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'created_at')  DateTime createdAt,  String id, @JsonKey(name: 'output_mode')  String outputMode,  CrawlProgress progress, @JsonKey(name: 'seed_urls')  List<String> seedUrls,  CrawlJobStatus status,  List<CrawlChildJob>? jobs,  List<CrawledPage>? pages)?  $default,) {final _that = this;
switch (_that) {
case _CrawlJobResponse() when $default != null:
return $default(_that.createdAt,_that.id,_that.outputMode,_that.progress,_that.seedUrls,_that.status,_that.jobs,_that.pages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CrawlJobResponse implements CrawlJobResponse {
  const _CrawlJobResponse({@JsonKey(name: 'created_at') required this.createdAt, required this.id, @JsonKey(name: 'output_mode') required this.outputMode, required this.progress, @JsonKey(name: 'seed_urls') required final  List<String> seedUrls, required this.status, final  List<CrawlChildJob>? jobs, final  List<CrawledPage>? pages}): _seedUrls = seedUrls,_jobs = jobs,_pages = pages;
  factory _CrawlJobResponse.fromJson(Map<String, dynamic> json) => _$CrawlJobResponseFromJson(json);

/// Creation timestamp (RFC3339)
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
/// Crawl job ID
@override final  String id;
/// Output mode this job was submitted with (scrape, crawl, or extract)
@override@JsonKey(name: 'output_mode') final  String outputMode;
/// Crawl progress counters
@override final  CrawlProgress progress;
/// Seed URLs that were submitted
 final  List<String> _seedUrls;
/// Seed URLs that were submitted
@override@JsonKey(name: 'seed_urls') List<String> get seedUrls {
  if (_seedUrls is EqualUnmodifiableListView) return _seedUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_seedUrls);
}

/// Crawl job status
@override final  CrawlJobStatus status;
/// Child extraction jobs (populated when output_mode=extract)
 final  List<CrawlChildJob>? _jobs;
/// Child extraction jobs (populated when output_mode=extract)
@override List<CrawlChildJob>? get jobs {
  final value = _jobs;
  if (value == null) return null;
  if (_jobs is EqualUnmodifiableListView) return _jobs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Crawled raw pages (populated when output_mode=scrape|crawl)
 final  List<CrawledPage>? _pages;
/// Crawled raw pages (populated when output_mode=scrape|crawl)
@override List<CrawledPage>? get pages {
  final value = _pages;
  if (value == null) return null;
  if (_pages is EqualUnmodifiableListView) return _pages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of CrawlJobResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CrawlJobResponseCopyWith<_CrawlJobResponse> get copyWith => __$CrawlJobResponseCopyWithImpl<_CrawlJobResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CrawlJobResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CrawlJobResponse&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.id, id) || other.id == id)&&(identical(other.outputMode, outputMode) || other.outputMode == outputMode)&&(identical(other.progress, progress) || other.progress == progress)&&const DeepCollectionEquality().equals(other._seedUrls, _seedUrls)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._jobs, _jobs)&&const DeepCollectionEquality().equals(other._pages, _pages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,createdAt,id,outputMode,progress,const DeepCollectionEquality().hash(_seedUrls),status,const DeepCollectionEquality().hash(_jobs),const DeepCollectionEquality().hash(_pages));

@override
String toString() {
  return 'CrawlJobResponse(createdAt: $createdAt, id: $id, outputMode: $outputMode, progress: $progress, seedUrls: $seedUrls, status: $status, jobs: $jobs, pages: $pages)';
}


}

/// @nodoc
abstract mixin class _$CrawlJobResponseCopyWith<$Res> implements $CrawlJobResponseCopyWith<$Res> {
  factory _$CrawlJobResponseCopyWith(_CrawlJobResponse value, $Res Function(_CrawlJobResponse) _then) = __$CrawlJobResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'created_at') DateTime createdAt, String id,@JsonKey(name: 'output_mode') String outputMode, CrawlProgress progress,@JsonKey(name: 'seed_urls') List<String> seedUrls, CrawlJobStatus status, List<CrawlChildJob>? jobs, List<CrawledPage>? pages
});


@override $CrawlProgressCopyWith<$Res> get progress;

}
/// @nodoc
class __$CrawlJobResponseCopyWithImpl<$Res>
    implements _$CrawlJobResponseCopyWith<$Res> {
  __$CrawlJobResponseCopyWithImpl(this._self, this._then);

  final _CrawlJobResponse _self;
  final $Res Function(_CrawlJobResponse) _then;

/// Create a copy of CrawlJobResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? createdAt = null,Object? id = null,Object? outputMode = null,Object? progress = null,Object? seedUrls = null,Object? status = null,Object? jobs = freezed,Object? pages = freezed,}) {
  return _then(_CrawlJobResponse(
createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,outputMode: null == outputMode ? _self.outputMode : outputMode // ignore: cast_nullable_to_non_nullable
as String,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as CrawlProgress,seedUrls: null == seedUrls ? _self._seedUrls : seedUrls // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CrawlJobStatus,jobs: freezed == jobs ? _self._jobs : jobs // ignore: cast_nullable_to_non_nullable
as List<CrawlChildJob>?,pages: freezed == pages ? _self._pages : pages // ignore: cast_nullable_to_non_nullable
as List<CrawledPage>?,
  ));
}

/// Create a copy of CrawlJobResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CrawlProgressCopyWith<$Res> get progress {
  
  return $CrawlProgressCopyWith<$Res>(_self.progress, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}

// dart format on
