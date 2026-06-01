// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_lookup_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JobLookupResponse {

 Object get value;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobLookupResponse&&const DeepCollectionEquality().equals(other.value, value));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'JobLookupResponse(value: $value)';
}


}

/// @nodoc
class $JobLookupResponseCopyWith<$Res>  {
$JobLookupResponseCopyWith(JobLookupResponse _, $Res Function(JobLookupResponse) __);
}


/// Adds pattern-matching-related methods to [JobLookupResponse].
extension JobLookupResponsePatterns on JobLookupResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( JobLookupResponseExtraction value)?  extraction,TResult Function( JobLookupResponseCrawl value)?  crawl,required TResult orElse(),}){
final _that = this;
switch (_that) {
case JobLookupResponseExtraction() when extraction != null:
return extraction(_that);case JobLookupResponseCrawl() when crawl != null:
return crawl(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( JobLookupResponseExtraction value)  extraction,required TResult Function( JobLookupResponseCrawl value)  crawl,}){
final _that = this;
switch (_that) {
case JobLookupResponseExtraction():
return extraction(_that);case JobLookupResponseCrawl():
return crawl(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( JobLookupResponseExtraction value)?  extraction,TResult? Function( JobLookupResponseCrawl value)?  crawl,}){
final _that = this;
switch (_that) {
case JobLookupResponseExtraction() when extraction != null:
return extraction(_that);case JobLookupResponseCrawl() when crawl != null:
return crawl(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( JobResponse value)?  extraction,TResult Function( CrawlJobResponse value)?  crawl,required TResult orElse(),}) {final _that = this;
switch (_that) {
case JobLookupResponseExtraction() when extraction != null:
return extraction(_that.value);case JobLookupResponseCrawl() when crawl != null:
return crawl(_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( JobResponse value)  extraction,required TResult Function( CrawlJobResponse value)  crawl,}) {final _that = this;
switch (_that) {
case JobLookupResponseExtraction():
return extraction(_that.value);case JobLookupResponseCrawl():
return crawl(_that.value);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( JobResponse value)?  extraction,TResult? Function( CrawlJobResponse value)?  crawl,}) {final _that = this;
switch (_that) {
case JobLookupResponseExtraction() when extraction != null:
return extraction(_that.value);case JobLookupResponseCrawl() when crawl != null:
return crawl(_that.value);case _:
  return null;

}
}

}

/// @nodoc


class JobLookupResponseExtraction extends JobLookupResponse {
  const JobLookupResponseExtraction(this.value): super._();
  

@override final  JobResponse value;

/// Create a copy of JobLookupResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobLookupResponseExtractionCopyWith<JobLookupResponseExtraction> get copyWith => _$JobLookupResponseExtractionCopyWithImpl<JobLookupResponseExtraction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobLookupResponseExtraction&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'JobLookupResponse.extraction(value: $value)';
}


}

/// @nodoc
abstract mixin class $JobLookupResponseExtractionCopyWith<$Res> implements $JobLookupResponseCopyWith<$Res> {
  factory $JobLookupResponseExtractionCopyWith(JobLookupResponseExtraction value, $Res Function(JobLookupResponseExtraction) _then) = _$JobLookupResponseExtractionCopyWithImpl;
@useResult
$Res call({
 JobResponse value
});


$JobResponseCopyWith<$Res> get value;

}
/// @nodoc
class _$JobLookupResponseExtractionCopyWithImpl<$Res>
    implements $JobLookupResponseExtractionCopyWith<$Res> {
  _$JobLookupResponseExtractionCopyWithImpl(this._self, this._then);

  final JobLookupResponseExtraction _self;
  final $Res Function(JobLookupResponseExtraction) _then;

/// Create a copy of JobLookupResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(JobLookupResponseExtraction(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as JobResponse,
  ));
}

/// Create a copy of JobLookupResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobResponseCopyWith<$Res> get value {
  
  return $JobResponseCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}
}

/// @nodoc


class JobLookupResponseCrawl extends JobLookupResponse {
  const JobLookupResponseCrawl(this.value): super._();
  

@override final  CrawlJobResponse value;

/// Create a copy of JobLookupResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobLookupResponseCrawlCopyWith<JobLookupResponseCrawl> get copyWith => _$JobLookupResponseCrawlCopyWithImpl<JobLookupResponseCrawl>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobLookupResponseCrawl&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'JobLookupResponse.crawl(value: $value)';
}


}

/// @nodoc
abstract mixin class $JobLookupResponseCrawlCopyWith<$Res> implements $JobLookupResponseCopyWith<$Res> {
  factory $JobLookupResponseCrawlCopyWith(JobLookupResponseCrawl value, $Res Function(JobLookupResponseCrawl) _then) = _$JobLookupResponseCrawlCopyWithImpl;
@useResult
$Res call({
 CrawlJobResponse value
});


$CrawlJobResponseCopyWith<$Res> get value;

}
/// @nodoc
class _$JobLookupResponseCrawlCopyWithImpl<$Res>
    implements $JobLookupResponseCrawlCopyWith<$Res> {
  _$JobLookupResponseCrawlCopyWithImpl(this._self, this._then);

  final JobLookupResponseCrawl _self;
  final $Res Function(JobLookupResponseCrawl) _then;

/// Create a copy of JobLookupResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(JobLookupResponseCrawl(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as CrawlJobResponse,
  ));
}

/// Create a copy of JobLookupResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CrawlJobResponseCopyWith<$Res> get value {
  
  return $CrawlJobResponseCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}
}

// dart format on
