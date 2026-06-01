// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_version_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DocumentVersionEntry {

/// Number of billable pages.
@JsonKey(name: 'billable_pages') int get billablePages;/// SHA-256 hash of the extracted content.
@JsonKey(name: 'content_hash') String get contentHash;/// When the job was created.
@JsonKey(name: 'created_at') String get createdAt;/// File size in bytes.
@JsonKey(name: 'file_size_bytes') int get fileSizeBytes;/// Original filename.
 String get filename;/// Job ID for this version.
@JsonKey(name: 'job_id') String get jobId;/// MIME type of the uploaded file.
@JsonKey(name: 'mime_type') String get mimeType;/// Number of pages extracted.
@JsonKey(name: 'pages_extracted') int get pagesExtracted;/// Job status.
 String get status;/// Version sequence number (incrementing per document).
@JsonKey(name: 'version_sequence') int get versionSequence;/// When processing completed (only set for completed/failed jobs).
@JsonKey(name: 'processing_completed_at') String? get processingCompletedAt;
/// Create a copy of DocumentVersionEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentVersionEntryCopyWith<DocumentVersionEntry> get copyWith => _$DocumentVersionEntryCopyWithImpl<DocumentVersionEntry>(this as DocumentVersionEntry, _$identity);

  /// Serializes this DocumentVersionEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentVersionEntry&&(identical(other.billablePages, billablePages) || other.billablePages == billablePages)&&(identical(other.contentHash, contentHash) || other.contentHash == contentHash)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.fileSizeBytes, fileSizeBytes) || other.fileSizeBytes == fileSizeBytes)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.pagesExtracted, pagesExtracted) || other.pagesExtracted == pagesExtracted)&&(identical(other.status, status) || other.status == status)&&(identical(other.versionSequence, versionSequence) || other.versionSequence == versionSequence)&&(identical(other.processingCompletedAt, processingCompletedAt) || other.processingCompletedAt == processingCompletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,billablePages,contentHash,createdAt,fileSizeBytes,filename,jobId,mimeType,pagesExtracted,status,versionSequence,processingCompletedAt);

@override
String toString() {
  return 'DocumentVersionEntry(billablePages: $billablePages, contentHash: $contentHash, createdAt: $createdAt, fileSizeBytes: $fileSizeBytes, filename: $filename, jobId: $jobId, mimeType: $mimeType, pagesExtracted: $pagesExtracted, status: $status, versionSequence: $versionSequence, processingCompletedAt: $processingCompletedAt)';
}


}

/// @nodoc
abstract mixin class $DocumentVersionEntryCopyWith<$Res>  {
  factory $DocumentVersionEntryCopyWith(DocumentVersionEntry value, $Res Function(DocumentVersionEntry) _then) = _$DocumentVersionEntryCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'billable_pages') int billablePages,@JsonKey(name: 'content_hash') String contentHash,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'file_size_bytes') int fileSizeBytes, String filename,@JsonKey(name: 'job_id') String jobId,@JsonKey(name: 'mime_type') String mimeType,@JsonKey(name: 'pages_extracted') int pagesExtracted, String status,@JsonKey(name: 'version_sequence') int versionSequence,@JsonKey(name: 'processing_completed_at') String? processingCompletedAt
});




}
/// @nodoc
class _$DocumentVersionEntryCopyWithImpl<$Res>
    implements $DocumentVersionEntryCopyWith<$Res> {
  _$DocumentVersionEntryCopyWithImpl(this._self, this._then);

  final DocumentVersionEntry _self;
  final $Res Function(DocumentVersionEntry) _then;

/// Create a copy of DocumentVersionEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? billablePages = null,Object? contentHash = null,Object? createdAt = null,Object? fileSizeBytes = null,Object? filename = null,Object? jobId = null,Object? mimeType = null,Object? pagesExtracted = null,Object? status = null,Object? versionSequence = null,Object? processingCompletedAt = freezed,}) {
  return _then(_self.copyWith(
billablePages: null == billablePages ? _self.billablePages : billablePages // ignore: cast_nullable_to_non_nullable
as int,contentHash: null == contentHash ? _self.contentHash : contentHash // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,fileSizeBytes: null == fileSizeBytes ? _self.fileSizeBytes : fileSizeBytes // ignore: cast_nullable_to_non_nullable
as int,filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,pagesExtracted: null == pagesExtracted ? _self.pagesExtracted : pagesExtracted // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,versionSequence: null == versionSequence ? _self.versionSequence : versionSequence // ignore: cast_nullable_to_non_nullable
as int,processingCompletedAt: freezed == processingCompletedAt ? _self.processingCompletedAt : processingCompletedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DocumentVersionEntry].
extension DocumentVersionEntryPatterns on DocumentVersionEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DocumentVersionEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DocumentVersionEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DocumentVersionEntry value)  $default,){
final _that = this;
switch (_that) {
case _DocumentVersionEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DocumentVersionEntry value)?  $default,){
final _that = this;
switch (_that) {
case _DocumentVersionEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'billable_pages')  int billablePages, @JsonKey(name: 'content_hash')  String contentHash, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'file_size_bytes')  int fileSizeBytes,  String filename, @JsonKey(name: 'job_id')  String jobId, @JsonKey(name: 'mime_type')  String mimeType, @JsonKey(name: 'pages_extracted')  int pagesExtracted,  String status, @JsonKey(name: 'version_sequence')  int versionSequence, @JsonKey(name: 'processing_completed_at')  String? processingCompletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DocumentVersionEntry() when $default != null:
return $default(_that.billablePages,_that.contentHash,_that.createdAt,_that.fileSizeBytes,_that.filename,_that.jobId,_that.mimeType,_that.pagesExtracted,_that.status,_that.versionSequence,_that.processingCompletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'billable_pages')  int billablePages, @JsonKey(name: 'content_hash')  String contentHash, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'file_size_bytes')  int fileSizeBytes,  String filename, @JsonKey(name: 'job_id')  String jobId, @JsonKey(name: 'mime_type')  String mimeType, @JsonKey(name: 'pages_extracted')  int pagesExtracted,  String status, @JsonKey(name: 'version_sequence')  int versionSequence, @JsonKey(name: 'processing_completed_at')  String? processingCompletedAt)  $default,) {final _that = this;
switch (_that) {
case _DocumentVersionEntry():
return $default(_that.billablePages,_that.contentHash,_that.createdAt,_that.fileSizeBytes,_that.filename,_that.jobId,_that.mimeType,_that.pagesExtracted,_that.status,_that.versionSequence,_that.processingCompletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'billable_pages')  int billablePages, @JsonKey(name: 'content_hash')  String contentHash, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'file_size_bytes')  int fileSizeBytes,  String filename, @JsonKey(name: 'job_id')  String jobId, @JsonKey(name: 'mime_type')  String mimeType, @JsonKey(name: 'pages_extracted')  int pagesExtracted,  String status, @JsonKey(name: 'version_sequence')  int versionSequence, @JsonKey(name: 'processing_completed_at')  String? processingCompletedAt)?  $default,) {final _that = this;
switch (_that) {
case _DocumentVersionEntry() when $default != null:
return $default(_that.billablePages,_that.contentHash,_that.createdAt,_that.fileSizeBytes,_that.filename,_that.jobId,_that.mimeType,_that.pagesExtracted,_that.status,_that.versionSequence,_that.processingCompletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DocumentVersionEntry implements DocumentVersionEntry {
  const _DocumentVersionEntry({@JsonKey(name: 'billable_pages') required this.billablePages, @JsonKey(name: 'content_hash') required this.contentHash, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'file_size_bytes') required this.fileSizeBytes, required this.filename, @JsonKey(name: 'job_id') required this.jobId, @JsonKey(name: 'mime_type') required this.mimeType, @JsonKey(name: 'pages_extracted') required this.pagesExtracted, required this.status, @JsonKey(name: 'version_sequence') required this.versionSequence, @JsonKey(name: 'processing_completed_at') this.processingCompletedAt});
  factory _DocumentVersionEntry.fromJson(Map<String, dynamic> json) => _$DocumentVersionEntryFromJson(json);

/// Number of billable pages.
@override@JsonKey(name: 'billable_pages') final  int billablePages;
/// SHA-256 hash of the extracted content.
@override@JsonKey(name: 'content_hash') final  String contentHash;
/// When the job was created.
@override@JsonKey(name: 'created_at') final  String createdAt;
/// File size in bytes.
@override@JsonKey(name: 'file_size_bytes') final  int fileSizeBytes;
/// Original filename.
@override final  String filename;
/// Job ID for this version.
@override@JsonKey(name: 'job_id') final  String jobId;
/// MIME type of the uploaded file.
@override@JsonKey(name: 'mime_type') final  String mimeType;
/// Number of pages extracted.
@override@JsonKey(name: 'pages_extracted') final  int pagesExtracted;
/// Job status.
@override final  String status;
/// Version sequence number (incrementing per document).
@override@JsonKey(name: 'version_sequence') final  int versionSequence;
/// When processing completed (only set for completed/failed jobs).
@override@JsonKey(name: 'processing_completed_at') final  String? processingCompletedAt;

/// Create a copy of DocumentVersionEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentVersionEntryCopyWith<_DocumentVersionEntry> get copyWith => __$DocumentVersionEntryCopyWithImpl<_DocumentVersionEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentVersionEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentVersionEntry&&(identical(other.billablePages, billablePages) || other.billablePages == billablePages)&&(identical(other.contentHash, contentHash) || other.contentHash == contentHash)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.fileSizeBytes, fileSizeBytes) || other.fileSizeBytes == fileSizeBytes)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.pagesExtracted, pagesExtracted) || other.pagesExtracted == pagesExtracted)&&(identical(other.status, status) || other.status == status)&&(identical(other.versionSequence, versionSequence) || other.versionSequence == versionSequence)&&(identical(other.processingCompletedAt, processingCompletedAt) || other.processingCompletedAt == processingCompletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,billablePages,contentHash,createdAt,fileSizeBytes,filename,jobId,mimeType,pagesExtracted,status,versionSequence,processingCompletedAt);

@override
String toString() {
  return 'DocumentVersionEntry(billablePages: $billablePages, contentHash: $contentHash, createdAt: $createdAt, fileSizeBytes: $fileSizeBytes, filename: $filename, jobId: $jobId, mimeType: $mimeType, pagesExtracted: $pagesExtracted, status: $status, versionSequence: $versionSequence, processingCompletedAt: $processingCompletedAt)';
}


}

/// @nodoc
abstract mixin class _$DocumentVersionEntryCopyWith<$Res> implements $DocumentVersionEntryCopyWith<$Res> {
  factory _$DocumentVersionEntryCopyWith(_DocumentVersionEntry value, $Res Function(_DocumentVersionEntry) _then) = __$DocumentVersionEntryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'billable_pages') int billablePages,@JsonKey(name: 'content_hash') String contentHash,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'file_size_bytes') int fileSizeBytes, String filename,@JsonKey(name: 'job_id') String jobId,@JsonKey(name: 'mime_type') String mimeType,@JsonKey(name: 'pages_extracted') int pagesExtracted, String status,@JsonKey(name: 'version_sequence') int versionSequence,@JsonKey(name: 'processing_completed_at') String? processingCompletedAt
});




}
/// @nodoc
class __$DocumentVersionEntryCopyWithImpl<$Res>
    implements _$DocumentVersionEntryCopyWith<$Res> {
  __$DocumentVersionEntryCopyWithImpl(this._self, this._then);

  final _DocumentVersionEntry _self;
  final $Res Function(_DocumentVersionEntry) _then;

/// Create a copy of DocumentVersionEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? billablePages = null,Object? contentHash = null,Object? createdAt = null,Object? fileSizeBytes = null,Object? filename = null,Object? jobId = null,Object? mimeType = null,Object? pagesExtracted = null,Object? status = null,Object? versionSequence = null,Object? processingCompletedAt = freezed,}) {
  return _then(_DocumentVersionEntry(
billablePages: null == billablePages ? _self.billablePages : billablePages // ignore: cast_nullable_to_non_nullable
as int,contentHash: null == contentHash ? _self.contentHash : contentHash // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,fileSizeBytes: null == fileSizeBytes ? _self.fileSizeBytes : fileSizeBytes // ignore: cast_nullable_to_non_nullable
as int,filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,pagesExtracted: null == pagesExtracted ? _self.pagesExtracted : pagesExtracted // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,versionSequence: null == versionSequence ? _self.versionSequence : versionSequence // ignore: cast_nullable_to_non_nullable
as int,processingCompletedAt: freezed == processingCompletedAt ? _self.processingCompletedAt : processingCompletedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
