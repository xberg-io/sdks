// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crawl_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CrawlConfig {

/// Allow subdomains of the seed domain (default: true)
@JsonKey(name: 'allow_subdomains') bool? get allowSubdomains;/// MIME types of documents to extract (default: all supported by kreuzberg)
@JsonKey(name: 'allowed_file_types') List<String>? get allowedFileTypes;/// Browser rendering configuration overrides for this request
 BrowserOverrides? get browser;/// Per-request bypass override. When set, applies an external bypass.
/// provider to bypass WAF/antibot on the crawl.
 BypassRequestOverride? get bypass;/// Max depth for URL-following from documents (default: 1, max: 3)
@JsonKey(name: 'document_url_depth') int? get documentUrlDepth;/// Regex patterns — skip URLs matching these
@JsonKey(name: 'exclude_paths') List<String>? get excludePaths;/// Also extract the HTML page content as markdown (default: false)
@JsonKey(name: 'extract_page_content') bool? get extractPageContent;/// Follow URLs discovered inside extracted documents (default: false)
@JsonKey(name: 'follow_document_urls') bool? get followDocumentUrls;/// Regex patterns — only crawl URLs matching these
@JsonKey(name: 'include_paths') List<String>? get includePaths;/// Maximum concurrent requests (default: 10)
@JsonKey(name: 'max_concurrent') int? get maxConcurrent;/// Maximum crawl depth from seed URL (default: 2, max: 5)
@JsonKey(name: 'max_depth') int? get maxDepth;/// Maximum pages to crawl (default: 100, max: 10000)
@JsonKey(name: 'max_pages') int? get maxPages;/// Output mode (default: "extract").
/// - "scrape":  single-page fetch, no recursion, no extraction.
/// - "crawl":   multi-page crawl, no extraction (raw content returned).
/// - "extract": multi-page crawl + extract each discovered document.
@JsonKey(name: 'output_mode') String? get outputMode;/// Per-request proxy override. When set, this proxy is used for this.
/// crawl instead of the worker's process-wide proxy pool.
 ProxyOverride? get proxy;/// Per-request timeout in seconds (default: 30)
@JsonKey(name: 'request_timeout_secs') int? get requestTimeoutSecs;/// Respect robots.txt (default: true)
@JsonKey(name: 'respect_robots_txt') bool? get respectRobotsTxt;/// Stay on the same domain as seed URL (default: true)
@JsonKey(name: 'stay_on_domain') bool? get stayOnDomain;/// Crawl strategy: "bfs" (default), "dfs", "best_first", "adaptive"
 String? get strategy;/// Custom User-Agent string
@JsonKey(name: 'user_agent') String? get userAgent;
/// Create a copy of CrawlConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrawlConfigCopyWith<CrawlConfig> get copyWith => _$CrawlConfigCopyWithImpl<CrawlConfig>(this as CrawlConfig, _$identity);

  /// Serializes this CrawlConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrawlConfig&&(identical(other.allowSubdomains, allowSubdomains) || other.allowSubdomains == allowSubdomains)&&const DeepCollectionEquality().equals(other.allowedFileTypes, allowedFileTypes)&&(identical(other.browser, browser) || other.browser == browser)&&(identical(other.bypass, bypass) || other.bypass == bypass)&&(identical(other.documentUrlDepth, documentUrlDepth) || other.documentUrlDepth == documentUrlDepth)&&const DeepCollectionEquality().equals(other.excludePaths, excludePaths)&&(identical(other.extractPageContent, extractPageContent) || other.extractPageContent == extractPageContent)&&(identical(other.followDocumentUrls, followDocumentUrls) || other.followDocumentUrls == followDocumentUrls)&&const DeepCollectionEquality().equals(other.includePaths, includePaths)&&(identical(other.maxConcurrent, maxConcurrent) || other.maxConcurrent == maxConcurrent)&&(identical(other.maxDepth, maxDepth) || other.maxDepth == maxDepth)&&(identical(other.maxPages, maxPages) || other.maxPages == maxPages)&&(identical(other.outputMode, outputMode) || other.outputMode == outputMode)&&(identical(other.proxy, proxy) || other.proxy == proxy)&&(identical(other.requestTimeoutSecs, requestTimeoutSecs) || other.requestTimeoutSecs == requestTimeoutSecs)&&(identical(other.respectRobotsTxt, respectRobotsTxt) || other.respectRobotsTxt == respectRobotsTxt)&&(identical(other.stayOnDomain, stayOnDomain) || other.stayOnDomain == stayOnDomain)&&(identical(other.strategy, strategy) || other.strategy == strategy)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,allowSubdomains,const DeepCollectionEquality().hash(allowedFileTypes),browser,bypass,documentUrlDepth,const DeepCollectionEquality().hash(excludePaths),extractPageContent,followDocumentUrls,const DeepCollectionEquality().hash(includePaths),maxConcurrent,maxDepth,maxPages,outputMode,proxy,requestTimeoutSecs,respectRobotsTxt,stayOnDomain,strategy,userAgent]);

@override
String toString() {
  return 'CrawlConfig(allowSubdomains: $allowSubdomains, allowedFileTypes: $allowedFileTypes, browser: $browser, bypass: $bypass, documentUrlDepth: $documentUrlDepth, excludePaths: $excludePaths, extractPageContent: $extractPageContent, followDocumentUrls: $followDocumentUrls, includePaths: $includePaths, maxConcurrent: $maxConcurrent, maxDepth: $maxDepth, maxPages: $maxPages, outputMode: $outputMode, proxy: $proxy, requestTimeoutSecs: $requestTimeoutSecs, respectRobotsTxt: $respectRobotsTxt, stayOnDomain: $stayOnDomain, strategy: $strategy, userAgent: $userAgent)';
}


}

/// @nodoc
abstract mixin class $CrawlConfigCopyWith<$Res>  {
  factory $CrawlConfigCopyWith(CrawlConfig value, $Res Function(CrawlConfig) _then) = _$CrawlConfigCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'allow_subdomains') bool? allowSubdomains,@JsonKey(name: 'allowed_file_types') List<String>? allowedFileTypes, BrowserOverrides? browser, BypassRequestOverride? bypass,@JsonKey(name: 'document_url_depth') int? documentUrlDepth,@JsonKey(name: 'exclude_paths') List<String>? excludePaths,@JsonKey(name: 'extract_page_content') bool? extractPageContent,@JsonKey(name: 'follow_document_urls') bool? followDocumentUrls,@JsonKey(name: 'include_paths') List<String>? includePaths,@JsonKey(name: 'max_concurrent') int? maxConcurrent,@JsonKey(name: 'max_depth') int? maxDepth,@JsonKey(name: 'max_pages') int? maxPages,@JsonKey(name: 'output_mode') String? outputMode, ProxyOverride? proxy,@JsonKey(name: 'request_timeout_secs') int? requestTimeoutSecs,@JsonKey(name: 'respect_robots_txt') bool? respectRobotsTxt,@JsonKey(name: 'stay_on_domain') bool? stayOnDomain, String? strategy,@JsonKey(name: 'user_agent') String? userAgent
});


$BrowserOverridesCopyWith<$Res>? get browser;$BypassRequestOverrideCopyWith<$Res>? get bypass;$ProxyOverrideCopyWith<$Res>? get proxy;

}
/// @nodoc
class _$CrawlConfigCopyWithImpl<$Res>
    implements $CrawlConfigCopyWith<$Res> {
  _$CrawlConfigCopyWithImpl(this._self, this._then);

  final CrawlConfig _self;
  final $Res Function(CrawlConfig) _then;

/// Create a copy of CrawlConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? allowSubdomains = freezed,Object? allowedFileTypes = freezed,Object? browser = freezed,Object? bypass = freezed,Object? documentUrlDepth = freezed,Object? excludePaths = freezed,Object? extractPageContent = freezed,Object? followDocumentUrls = freezed,Object? includePaths = freezed,Object? maxConcurrent = freezed,Object? maxDepth = freezed,Object? maxPages = freezed,Object? outputMode = freezed,Object? proxy = freezed,Object? requestTimeoutSecs = freezed,Object? respectRobotsTxt = freezed,Object? stayOnDomain = freezed,Object? strategy = freezed,Object? userAgent = freezed,}) {
  return _then(_self.copyWith(
allowSubdomains: freezed == allowSubdomains ? _self.allowSubdomains : allowSubdomains // ignore: cast_nullable_to_non_nullable
as bool?,allowedFileTypes: freezed == allowedFileTypes ? _self.allowedFileTypes : allowedFileTypes // ignore: cast_nullable_to_non_nullable
as List<String>?,browser: freezed == browser ? _self.browser : browser // ignore: cast_nullable_to_non_nullable
as BrowserOverrides?,bypass: freezed == bypass ? _self.bypass : bypass // ignore: cast_nullable_to_non_nullable
as BypassRequestOverride?,documentUrlDepth: freezed == documentUrlDepth ? _self.documentUrlDepth : documentUrlDepth // ignore: cast_nullable_to_non_nullable
as int?,excludePaths: freezed == excludePaths ? _self.excludePaths : excludePaths // ignore: cast_nullable_to_non_nullable
as List<String>?,extractPageContent: freezed == extractPageContent ? _self.extractPageContent : extractPageContent // ignore: cast_nullable_to_non_nullable
as bool?,followDocumentUrls: freezed == followDocumentUrls ? _self.followDocumentUrls : followDocumentUrls // ignore: cast_nullable_to_non_nullable
as bool?,includePaths: freezed == includePaths ? _self.includePaths : includePaths // ignore: cast_nullable_to_non_nullable
as List<String>?,maxConcurrent: freezed == maxConcurrent ? _self.maxConcurrent : maxConcurrent // ignore: cast_nullable_to_non_nullable
as int?,maxDepth: freezed == maxDepth ? _self.maxDepth : maxDepth // ignore: cast_nullable_to_non_nullable
as int?,maxPages: freezed == maxPages ? _self.maxPages : maxPages // ignore: cast_nullable_to_non_nullable
as int?,outputMode: freezed == outputMode ? _self.outputMode : outputMode // ignore: cast_nullable_to_non_nullable
as String?,proxy: freezed == proxy ? _self.proxy : proxy // ignore: cast_nullable_to_non_nullable
as ProxyOverride?,requestTimeoutSecs: freezed == requestTimeoutSecs ? _self.requestTimeoutSecs : requestTimeoutSecs // ignore: cast_nullable_to_non_nullable
as int?,respectRobotsTxt: freezed == respectRobotsTxt ? _self.respectRobotsTxt : respectRobotsTxt // ignore: cast_nullable_to_non_nullable
as bool?,stayOnDomain: freezed == stayOnDomain ? _self.stayOnDomain : stayOnDomain // ignore: cast_nullable_to_non_nullable
as bool?,strategy: freezed == strategy ? _self.strategy : strategy // ignore: cast_nullable_to_non_nullable
as String?,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CrawlConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BrowserOverridesCopyWith<$Res>? get browser {
    if (_self.browser == null) {
    return null;
  }

  return $BrowserOverridesCopyWith<$Res>(_self.browser!, (value) {
    return _then(_self.copyWith(browser: value));
  });
}/// Create a copy of CrawlConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BypassRequestOverrideCopyWith<$Res>? get bypass {
    if (_self.bypass == null) {
    return null;
  }

  return $BypassRequestOverrideCopyWith<$Res>(_self.bypass!, (value) {
    return _then(_self.copyWith(bypass: value));
  });
}/// Create a copy of CrawlConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProxyOverrideCopyWith<$Res>? get proxy {
    if (_self.proxy == null) {
    return null;
  }

  return $ProxyOverrideCopyWith<$Res>(_self.proxy!, (value) {
    return _then(_self.copyWith(proxy: value));
  });
}
}


/// Adds pattern-matching-related methods to [CrawlConfig].
extension CrawlConfigPatterns on CrawlConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CrawlConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CrawlConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CrawlConfig value)  $default,){
final _that = this;
switch (_that) {
case _CrawlConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CrawlConfig value)?  $default,){
final _that = this;
switch (_that) {
case _CrawlConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'allow_subdomains')  bool? allowSubdomains, @JsonKey(name: 'allowed_file_types')  List<String>? allowedFileTypes,  BrowserOverrides? browser,  BypassRequestOverride? bypass, @JsonKey(name: 'document_url_depth')  int? documentUrlDepth, @JsonKey(name: 'exclude_paths')  List<String>? excludePaths, @JsonKey(name: 'extract_page_content')  bool? extractPageContent, @JsonKey(name: 'follow_document_urls')  bool? followDocumentUrls, @JsonKey(name: 'include_paths')  List<String>? includePaths, @JsonKey(name: 'max_concurrent')  int? maxConcurrent, @JsonKey(name: 'max_depth')  int? maxDepth, @JsonKey(name: 'max_pages')  int? maxPages, @JsonKey(name: 'output_mode')  String? outputMode,  ProxyOverride? proxy, @JsonKey(name: 'request_timeout_secs')  int? requestTimeoutSecs, @JsonKey(name: 'respect_robots_txt')  bool? respectRobotsTxt, @JsonKey(name: 'stay_on_domain')  bool? stayOnDomain,  String? strategy, @JsonKey(name: 'user_agent')  String? userAgent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CrawlConfig() when $default != null:
return $default(_that.allowSubdomains,_that.allowedFileTypes,_that.browser,_that.bypass,_that.documentUrlDepth,_that.excludePaths,_that.extractPageContent,_that.followDocumentUrls,_that.includePaths,_that.maxConcurrent,_that.maxDepth,_that.maxPages,_that.outputMode,_that.proxy,_that.requestTimeoutSecs,_that.respectRobotsTxt,_that.stayOnDomain,_that.strategy,_that.userAgent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'allow_subdomains')  bool? allowSubdomains, @JsonKey(name: 'allowed_file_types')  List<String>? allowedFileTypes,  BrowserOverrides? browser,  BypassRequestOverride? bypass, @JsonKey(name: 'document_url_depth')  int? documentUrlDepth, @JsonKey(name: 'exclude_paths')  List<String>? excludePaths, @JsonKey(name: 'extract_page_content')  bool? extractPageContent, @JsonKey(name: 'follow_document_urls')  bool? followDocumentUrls, @JsonKey(name: 'include_paths')  List<String>? includePaths, @JsonKey(name: 'max_concurrent')  int? maxConcurrent, @JsonKey(name: 'max_depth')  int? maxDepth, @JsonKey(name: 'max_pages')  int? maxPages, @JsonKey(name: 'output_mode')  String? outputMode,  ProxyOverride? proxy, @JsonKey(name: 'request_timeout_secs')  int? requestTimeoutSecs, @JsonKey(name: 'respect_robots_txt')  bool? respectRobotsTxt, @JsonKey(name: 'stay_on_domain')  bool? stayOnDomain,  String? strategy, @JsonKey(name: 'user_agent')  String? userAgent)  $default,) {final _that = this;
switch (_that) {
case _CrawlConfig():
return $default(_that.allowSubdomains,_that.allowedFileTypes,_that.browser,_that.bypass,_that.documentUrlDepth,_that.excludePaths,_that.extractPageContent,_that.followDocumentUrls,_that.includePaths,_that.maxConcurrent,_that.maxDepth,_that.maxPages,_that.outputMode,_that.proxy,_that.requestTimeoutSecs,_that.respectRobotsTxt,_that.stayOnDomain,_that.strategy,_that.userAgent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'allow_subdomains')  bool? allowSubdomains, @JsonKey(name: 'allowed_file_types')  List<String>? allowedFileTypes,  BrowserOverrides? browser,  BypassRequestOverride? bypass, @JsonKey(name: 'document_url_depth')  int? documentUrlDepth, @JsonKey(name: 'exclude_paths')  List<String>? excludePaths, @JsonKey(name: 'extract_page_content')  bool? extractPageContent, @JsonKey(name: 'follow_document_urls')  bool? followDocumentUrls, @JsonKey(name: 'include_paths')  List<String>? includePaths, @JsonKey(name: 'max_concurrent')  int? maxConcurrent, @JsonKey(name: 'max_depth')  int? maxDepth, @JsonKey(name: 'max_pages')  int? maxPages, @JsonKey(name: 'output_mode')  String? outputMode,  ProxyOverride? proxy, @JsonKey(name: 'request_timeout_secs')  int? requestTimeoutSecs, @JsonKey(name: 'respect_robots_txt')  bool? respectRobotsTxt, @JsonKey(name: 'stay_on_domain')  bool? stayOnDomain,  String? strategy, @JsonKey(name: 'user_agent')  String? userAgent)?  $default,) {final _that = this;
switch (_that) {
case _CrawlConfig() when $default != null:
return $default(_that.allowSubdomains,_that.allowedFileTypes,_that.browser,_that.bypass,_that.documentUrlDepth,_that.excludePaths,_that.extractPageContent,_that.followDocumentUrls,_that.includePaths,_that.maxConcurrent,_that.maxDepth,_that.maxPages,_that.outputMode,_that.proxy,_that.requestTimeoutSecs,_that.respectRobotsTxt,_that.stayOnDomain,_that.strategy,_that.userAgent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CrawlConfig implements CrawlConfig {
  const _CrawlConfig({@JsonKey(name: 'allow_subdomains') this.allowSubdomains, @JsonKey(name: 'allowed_file_types') final  List<String>? allowedFileTypes, this.browser, this.bypass, @JsonKey(name: 'document_url_depth') this.documentUrlDepth, @JsonKey(name: 'exclude_paths') final  List<String>? excludePaths, @JsonKey(name: 'extract_page_content') this.extractPageContent, @JsonKey(name: 'follow_document_urls') this.followDocumentUrls, @JsonKey(name: 'include_paths') final  List<String>? includePaths, @JsonKey(name: 'max_concurrent') this.maxConcurrent, @JsonKey(name: 'max_depth') this.maxDepth, @JsonKey(name: 'max_pages') this.maxPages, @JsonKey(name: 'output_mode') this.outputMode, this.proxy, @JsonKey(name: 'request_timeout_secs') this.requestTimeoutSecs, @JsonKey(name: 'respect_robots_txt') this.respectRobotsTxt, @JsonKey(name: 'stay_on_domain') this.stayOnDomain, this.strategy, @JsonKey(name: 'user_agent') this.userAgent}): _allowedFileTypes = allowedFileTypes,_excludePaths = excludePaths,_includePaths = includePaths;
  factory _CrawlConfig.fromJson(Map<String, dynamic> json) => _$CrawlConfigFromJson(json);

/// Allow subdomains of the seed domain (default: true)
@override@JsonKey(name: 'allow_subdomains') final  bool? allowSubdomains;
/// MIME types of documents to extract (default: all supported by kreuzberg)
 final  List<String>? _allowedFileTypes;
/// MIME types of documents to extract (default: all supported by kreuzberg)
@override@JsonKey(name: 'allowed_file_types') List<String>? get allowedFileTypes {
  final value = _allowedFileTypes;
  if (value == null) return null;
  if (_allowedFileTypes is EqualUnmodifiableListView) return _allowedFileTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Browser rendering configuration overrides for this request
@override final  BrowserOverrides? browser;
/// Per-request bypass override. When set, applies an external bypass.
/// provider to bypass WAF/antibot on the crawl.
@override final  BypassRequestOverride? bypass;
/// Max depth for URL-following from documents (default: 1, max: 3)
@override@JsonKey(name: 'document_url_depth') final  int? documentUrlDepth;
/// Regex patterns — skip URLs matching these
 final  List<String>? _excludePaths;
/// Regex patterns — skip URLs matching these
@override@JsonKey(name: 'exclude_paths') List<String>? get excludePaths {
  final value = _excludePaths;
  if (value == null) return null;
  if (_excludePaths is EqualUnmodifiableListView) return _excludePaths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Also extract the HTML page content as markdown (default: false)
@override@JsonKey(name: 'extract_page_content') final  bool? extractPageContent;
/// Follow URLs discovered inside extracted documents (default: false)
@override@JsonKey(name: 'follow_document_urls') final  bool? followDocumentUrls;
/// Regex patterns — only crawl URLs matching these
 final  List<String>? _includePaths;
/// Regex patterns — only crawl URLs matching these
@override@JsonKey(name: 'include_paths') List<String>? get includePaths {
  final value = _includePaths;
  if (value == null) return null;
  if (_includePaths is EqualUnmodifiableListView) return _includePaths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Maximum concurrent requests (default: 10)
@override@JsonKey(name: 'max_concurrent') final  int? maxConcurrent;
/// Maximum crawl depth from seed URL (default: 2, max: 5)
@override@JsonKey(name: 'max_depth') final  int? maxDepth;
/// Maximum pages to crawl (default: 100, max: 10000)
@override@JsonKey(name: 'max_pages') final  int? maxPages;
/// Output mode (default: "extract").
/// - "scrape":  single-page fetch, no recursion, no extraction.
/// - "crawl":   multi-page crawl, no extraction (raw content returned).
/// - "extract": multi-page crawl + extract each discovered document.
@override@JsonKey(name: 'output_mode') final  String? outputMode;
/// Per-request proxy override. When set, this proxy is used for this.
/// crawl instead of the worker's process-wide proxy pool.
@override final  ProxyOverride? proxy;
/// Per-request timeout in seconds (default: 30)
@override@JsonKey(name: 'request_timeout_secs') final  int? requestTimeoutSecs;
/// Respect robots.txt (default: true)
@override@JsonKey(name: 'respect_robots_txt') final  bool? respectRobotsTxt;
/// Stay on the same domain as seed URL (default: true)
@override@JsonKey(name: 'stay_on_domain') final  bool? stayOnDomain;
/// Crawl strategy: "bfs" (default), "dfs", "best_first", "adaptive"
@override final  String? strategy;
/// Custom User-Agent string
@override@JsonKey(name: 'user_agent') final  String? userAgent;

/// Create a copy of CrawlConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CrawlConfigCopyWith<_CrawlConfig> get copyWith => __$CrawlConfigCopyWithImpl<_CrawlConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CrawlConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CrawlConfig&&(identical(other.allowSubdomains, allowSubdomains) || other.allowSubdomains == allowSubdomains)&&const DeepCollectionEquality().equals(other._allowedFileTypes, _allowedFileTypes)&&(identical(other.browser, browser) || other.browser == browser)&&(identical(other.bypass, bypass) || other.bypass == bypass)&&(identical(other.documentUrlDepth, documentUrlDepth) || other.documentUrlDepth == documentUrlDepth)&&const DeepCollectionEquality().equals(other._excludePaths, _excludePaths)&&(identical(other.extractPageContent, extractPageContent) || other.extractPageContent == extractPageContent)&&(identical(other.followDocumentUrls, followDocumentUrls) || other.followDocumentUrls == followDocumentUrls)&&const DeepCollectionEquality().equals(other._includePaths, _includePaths)&&(identical(other.maxConcurrent, maxConcurrent) || other.maxConcurrent == maxConcurrent)&&(identical(other.maxDepth, maxDepth) || other.maxDepth == maxDepth)&&(identical(other.maxPages, maxPages) || other.maxPages == maxPages)&&(identical(other.outputMode, outputMode) || other.outputMode == outputMode)&&(identical(other.proxy, proxy) || other.proxy == proxy)&&(identical(other.requestTimeoutSecs, requestTimeoutSecs) || other.requestTimeoutSecs == requestTimeoutSecs)&&(identical(other.respectRobotsTxt, respectRobotsTxt) || other.respectRobotsTxt == respectRobotsTxt)&&(identical(other.stayOnDomain, stayOnDomain) || other.stayOnDomain == stayOnDomain)&&(identical(other.strategy, strategy) || other.strategy == strategy)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,allowSubdomains,const DeepCollectionEquality().hash(_allowedFileTypes),browser,bypass,documentUrlDepth,const DeepCollectionEquality().hash(_excludePaths),extractPageContent,followDocumentUrls,const DeepCollectionEquality().hash(_includePaths),maxConcurrent,maxDepth,maxPages,outputMode,proxy,requestTimeoutSecs,respectRobotsTxt,stayOnDomain,strategy,userAgent]);

@override
String toString() {
  return 'CrawlConfig(allowSubdomains: $allowSubdomains, allowedFileTypes: $allowedFileTypes, browser: $browser, bypass: $bypass, documentUrlDepth: $documentUrlDepth, excludePaths: $excludePaths, extractPageContent: $extractPageContent, followDocumentUrls: $followDocumentUrls, includePaths: $includePaths, maxConcurrent: $maxConcurrent, maxDepth: $maxDepth, maxPages: $maxPages, outputMode: $outputMode, proxy: $proxy, requestTimeoutSecs: $requestTimeoutSecs, respectRobotsTxt: $respectRobotsTxt, stayOnDomain: $stayOnDomain, strategy: $strategy, userAgent: $userAgent)';
}


}

/// @nodoc
abstract mixin class _$CrawlConfigCopyWith<$Res> implements $CrawlConfigCopyWith<$Res> {
  factory _$CrawlConfigCopyWith(_CrawlConfig value, $Res Function(_CrawlConfig) _then) = __$CrawlConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'allow_subdomains') bool? allowSubdomains,@JsonKey(name: 'allowed_file_types') List<String>? allowedFileTypes, BrowserOverrides? browser, BypassRequestOverride? bypass,@JsonKey(name: 'document_url_depth') int? documentUrlDepth,@JsonKey(name: 'exclude_paths') List<String>? excludePaths,@JsonKey(name: 'extract_page_content') bool? extractPageContent,@JsonKey(name: 'follow_document_urls') bool? followDocumentUrls,@JsonKey(name: 'include_paths') List<String>? includePaths,@JsonKey(name: 'max_concurrent') int? maxConcurrent,@JsonKey(name: 'max_depth') int? maxDepth,@JsonKey(name: 'max_pages') int? maxPages,@JsonKey(name: 'output_mode') String? outputMode, ProxyOverride? proxy,@JsonKey(name: 'request_timeout_secs') int? requestTimeoutSecs,@JsonKey(name: 'respect_robots_txt') bool? respectRobotsTxt,@JsonKey(name: 'stay_on_domain') bool? stayOnDomain, String? strategy,@JsonKey(name: 'user_agent') String? userAgent
});


@override $BrowserOverridesCopyWith<$Res>? get browser;@override $BypassRequestOverrideCopyWith<$Res>? get bypass;@override $ProxyOverrideCopyWith<$Res>? get proxy;

}
/// @nodoc
class __$CrawlConfigCopyWithImpl<$Res>
    implements _$CrawlConfigCopyWith<$Res> {
  __$CrawlConfigCopyWithImpl(this._self, this._then);

  final _CrawlConfig _self;
  final $Res Function(_CrawlConfig) _then;

/// Create a copy of CrawlConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? allowSubdomains = freezed,Object? allowedFileTypes = freezed,Object? browser = freezed,Object? bypass = freezed,Object? documentUrlDepth = freezed,Object? excludePaths = freezed,Object? extractPageContent = freezed,Object? followDocumentUrls = freezed,Object? includePaths = freezed,Object? maxConcurrent = freezed,Object? maxDepth = freezed,Object? maxPages = freezed,Object? outputMode = freezed,Object? proxy = freezed,Object? requestTimeoutSecs = freezed,Object? respectRobotsTxt = freezed,Object? stayOnDomain = freezed,Object? strategy = freezed,Object? userAgent = freezed,}) {
  return _then(_CrawlConfig(
allowSubdomains: freezed == allowSubdomains ? _self.allowSubdomains : allowSubdomains // ignore: cast_nullable_to_non_nullable
as bool?,allowedFileTypes: freezed == allowedFileTypes ? _self._allowedFileTypes : allowedFileTypes // ignore: cast_nullable_to_non_nullable
as List<String>?,browser: freezed == browser ? _self.browser : browser // ignore: cast_nullable_to_non_nullable
as BrowserOverrides?,bypass: freezed == bypass ? _self.bypass : bypass // ignore: cast_nullable_to_non_nullable
as BypassRequestOverride?,documentUrlDepth: freezed == documentUrlDepth ? _self.documentUrlDepth : documentUrlDepth // ignore: cast_nullable_to_non_nullable
as int?,excludePaths: freezed == excludePaths ? _self._excludePaths : excludePaths // ignore: cast_nullable_to_non_nullable
as List<String>?,extractPageContent: freezed == extractPageContent ? _self.extractPageContent : extractPageContent // ignore: cast_nullable_to_non_nullable
as bool?,followDocumentUrls: freezed == followDocumentUrls ? _self.followDocumentUrls : followDocumentUrls // ignore: cast_nullable_to_non_nullable
as bool?,includePaths: freezed == includePaths ? _self._includePaths : includePaths // ignore: cast_nullable_to_non_nullable
as List<String>?,maxConcurrent: freezed == maxConcurrent ? _self.maxConcurrent : maxConcurrent // ignore: cast_nullable_to_non_nullable
as int?,maxDepth: freezed == maxDepth ? _self.maxDepth : maxDepth // ignore: cast_nullable_to_non_nullable
as int?,maxPages: freezed == maxPages ? _self.maxPages : maxPages // ignore: cast_nullable_to_non_nullable
as int?,outputMode: freezed == outputMode ? _self.outputMode : outputMode // ignore: cast_nullable_to_non_nullable
as String?,proxy: freezed == proxy ? _self.proxy : proxy // ignore: cast_nullable_to_non_nullable
as ProxyOverride?,requestTimeoutSecs: freezed == requestTimeoutSecs ? _self.requestTimeoutSecs : requestTimeoutSecs // ignore: cast_nullable_to_non_nullable
as int?,respectRobotsTxt: freezed == respectRobotsTxt ? _self.respectRobotsTxt : respectRobotsTxt // ignore: cast_nullable_to_non_nullable
as bool?,stayOnDomain: freezed == stayOnDomain ? _self.stayOnDomain : stayOnDomain // ignore: cast_nullable_to_non_nullable
as bool?,strategy: freezed == strategy ? _self.strategy : strategy // ignore: cast_nullable_to_non_nullable
as String?,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CrawlConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BrowserOverridesCopyWith<$Res>? get browser {
    if (_self.browser == null) {
    return null;
  }

  return $BrowserOverridesCopyWith<$Res>(_self.browser!, (value) {
    return _then(_self.copyWith(browser: value));
  });
}/// Create a copy of CrawlConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BypassRequestOverrideCopyWith<$Res>? get bypass {
    if (_self.bypass == null) {
    return null;
  }

  return $BypassRequestOverrideCopyWith<$Res>(_self.bypass!, (value) {
    return _then(_self.copyWith(bypass: value));
  });
}/// Create a copy of CrawlConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProxyOverrideCopyWith<$Res>? get proxy {
    if (_self.proxy == null) {
    return null;
  }

  return $ProxyOverrideCopyWith<$Res>(_self.proxy!, (value) {
    return _then(_self.copyWith(proxy: value));
  });
}
}

// dart format on
