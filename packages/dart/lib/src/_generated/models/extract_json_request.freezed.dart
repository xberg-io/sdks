// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'extract_json_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExtractJsonRequest {

/// Crawl configuration (applies to all URLs, can be overridden per-URL)
@JsonKey(name: 'crawl_config') CrawlConfig? get crawlConfig;/// Documents to process
 List<DocumentInput>? get documents;/// Extraction options (optional)
 ExtractionOptions? get options;/// URLs to crawl and extract documents from
 List<UrlInput>? get urls;/// Webhook configuration for async result delivery (optional)
 WebhookConfig? get webhook;
/// Create a copy of ExtractJsonRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExtractJsonRequestCopyWith<ExtractJsonRequest> get copyWith => _$ExtractJsonRequestCopyWithImpl<ExtractJsonRequest>(this as ExtractJsonRequest, _$identity);

  /// Serializes this ExtractJsonRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExtractJsonRequest&&(identical(other.crawlConfig, crawlConfig) || other.crawlConfig == crawlConfig)&&const DeepCollectionEquality().equals(other.documents, documents)&&(identical(other.options, options) || other.options == options)&&const DeepCollectionEquality().equals(other.urls, urls)&&(identical(other.webhook, webhook) || other.webhook == webhook));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,crawlConfig,const DeepCollectionEquality().hash(documents),options,const DeepCollectionEquality().hash(urls),webhook);

@override
String toString() {
  return 'ExtractJsonRequest(crawlConfig: $crawlConfig, documents: $documents, options: $options, urls: $urls, webhook: $webhook)';
}


}

/// @nodoc
abstract mixin class $ExtractJsonRequestCopyWith<$Res>  {
  factory $ExtractJsonRequestCopyWith(ExtractJsonRequest value, $Res Function(ExtractJsonRequest) _then) = _$ExtractJsonRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'crawl_config') CrawlConfig? crawlConfig, List<DocumentInput>? documents, ExtractionOptions? options, List<UrlInput>? urls, WebhookConfig? webhook
});


$CrawlConfigCopyWith<$Res>? get crawlConfig;$ExtractionOptionsCopyWith<$Res>? get options;$WebhookConfigCopyWith<$Res>? get webhook;

}
/// @nodoc
class _$ExtractJsonRequestCopyWithImpl<$Res>
    implements $ExtractJsonRequestCopyWith<$Res> {
  _$ExtractJsonRequestCopyWithImpl(this._self, this._then);

  final ExtractJsonRequest _self;
  final $Res Function(ExtractJsonRequest) _then;

/// Create a copy of ExtractJsonRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? crawlConfig = freezed,Object? documents = freezed,Object? options = freezed,Object? urls = freezed,Object? webhook = freezed,}) {
  return _then(_self.copyWith(
crawlConfig: freezed == crawlConfig ? _self.crawlConfig : crawlConfig // ignore: cast_nullable_to_non_nullable
as CrawlConfig?,documents: freezed == documents ? _self.documents : documents // ignore: cast_nullable_to_non_nullable
as List<DocumentInput>?,options: freezed == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as ExtractionOptions?,urls: freezed == urls ? _self.urls : urls // ignore: cast_nullable_to_non_nullable
as List<UrlInput>?,webhook: freezed == webhook ? _self.webhook : webhook // ignore: cast_nullable_to_non_nullable
as WebhookConfig?,
  ));
}
/// Create a copy of ExtractJsonRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CrawlConfigCopyWith<$Res>? get crawlConfig {
    if (_self.crawlConfig == null) {
    return null;
  }

  return $CrawlConfigCopyWith<$Res>(_self.crawlConfig!, (value) {
    return _then(_self.copyWith(crawlConfig: value));
  });
}/// Create a copy of ExtractJsonRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExtractionOptionsCopyWith<$Res>? get options {
    if (_self.options == null) {
    return null;
  }

  return $ExtractionOptionsCopyWith<$Res>(_self.options!, (value) {
    return _then(_self.copyWith(options: value));
  });
}/// Create a copy of ExtractJsonRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WebhookConfigCopyWith<$Res>? get webhook {
    if (_self.webhook == null) {
    return null;
  }

  return $WebhookConfigCopyWith<$Res>(_self.webhook!, (value) {
    return _then(_self.copyWith(webhook: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExtractJsonRequest].
extension ExtractJsonRequestPatterns on ExtractJsonRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExtractJsonRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExtractJsonRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExtractJsonRequest value)  $default,){
final _that = this;
switch (_that) {
case _ExtractJsonRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExtractJsonRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ExtractJsonRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'crawl_config')  CrawlConfig? crawlConfig,  List<DocumentInput>? documents,  ExtractionOptions? options,  List<UrlInput>? urls,  WebhookConfig? webhook)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExtractJsonRequest() when $default != null:
return $default(_that.crawlConfig,_that.documents,_that.options,_that.urls,_that.webhook);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'crawl_config')  CrawlConfig? crawlConfig,  List<DocumentInput>? documents,  ExtractionOptions? options,  List<UrlInput>? urls,  WebhookConfig? webhook)  $default,) {final _that = this;
switch (_that) {
case _ExtractJsonRequest():
return $default(_that.crawlConfig,_that.documents,_that.options,_that.urls,_that.webhook);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'crawl_config')  CrawlConfig? crawlConfig,  List<DocumentInput>? documents,  ExtractionOptions? options,  List<UrlInput>? urls,  WebhookConfig? webhook)?  $default,) {final _that = this;
switch (_that) {
case _ExtractJsonRequest() when $default != null:
return $default(_that.crawlConfig,_that.documents,_that.options,_that.urls,_that.webhook);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExtractJsonRequest implements ExtractJsonRequest {
  const _ExtractJsonRequest({@JsonKey(name: 'crawl_config') this.crawlConfig, final  List<DocumentInput>? documents, this.options, final  List<UrlInput>? urls, this.webhook}): _documents = documents,_urls = urls;
  factory _ExtractJsonRequest.fromJson(Map<String, dynamic> json) => _$ExtractJsonRequestFromJson(json);

/// Crawl configuration (applies to all URLs, can be overridden per-URL)
@override@JsonKey(name: 'crawl_config') final  CrawlConfig? crawlConfig;
/// Documents to process
 final  List<DocumentInput>? _documents;
/// Documents to process
@override List<DocumentInput>? get documents {
  final value = _documents;
  if (value == null) return null;
  if (_documents is EqualUnmodifiableListView) return _documents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Extraction options (optional)
@override final  ExtractionOptions? options;
/// URLs to crawl and extract documents from
 final  List<UrlInput>? _urls;
/// URLs to crawl and extract documents from
@override List<UrlInput>? get urls {
  final value = _urls;
  if (value == null) return null;
  if (_urls is EqualUnmodifiableListView) return _urls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Webhook configuration for async result delivery (optional)
@override final  WebhookConfig? webhook;

/// Create a copy of ExtractJsonRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExtractJsonRequestCopyWith<_ExtractJsonRequest> get copyWith => __$ExtractJsonRequestCopyWithImpl<_ExtractJsonRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExtractJsonRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExtractJsonRequest&&(identical(other.crawlConfig, crawlConfig) || other.crawlConfig == crawlConfig)&&const DeepCollectionEquality().equals(other._documents, _documents)&&(identical(other.options, options) || other.options == options)&&const DeepCollectionEquality().equals(other._urls, _urls)&&(identical(other.webhook, webhook) || other.webhook == webhook));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,crawlConfig,const DeepCollectionEquality().hash(_documents),options,const DeepCollectionEquality().hash(_urls),webhook);

@override
String toString() {
  return 'ExtractJsonRequest(crawlConfig: $crawlConfig, documents: $documents, options: $options, urls: $urls, webhook: $webhook)';
}


}

/// @nodoc
abstract mixin class _$ExtractJsonRequestCopyWith<$Res> implements $ExtractJsonRequestCopyWith<$Res> {
  factory _$ExtractJsonRequestCopyWith(_ExtractJsonRequest value, $Res Function(_ExtractJsonRequest) _then) = __$ExtractJsonRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'crawl_config') CrawlConfig? crawlConfig, List<DocumentInput>? documents, ExtractionOptions? options, List<UrlInput>? urls, WebhookConfig? webhook
});


@override $CrawlConfigCopyWith<$Res>? get crawlConfig;@override $ExtractionOptionsCopyWith<$Res>? get options;@override $WebhookConfigCopyWith<$Res>? get webhook;

}
/// @nodoc
class __$ExtractJsonRequestCopyWithImpl<$Res>
    implements _$ExtractJsonRequestCopyWith<$Res> {
  __$ExtractJsonRequestCopyWithImpl(this._self, this._then);

  final _ExtractJsonRequest _self;
  final $Res Function(_ExtractJsonRequest) _then;

/// Create a copy of ExtractJsonRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? crawlConfig = freezed,Object? documents = freezed,Object? options = freezed,Object? urls = freezed,Object? webhook = freezed,}) {
  return _then(_ExtractJsonRequest(
crawlConfig: freezed == crawlConfig ? _self.crawlConfig : crawlConfig // ignore: cast_nullable_to_non_nullable
as CrawlConfig?,documents: freezed == documents ? _self._documents : documents // ignore: cast_nullable_to_non_nullable
as List<DocumentInput>?,options: freezed == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as ExtractionOptions?,urls: freezed == urls ? _self._urls : urls // ignore: cast_nullable_to_non_nullable
as List<UrlInput>?,webhook: freezed == webhook ? _self.webhook : webhook // ignore: cast_nullable_to_non_nullable
as WebhookConfig?,
  ));
}

/// Create a copy of ExtractJsonRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CrawlConfigCopyWith<$Res>? get crawlConfig {
    if (_self.crawlConfig == null) {
    return null;
  }

  return $CrawlConfigCopyWith<$Res>(_self.crawlConfig!, (value) {
    return _then(_self.copyWith(crawlConfig: value));
  });
}/// Create a copy of ExtractJsonRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExtractionOptionsCopyWith<$Res>? get options {
    if (_self.options == null) {
    return null;
  }

  return $ExtractionOptionsCopyWith<$Res>(_self.options!, (value) {
    return _then(_self.copyWith(options: value));
  });
}/// Create a copy of ExtractJsonRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WebhookConfigCopyWith<$Res>? get webhook {
    if (_self.webhook == null) {
    return null;
  }

  return $WebhookConfigCopyWith<$Res>(_self.webhook!, (value) {
    return _then(_self.copyWith(webhook: value));
  });
}
}

// dart format on
