// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crawled_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CrawledPage {

/// Fetch timestamp (RFC3339)
@JsonKey(name: 'fetched_at') DateTime get fetchedAt;/// Fetch status: "completed" | "failed"
 String get status;/// Source URL
 String get url;/// Presigned URL for downloading the raw content
@JsonKey(name: 'content_url') String? get contentUrl;/// Error message (when status=failed)
 String? get error;/// MIME type
@JsonKey(name: 'mime_type') String? get mimeType;/// Size in bytes
@JsonKey(name: 'size_bytes') int? get sizeBytes;
/// Create a copy of CrawledPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrawledPageCopyWith<CrawledPage> get copyWith => _$CrawledPageCopyWithImpl<CrawledPage>(this as CrawledPage, _$identity);

  /// Serializes this CrawledPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrawledPage&&(identical(other.fetchedAt, fetchedAt) || other.fetchedAt == fetchedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.url, url) || other.url == url)&&(identical(other.contentUrl, contentUrl) || other.contentUrl == contentUrl)&&(identical(other.error, error) || other.error == error)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fetchedAt,status,url,contentUrl,error,mimeType,sizeBytes);

@override
String toString() {
  return 'CrawledPage(fetchedAt: $fetchedAt, status: $status, url: $url, contentUrl: $contentUrl, error: $error, mimeType: $mimeType, sizeBytes: $sizeBytes)';
}


}

/// @nodoc
abstract mixin class $CrawledPageCopyWith<$Res>  {
  factory $CrawledPageCopyWith(CrawledPage value, $Res Function(CrawledPage) _then) = _$CrawledPageCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'fetched_at') DateTime fetchedAt, String status, String url,@JsonKey(name: 'content_url') String? contentUrl, String? error,@JsonKey(name: 'mime_type') String? mimeType,@JsonKey(name: 'size_bytes') int? sizeBytes
});




}
/// @nodoc
class _$CrawledPageCopyWithImpl<$Res>
    implements $CrawledPageCopyWith<$Res> {
  _$CrawledPageCopyWithImpl(this._self, this._then);

  final CrawledPage _self;
  final $Res Function(CrawledPage) _then;

/// Create a copy of CrawledPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fetchedAt = null,Object? status = null,Object? url = null,Object? contentUrl = freezed,Object? error = freezed,Object? mimeType = freezed,Object? sizeBytes = freezed,}) {
  return _then(_self.copyWith(
fetchedAt: null == fetchedAt ? _self.fetchedAt : fetchedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,contentUrl: freezed == contentUrl ? _self.contentUrl : contentUrl // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,mimeType: freezed == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String?,sizeBytes: freezed == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CrawledPage].
extension CrawledPagePatterns on CrawledPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CrawledPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CrawledPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CrawledPage value)  $default,){
final _that = this;
switch (_that) {
case _CrawledPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CrawledPage value)?  $default,){
final _that = this;
switch (_that) {
case _CrawledPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'fetched_at')  DateTime fetchedAt,  String status,  String url, @JsonKey(name: 'content_url')  String? contentUrl,  String? error, @JsonKey(name: 'mime_type')  String? mimeType, @JsonKey(name: 'size_bytes')  int? sizeBytes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CrawledPage() when $default != null:
return $default(_that.fetchedAt,_that.status,_that.url,_that.contentUrl,_that.error,_that.mimeType,_that.sizeBytes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'fetched_at')  DateTime fetchedAt,  String status,  String url, @JsonKey(name: 'content_url')  String? contentUrl,  String? error, @JsonKey(name: 'mime_type')  String? mimeType, @JsonKey(name: 'size_bytes')  int? sizeBytes)  $default,) {final _that = this;
switch (_that) {
case _CrawledPage():
return $default(_that.fetchedAt,_that.status,_that.url,_that.contentUrl,_that.error,_that.mimeType,_that.sizeBytes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'fetched_at')  DateTime fetchedAt,  String status,  String url, @JsonKey(name: 'content_url')  String? contentUrl,  String? error, @JsonKey(name: 'mime_type')  String? mimeType, @JsonKey(name: 'size_bytes')  int? sizeBytes)?  $default,) {final _that = this;
switch (_that) {
case _CrawledPage() when $default != null:
return $default(_that.fetchedAt,_that.status,_that.url,_that.contentUrl,_that.error,_that.mimeType,_that.sizeBytes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CrawledPage implements CrawledPage {
  const _CrawledPage({@JsonKey(name: 'fetched_at') required this.fetchedAt, required this.status, required this.url, @JsonKey(name: 'content_url') this.contentUrl, this.error, @JsonKey(name: 'mime_type') this.mimeType, @JsonKey(name: 'size_bytes') this.sizeBytes});
  factory _CrawledPage.fromJson(Map<String, dynamic> json) => _$CrawledPageFromJson(json);

/// Fetch timestamp (RFC3339)
@override@JsonKey(name: 'fetched_at') final  DateTime fetchedAt;
/// Fetch status: "completed" | "failed"
@override final  String status;
/// Source URL
@override final  String url;
/// Presigned URL for downloading the raw content
@override@JsonKey(name: 'content_url') final  String? contentUrl;
/// Error message (when status=failed)
@override final  String? error;
/// MIME type
@override@JsonKey(name: 'mime_type') final  String? mimeType;
/// Size in bytes
@override@JsonKey(name: 'size_bytes') final  int? sizeBytes;

/// Create a copy of CrawledPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CrawledPageCopyWith<_CrawledPage> get copyWith => __$CrawledPageCopyWithImpl<_CrawledPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CrawledPageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CrawledPage&&(identical(other.fetchedAt, fetchedAt) || other.fetchedAt == fetchedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.url, url) || other.url == url)&&(identical(other.contentUrl, contentUrl) || other.contentUrl == contentUrl)&&(identical(other.error, error) || other.error == error)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fetchedAt,status,url,contentUrl,error,mimeType,sizeBytes);

@override
String toString() {
  return 'CrawledPage(fetchedAt: $fetchedAt, status: $status, url: $url, contentUrl: $contentUrl, error: $error, mimeType: $mimeType, sizeBytes: $sizeBytes)';
}


}

/// @nodoc
abstract mixin class _$CrawledPageCopyWith<$Res> implements $CrawledPageCopyWith<$Res> {
  factory _$CrawledPageCopyWith(_CrawledPage value, $Res Function(_CrawledPage) _then) = __$CrawledPageCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'fetched_at') DateTime fetchedAt, String status, String url,@JsonKey(name: 'content_url') String? contentUrl, String? error,@JsonKey(name: 'mime_type') String? mimeType,@JsonKey(name: 'size_bytes') int? sizeBytes
});




}
/// @nodoc
class __$CrawledPageCopyWithImpl<$Res>
    implements _$CrawledPageCopyWith<$Res> {
  __$CrawledPageCopyWithImpl(this._self, this._then);

  final _CrawledPage _self;
  final $Res Function(_CrawledPage) _then;

/// Create a copy of CrawledPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fetchedAt = null,Object? status = null,Object? url = null,Object? contentUrl = freezed,Object? error = freezed,Object? mimeType = freezed,Object? sizeBytes = freezed,}) {
  return _then(_CrawledPage(
fetchedAt: null == fetchedAt ? _self.fetchedAt : fetchedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,contentUrl: freezed == contentUrl ? _self.contentUrl : contentUrl // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,mimeType: freezed == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String?,sizeBytes: freezed == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
