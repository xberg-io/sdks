// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crawl_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CrawlProgress {

@JsonKey(name: 'documents_discovered') int get documentsDiscovered;@JsonKey(name: 'documents_extracted') int get documentsExtracted;@JsonKey(name: 'documents_failed') int get documentsFailed;@JsonKey(name: 'pages_crawled') int get pagesCrawled;
/// Create a copy of CrawlProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrawlProgressCopyWith<CrawlProgress> get copyWith => _$CrawlProgressCopyWithImpl<CrawlProgress>(this as CrawlProgress, _$identity);

  /// Serializes this CrawlProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrawlProgress&&(identical(other.documentsDiscovered, documentsDiscovered) || other.documentsDiscovered == documentsDiscovered)&&(identical(other.documentsExtracted, documentsExtracted) || other.documentsExtracted == documentsExtracted)&&(identical(other.documentsFailed, documentsFailed) || other.documentsFailed == documentsFailed)&&(identical(other.pagesCrawled, pagesCrawled) || other.pagesCrawled == pagesCrawled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,documentsDiscovered,documentsExtracted,documentsFailed,pagesCrawled);

@override
String toString() {
  return 'CrawlProgress(documentsDiscovered: $documentsDiscovered, documentsExtracted: $documentsExtracted, documentsFailed: $documentsFailed, pagesCrawled: $pagesCrawled)';
}


}

/// @nodoc
abstract mixin class $CrawlProgressCopyWith<$Res>  {
  factory $CrawlProgressCopyWith(CrawlProgress value, $Res Function(CrawlProgress) _then) = _$CrawlProgressCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'documents_discovered') int documentsDiscovered,@JsonKey(name: 'documents_extracted') int documentsExtracted,@JsonKey(name: 'documents_failed') int documentsFailed,@JsonKey(name: 'pages_crawled') int pagesCrawled
});




}
/// @nodoc
class _$CrawlProgressCopyWithImpl<$Res>
    implements $CrawlProgressCopyWith<$Res> {
  _$CrawlProgressCopyWithImpl(this._self, this._then);

  final CrawlProgress _self;
  final $Res Function(CrawlProgress) _then;

/// Create a copy of CrawlProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? documentsDiscovered = null,Object? documentsExtracted = null,Object? documentsFailed = null,Object? pagesCrawled = null,}) {
  return _then(_self.copyWith(
documentsDiscovered: null == documentsDiscovered ? _self.documentsDiscovered : documentsDiscovered // ignore: cast_nullable_to_non_nullable
as int,documentsExtracted: null == documentsExtracted ? _self.documentsExtracted : documentsExtracted // ignore: cast_nullable_to_non_nullable
as int,documentsFailed: null == documentsFailed ? _self.documentsFailed : documentsFailed // ignore: cast_nullable_to_non_nullable
as int,pagesCrawled: null == pagesCrawled ? _self.pagesCrawled : pagesCrawled // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CrawlProgress].
extension CrawlProgressPatterns on CrawlProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CrawlProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CrawlProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CrawlProgress value)  $default,){
final _that = this;
switch (_that) {
case _CrawlProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CrawlProgress value)?  $default,){
final _that = this;
switch (_that) {
case _CrawlProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'documents_discovered')  int documentsDiscovered, @JsonKey(name: 'documents_extracted')  int documentsExtracted, @JsonKey(name: 'documents_failed')  int documentsFailed, @JsonKey(name: 'pages_crawled')  int pagesCrawled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CrawlProgress() when $default != null:
return $default(_that.documentsDiscovered,_that.documentsExtracted,_that.documentsFailed,_that.pagesCrawled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'documents_discovered')  int documentsDiscovered, @JsonKey(name: 'documents_extracted')  int documentsExtracted, @JsonKey(name: 'documents_failed')  int documentsFailed, @JsonKey(name: 'pages_crawled')  int pagesCrawled)  $default,) {final _that = this;
switch (_that) {
case _CrawlProgress():
return $default(_that.documentsDiscovered,_that.documentsExtracted,_that.documentsFailed,_that.pagesCrawled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'documents_discovered')  int documentsDiscovered, @JsonKey(name: 'documents_extracted')  int documentsExtracted, @JsonKey(name: 'documents_failed')  int documentsFailed, @JsonKey(name: 'pages_crawled')  int pagesCrawled)?  $default,) {final _that = this;
switch (_that) {
case _CrawlProgress() when $default != null:
return $default(_that.documentsDiscovered,_that.documentsExtracted,_that.documentsFailed,_that.pagesCrawled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CrawlProgress implements CrawlProgress {
  const _CrawlProgress({@JsonKey(name: 'documents_discovered') required this.documentsDiscovered, @JsonKey(name: 'documents_extracted') required this.documentsExtracted, @JsonKey(name: 'documents_failed') required this.documentsFailed, @JsonKey(name: 'pages_crawled') required this.pagesCrawled});
  factory _CrawlProgress.fromJson(Map<String, dynamic> json) => _$CrawlProgressFromJson(json);

@override@JsonKey(name: 'documents_discovered') final  int documentsDiscovered;
@override@JsonKey(name: 'documents_extracted') final  int documentsExtracted;
@override@JsonKey(name: 'documents_failed') final  int documentsFailed;
@override@JsonKey(name: 'pages_crawled') final  int pagesCrawled;

/// Create a copy of CrawlProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CrawlProgressCopyWith<_CrawlProgress> get copyWith => __$CrawlProgressCopyWithImpl<_CrawlProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CrawlProgressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CrawlProgress&&(identical(other.documentsDiscovered, documentsDiscovered) || other.documentsDiscovered == documentsDiscovered)&&(identical(other.documentsExtracted, documentsExtracted) || other.documentsExtracted == documentsExtracted)&&(identical(other.documentsFailed, documentsFailed) || other.documentsFailed == documentsFailed)&&(identical(other.pagesCrawled, pagesCrawled) || other.pagesCrawled == pagesCrawled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,documentsDiscovered,documentsExtracted,documentsFailed,pagesCrawled);

@override
String toString() {
  return 'CrawlProgress(documentsDiscovered: $documentsDiscovered, documentsExtracted: $documentsExtracted, documentsFailed: $documentsFailed, pagesCrawled: $pagesCrawled)';
}


}

/// @nodoc
abstract mixin class _$CrawlProgressCopyWith<$Res> implements $CrawlProgressCopyWith<$Res> {
  factory _$CrawlProgressCopyWith(_CrawlProgress value, $Res Function(_CrawlProgress) _then) = __$CrawlProgressCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'documents_discovered') int documentsDiscovered,@JsonKey(name: 'documents_extracted') int documentsExtracted,@JsonKey(name: 'documents_failed') int documentsFailed,@JsonKey(name: 'pages_crawled') int pagesCrawled
});




}
/// @nodoc
class __$CrawlProgressCopyWithImpl<$Res>
    implements _$CrawlProgressCopyWith<$Res> {
  __$CrawlProgressCopyWithImpl(this._self, this._then);

  final _CrawlProgress _self;
  final $Res Function(_CrawlProgress) _then;

/// Create a copy of CrawlProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? documentsDiscovered = null,Object? documentsExtracted = null,Object? documentsFailed = null,Object? pagesCrawled = null,}) {
  return _then(_CrawlProgress(
documentsDiscovered: null == documentsDiscovered ? _self.documentsDiscovered : documentsDiscovered // ignore: cast_nullable_to_non_nullable
as int,documentsExtracted: null == documentsExtracted ? _self.documentsExtracted : documentsExtracted // ignore: cast_nullable_to_non_nullable
as int,documentsFailed: null == documentsFailed ? _self.documentsFailed : documentsFailed // ignore: cast_nullable_to_non_nullable
as int,pagesCrawled: null == pagesCrawled ? _self.pagesCrawled : pagesCrawled // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
