// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crawl_child_job.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CrawlChildJob {

/// Filename
 String get filename;/// Job ID (queryable via GET /v1/jobs/{id})
 String get id;/// Job status
 String get status;/// Raw body size in bytes of the source document fed to extraction.
/// For HTML pages this is the rendered HTML length; for binary.
/// documents it is the downloaded file size. Lets callers detect.
/// suspiciously small responses (e.g. WAF challenge pages captured.
/// as the "document" — typically 5–30 KB).
@JsonKey(name: 'body_bytes') int? get bodyBytes;/// Processing time in ms (when completed)
@JsonKey(name: 'processing_time_ms') int? get processingTimeMs;/// Extraction result (when completed)
 ExtractionResult? get result;/// Source URL where this document was found
@JsonKey(name: 'source_url') String? get sourceUrl;
/// Create a copy of CrawlChildJob
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrawlChildJobCopyWith<CrawlChildJob> get copyWith => _$CrawlChildJobCopyWithImpl<CrawlChildJob>(this as CrawlChildJob, _$identity);

  /// Serializes this CrawlChildJob to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrawlChildJob&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.bodyBytes, bodyBytes) || other.bodyBytes == bodyBytes)&&(identical(other.processingTimeMs, processingTimeMs) || other.processingTimeMs == processingTimeMs)&&(identical(other.result, result) || other.result == result)&&(identical(other.sourceUrl, sourceUrl) || other.sourceUrl == sourceUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,filename,id,status,bodyBytes,processingTimeMs,result,sourceUrl);

@override
String toString() {
  return 'CrawlChildJob(filename: $filename, id: $id, status: $status, bodyBytes: $bodyBytes, processingTimeMs: $processingTimeMs, result: $result, sourceUrl: $sourceUrl)';
}


}

/// @nodoc
abstract mixin class $CrawlChildJobCopyWith<$Res>  {
  factory $CrawlChildJobCopyWith(CrawlChildJob value, $Res Function(CrawlChildJob) _then) = _$CrawlChildJobCopyWithImpl;
@useResult
$Res call({
 String filename, String id, String status,@JsonKey(name: 'body_bytes') int? bodyBytes,@JsonKey(name: 'processing_time_ms') int? processingTimeMs, ExtractionResult? result,@JsonKey(name: 'source_url') String? sourceUrl
});


$ExtractionResultCopyWith<$Res>? get result;

}
/// @nodoc
class _$CrawlChildJobCopyWithImpl<$Res>
    implements $CrawlChildJobCopyWith<$Res> {
  _$CrawlChildJobCopyWithImpl(this._self, this._then);

  final CrawlChildJob _self;
  final $Res Function(CrawlChildJob) _then;

/// Create a copy of CrawlChildJob
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? filename = null,Object? id = null,Object? status = null,Object? bodyBytes = freezed,Object? processingTimeMs = freezed,Object? result = freezed,Object? sourceUrl = freezed,}) {
  return _then(_self.copyWith(
filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,bodyBytes: freezed == bodyBytes ? _self.bodyBytes : bodyBytes // ignore: cast_nullable_to_non_nullable
as int?,processingTimeMs: freezed == processingTimeMs ? _self.processingTimeMs : processingTimeMs // ignore: cast_nullable_to_non_nullable
as int?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as ExtractionResult?,sourceUrl: freezed == sourceUrl ? _self.sourceUrl : sourceUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CrawlChildJob
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExtractionResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $ExtractionResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// Adds pattern-matching-related methods to [CrawlChildJob].
extension CrawlChildJobPatterns on CrawlChildJob {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CrawlChildJob value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CrawlChildJob() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CrawlChildJob value)  $default,){
final _that = this;
switch (_that) {
case _CrawlChildJob():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CrawlChildJob value)?  $default,){
final _that = this;
switch (_that) {
case _CrawlChildJob() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String filename,  String id,  String status, @JsonKey(name: 'body_bytes')  int? bodyBytes, @JsonKey(name: 'processing_time_ms')  int? processingTimeMs,  ExtractionResult? result, @JsonKey(name: 'source_url')  String? sourceUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CrawlChildJob() when $default != null:
return $default(_that.filename,_that.id,_that.status,_that.bodyBytes,_that.processingTimeMs,_that.result,_that.sourceUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String filename,  String id,  String status, @JsonKey(name: 'body_bytes')  int? bodyBytes, @JsonKey(name: 'processing_time_ms')  int? processingTimeMs,  ExtractionResult? result, @JsonKey(name: 'source_url')  String? sourceUrl)  $default,) {final _that = this;
switch (_that) {
case _CrawlChildJob():
return $default(_that.filename,_that.id,_that.status,_that.bodyBytes,_that.processingTimeMs,_that.result,_that.sourceUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String filename,  String id,  String status, @JsonKey(name: 'body_bytes')  int? bodyBytes, @JsonKey(name: 'processing_time_ms')  int? processingTimeMs,  ExtractionResult? result, @JsonKey(name: 'source_url')  String? sourceUrl)?  $default,) {final _that = this;
switch (_that) {
case _CrawlChildJob() when $default != null:
return $default(_that.filename,_that.id,_that.status,_that.bodyBytes,_that.processingTimeMs,_that.result,_that.sourceUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CrawlChildJob implements CrawlChildJob {
  const _CrawlChildJob({required this.filename, required this.id, required this.status, @JsonKey(name: 'body_bytes') this.bodyBytes, @JsonKey(name: 'processing_time_ms') this.processingTimeMs, this.result, @JsonKey(name: 'source_url') this.sourceUrl});
  factory _CrawlChildJob.fromJson(Map<String, dynamic> json) => _$CrawlChildJobFromJson(json);

/// Filename
@override final  String filename;
/// Job ID (queryable via GET /v1/jobs/{id})
@override final  String id;
/// Job status
@override final  String status;
/// Raw body size in bytes of the source document fed to extraction.
/// For HTML pages this is the rendered HTML length; for binary.
/// documents it is the downloaded file size. Lets callers detect.
/// suspiciously small responses (e.g. WAF challenge pages captured.
/// as the "document" — typically 5–30 KB).
@override@JsonKey(name: 'body_bytes') final  int? bodyBytes;
/// Processing time in ms (when completed)
@override@JsonKey(name: 'processing_time_ms') final  int? processingTimeMs;
/// Extraction result (when completed)
@override final  ExtractionResult? result;
/// Source URL where this document was found
@override@JsonKey(name: 'source_url') final  String? sourceUrl;

/// Create a copy of CrawlChildJob
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CrawlChildJobCopyWith<_CrawlChildJob> get copyWith => __$CrawlChildJobCopyWithImpl<_CrawlChildJob>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CrawlChildJobToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CrawlChildJob&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.bodyBytes, bodyBytes) || other.bodyBytes == bodyBytes)&&(identical(other.processingTimeMs, processingTimeMs) || other.processingTimeMs == processingTimeMs)&&(identical(other.result, result) || other.result == result)&&(identical(other.sourceUrl, sourceUrl) || other.sourceUrl == sourceUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,filename,id,status,bodyBytes,processingTimeMs,result,sourceUrl);

@override
String toString() {
  return 'CrawlChildJob(filename: $filename, id: $id, status: $status, bodyBytes: $bodyBytes, processingTimeMs: $processingTimeMs, result: $result, sourceUrl: $sourceUrl)';
}


}

/// @nodoc
abstract mixin class _$CrawlChildJobCopyWith<$Res> implements $CrawlChildJobCopyWith<$Res> {
  factory _$CrawlChildJobCopyWith(_CrawlChildJob value, $Res Function(_CrawlChildJob) _then) = __$CrawlChildJobCopyWithImpl;
@override @useResult
$Res call({
 String filename, String id, String status,@JsonKey(name: 'body_bytes') int? bodyBytes,@JsonKey(name: 'processing_time_ms') int? processingTimeMs, ExtractionResult? result,@JsonKey(name: 'source_url') String? sourceUrl
});


@override $ExtractionResultCopyWith<$Res>? get result;

}
/// @nodoc
class __$CrawlChildJobCopyWithImpl<$Res>
    implements _$CrawlChildJobCopyWith<$Res> {
  __$CrawlChildJobCopyWithImpl(this._self, this._then);

  final _CrawlChildJob _self;
  final $Res Function(_CrawlChildJob) _then;

/// Create a copy of CrawlChildJob
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? filename = null,Object? id = null,Object? status = null,Object? bodyBytes = freezed,Object? processingTimeMs = freezed,Object? result = freezed,Object? sourceUrl = freezed,}) {
  return _then(_CrawlChildJob(
filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,bodyBytes: freezed == bodyBytes ? _self.bodyBytes : bodyBytes // ignore: cast_nullable_to_non_nullable
as int?,processingTimeMs: freezed == processingTimeMs ? _self.processingTimeMs : processingTimeMs // ignore: cast_nullable_to_non_nullable
as int?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as ExtractionResult?,sourceUrl: freezed == sourceUrl ? _self.sourceUrl : sourceUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CrawlChildJob
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExtractionResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $ExtractionResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

// dart format on
