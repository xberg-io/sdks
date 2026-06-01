// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'html_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HtmlMetadata {

/// Document author from `<meta name="author">` tag
 String? get author;/// Base URL from `<base href="">` tag for resolving relative URLs
@JsonKey(name: 'base_href') String? get baseHref;/// Canonical URL from `<link rel="canonical">` tag
@JsonKey(name: 'canonical_url') String? get canonicalUrl;/// Document description from `<meta name="description">` tag
 String? get description;/// Extracted header elements with hierarchy
 List<HeaderMetadata>? get headers;/// Extracted images with source and dimensions
 List<ImageMetadataType>? get images;/// Document keywords from `<meta name="keywords">` tag, split on commas
 List<String>? get keywords;/// Document language from `lang` attribute
 String? get language;/// Extracted hyperlinks with type classification
 List<LinkMetadata>? get links;/// Additional meta tags not covered by specific fields.
/// Keys are meta name/property attributes, values are content.
@JsonKey(name: 'meta_tags') Map<String, String>? get metaTags;/// Open Graph metadata (og:* properties) for social media.
/// Keys like "title", "description", "image", "url", etc.
@JsonKey(name: 'open_graph') Map<String, String>? get openGraph;/// Extracted structured data blocks
@JsonKey(name: 'structured_data') List<StructuredData>? get structuredData;/// Document text direction from `dir` attribute
@JsonKey(name: 'text_direction') TextDirection? get textDirection;/// Document title from `<title>` tag
 String? get title;/// Twitter Card metadata (twitter:* properties).
/// Keys like "card", "site", "creator", "title", "description", "image", etc.
@JsonKey(name: 'twitter_card') Map<String, String>? get twitterCard;
/// Create a copy of HtmlMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HtmlMetadataCopyWith<HtmlMetadata> get copyWith => _$HtmlMetadataCopyWithImpl<HtmlMetadata>(this as HtmlMetadata, _$identity);

  /// Serializes this HtmlMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HtmlMetadata&&(identical(other.author, author) || other.author == author)&&(identical(other.baseHref, baseHref) || other.baseHref == baseHref)&&(identical(other.canonicalUrl, canonicalUrl) || other.canonicalUrl == canonicalUrl)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.headers, headers)&&const DeepCollectionEquality().equals(other.images, images)&&const DeepCollectionEquality().equals(other.keywords, keywords)&&(identical(other.language, language) || other.language == language)&&const DeepCollectionEquality().equals(other.links, links)&&const DeepCollectionEquality().equals(other.metaTags, metaTags)&&const DeepCollectionEquality().equals(other.openGraph, openGraph)&&const DeepCollectionEquality().equals(other.structuredData, structuredData)&&(identical(other.textDirection, textDirection) || other.textDirection == textDirection)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.twitterCard, twitterCard));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,author,baseHref,canonicalUrl,description,const DeepCollectionEquality().hash(headers),const DeepCollectionEquality().hash(images),const DeepCollectionEquality().hash(keywords),language,const DeepCollectionEquality().hash(links),const DeepCollectionEquality().hash(metaTags),const DeepCollectionEquality().hash(openGraph),const DeepCollectionEquality().hash(structuredData),textDirection,title,const DeepCollectionEquality().hash(twitterCard));

@override
String toString() {
  return 'HtmlMetadata(author: $author, baseHref: $baseHref, canonicalUrl: $canonicalUrl, description: $description, headers: $headers, images: $images, keywords: $keywords, language: $language, links: $links, metaTags: $metaTags, openGraph: $openGraph, structuredData: $structuredData, textDirection: $textDirection, title: $title, twitterCard: $twitterCard)';
}


}

/// @nodoc
abstract mixin class $HtmlMetadataCopyWith<$Res>  {
  factory $HtmlMetadataCopyWith(HtmlMetadata value, $Res Function(HtmlMetadata) _then) = _$HtmlMetadataCopyWithImpl;
@useResult
$Res call({
 String? author,@JsonKey(name: 'base_href') String? baseHref,@JsonKey(name: 'canonical_url') String? canonicalUrl, String? description, List<HeaderMetadata>? headers, List<ImageMetadataType>? images, List<String>? keywords, String? language, List<LinkMetadata>? links,@JsonKey(name: 'meta_tags') Map<String, String>? metaTags,@JsonKey(name: 'open_graph') Map<String, String>? openGraph,@JsonKey(name: 'structured_data') List<StructuredData>? structuredData,@JsonKey(name: 'text_direction') TextDirection? textDirection, String? title,@JsonKey(name: 'twitter_card') Map<String, String>? twitterCard
});




}
/// @nodoc
class _$HtmlMetadataCopyWithImpl<$Res>
    implements $HtmlMetadataCopyWith<$Res> {
  _$HtmlMetadataCopyWithImpl(this._self, this._then);

  final HtmlMetadata _self;
  final $Res Function(HtmlMetadata) _then;

/// Create a copy of HtmlMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? author = freezed,Object? baseHref = freezed,Object? canonicalUrl = freezed,Object? description = freezed,Object? headers = freezed,Object? images = freezed,Object? keywords = freezed,Object? language = freezed,Object? links = freezed,Object? metaTags = freezed,Object? openGraph = freezed,Object? structuredData = freezed,Object? textDirection = freezed,Object? title = freezed,Object? twitterCard = freezed,}) {
  return _then(_self.copyWith(
author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,baseHref: freezed == baseHref ? _self.baseHref : baseHref // ignore: cast_nullable_to_non_nullable
as String?,canonicalUrl: freezed == canonicalUrl ? _self.canonicalUrl : canonicalUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,headers: freezed == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as List<HeaderMetadata>?,images: freezed == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<ImageMetadataType>?,keywords: freezed == keywords ? _self.keywords : keywords // ignore: cast_nullable_to_non_nullable
as List<String>?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,links: freezed == links ? _self.links : links // ignore: cast_nullable_to_non_nullable
as List<LinkMetadata>?,metaTags: freezed == metaTags ? _self.metaTags : metaTags // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,openGraph: freezed == openGraph ? _self.openGraph : openGraph // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,structuredData: freezed == structuredData ? _self.structuredData : structuredData // ignore: cast_nullable_to_non_nullable
as List<StructuredData>?,textDirection: freezed == textDirection ? _self.textDirection : textDirection // ignore: cast_nullable_to_non_nullable
as TextDirection?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,twitterCard: freezed == twitterCard ? _self.twitterCard : twitterCard // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [HtmlMetadata].
extension HtmlMetadataPatterns on HtmlMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HtmlMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HtmlMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HtmlMetadata value)  $default,){
final _that = this;
switch (_that) {
case _HtmlMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HtmlMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _HtmlMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? author, @JsonKey(name: 'base_href')  String? baseHref, @JsonKey(name: 'canonical_url')  String? canonicalUrl,  String? description,  List<HeaderMetadata>? headers,  List<ImageMetadataType>? images,  List<String>? keywords,  String? language,  List<LinkMetadata>? links, @JsonKey(name: 'meta_tags')  Map<String, String>? metaTags, @JsonKey(name: 'open_graph')  Map<String, String>? openGraph, @JsonKey(name: 'structured_data')  List<StructuredData>? structuredData, @JsonKey(name: 'text_direction')  TextDirection? textDirection,  String? title, @JsonKey(name: 'twitter_card')  Map<String, String>? twitterCard)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HtmlMetadata() when $default != null:
return $default(_that.author,_that.baseHref,_that.canonicalUrl,_that.description,_that.headers,_that.images,_that.keywords,_that.language,_that.links,_that.metaTags,_that.openGraph,_that.structuredData,_that.textDirection,_that.title,_that.twitterCard);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? author, @JsonKey(name: 'base_href')  String? baseHref, @JsonKey(name: 'canonical_url')  String? canonicalUrl,  String? description,  List<HeaderMetadata>? headers,  List<ImageMetadataType>? images,  List<String>? keywords,  String? language,  List<LinkMetadata>? links, @JsonKey(name: 'meta_tags')  Map<String, String>? metaTags, @JsonKey(name: 'open_graph')  Map<String, String>? openGraph, @JsonKey(name: 'structured_data')  List<StructuredData>? structuredData, @JsonKey(name: 'text_direction')  TextDirection? textDirection,  String? title, @JsonKey(name: 'twitter_card')  Map<String, String>? twitterCard)  $default,) {final _that = this;
switch (_that) {
case _HtmlMetadata():
return $default(_that.author,_that.baseHref,_that.canonicalUrl,_that.description,_that.headers,_that.images,_that.keywords,_that.language,_that.links,_that.metaTags,_that.openGraph,_that.structuredData,_that.textDirection,_that.title,_that.twitterCard);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? author, @JsonKey(name: 'base_href')  String? baseHref, @JsonKey(name: 'canonical_url')  String? canonicalUrl,  String? description,  List<HeaderMetadata>? headers,  List<ImageMetadataType>? images,  List<String>? keywords,  String? language,  List<LinkMetadata>? links, @JsonKey(name: 'meta_tags')  Map<String, String>? metaTags, @JsonKey(name: 'open_graph')  Map<String, String>? openGraph, @JsonKey(name: 'structured_data')  List<StructuredData>? structuredData, @JsonKey(name: 'text_direction')  TextDirection? textDirection,  String? title, @JsonKey(name: 'twitter_card')  Map<String, String>? twitterCard)?  $default,) {final _that = this;
switch (_that) {
case _HtmlMetadata() when $default != null:
return $default(_that.author,_that.baseHref,_that.canonicalUrl,_that.description,_that.headers,_that.images,_that.keywords,_that.language,_that.links,_that.metaTags,_that.openGraph,_that.structuredData,_that.textDirection,_that.title,_that.twitterCard);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HtmlMetadata implements HtmlMetadata {
  const _HtmlMetadata({this.author, @JsonKey(name: 'base_href') this.baseHref, @JsonKey(name: 'canonical_url') this.canonicalUrl, this.description, final  List<HeaderMetadata>? headers, final  List<ImageMetadataType>? images, final  List<String>? keywords, this.language, final  List<LinkMetadata>? links, @JsonKey(name: 'meta_tags') final  Map<String, String>? metaTags, @JsonKey(name: 'open_graph') final  Map<String, String>? openGraph, @JsonKey(name: 'structured_data') final  List<StructuredData>? structuredData, @JsonKey(name: 'text_direction') this.textDirection, this.title, @JsonKey(name: 'twitter_card') final  Map<String, String>? twitterCard}): _headers = headers,_images = images,_keywords = keywords,_links = links,_metaTags = metaTags,_openGraph = openGraph,_structuredData = structuredData,_twitterCard = twitterCard;
  factory _HtmlMetadata.fromJson(Map<String, dynamic> json) => _$HtmlMetadataFromJson(json);

/// Document author from `<meta name="author">` tag
@override final  String? author;
/// Base URL from `<base href="">` tag for resolving relative URLs
@override@JsonKey(name: 'base_href') final  String? baseHref;
/// Canonical URL from `<link rel="canonical">` tag
@override@JsonKey(name: 'canonical_url') final  String? canonicalUrl;
/// Document description from `<meta name="description">` tag
@override final  String? description;
/// Extracted header elements with hierarchy
 final  List<HeaderMetadata>? _headers;
/// Extracted header elements with hierarchy
@override List<HeaderMetadata>? get headers {
  final value = _headers;
  if (value == null) return null;
  if (_headers is EqualUnmodifiableListView) return _headers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Extracted images with source and dimensions
 final  List<ImageMetadataType>? _images;
/// Extracted images with source and dimensions
@override List<ImageMetadataType>? get images {
  final value = _images;
  if (value == null) return null;
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Document keywords from `<meta name="keywords">` tag, split on commas
 final  List<String>? _keywords;
/// Document keywords from `<meta name="keywords">` tag, split on commas
@override List<String>? get keywords {
  final value = _keywords;
  if (value == null) return null;
  if (_keywords is EqualUnmodifiableListView) return _keywords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Document language from `lang` attribute
@override final  String? language;
/// Extracted hyperlinks with type classification
 final  List<LinkMetadata>? _links;
/// Extracted hyperlinks with type classification
@override List<LinkMetadata>? get links {
  final value = _links;
  if (value == null) return null;
  if (_links is EqualUnmodifiableListView) return _links;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Additional meta tags not covered by specific fields.
/// Keys are meta name/property attributes, values are content.
 final  Map<String, String>? _metaTags;
/// Additional meta tags not covered by specific fields.
/// Keys are meta name/property attributes, values are content.
@override@JsonKey(name: 'meta_tags') Map<String, String>? get metaTags {
  final value = _metaTags;
  if (value == null) return null;
  if (_metaTags is EqualUnmodifiableMapView) return _metaTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Open Graph metadata (og:* properties) for social media.
/// Keys like "title", "description", "image", "url", etc.
 final  Map<String, String>? _openGraph;
/// Open Graph metadata (og:* properties) for social media.
/// Keys like "title", "description", "image", "url", etc.
@override@JsonKey(name: 'open_graph') Map<String, String>? get openGraph {
  final value = _openGraph;
  if (value == null) return null;
  if (_openGraph is EqualUnmodifiableMapView) return _openGraph;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Extracted structured data blocks
 final  List<StructuredData>? _structuredData;
/// Extracted structured data blocks
@override@JsonKey(name: 'structured_data') List<StructuredData>? get structuredData {
  final value = _structuredData;
  if (value == null) return null;
  if (_structuredData is EqualUnmodifiableListView) return _structuredData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Document text direction from `dir` attribute
@override@JsonKey(name: 'text_direction') final  TextDirection? textDirection;
/// Document title from `<title>` tag
@override final  String? title;
/// Twitter Card metadata (twitter:* properties).
/// Keys like "card", "site", "creator", "title", "description", "image", etc.
 final  Map<String, String>? _twitterCard;
/// Twitter Card metadata (twitter:* properties).
/// Keys like "card", "site", "creator", "title", "description", "image", etc.
@override@JsonKey(name: 'twitter_card') Map<String, String>? get twitterCard {
  final value = _twitterCard;
  if (value == null) return null;
  if (_twitterCard is EqualUnmodifiableMapView) return _twitterCard;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of HtmlMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HtmlMetadataCopyWith<_HtmlMetadata> get copyWith => __$HtmlMetadataCopyWithImpl<_HtmlMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HtmlMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HtmlMetadata&&(identical(other.author, author) || other.author == author)&&(identical(other.baseHref, baseHref) || other.baseHref == baseHref)&&(identical(other.canonicalUrl, canonicalUrl) || other.canonicalUrl == canonicalUrl)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._headers, _headers)&&const DeepCollectionEquality().equals(other._images, _images)&&const DeepCollectionEquality().equals(other._keywords, _keywords)&&(identical(other.language, language) || other.language == language)&&const DeepCollectionEquality().equals(other._links, _links)&&const DeepCollectionEquality().equals(other._metaTags, _metaTags)&&const DeepCollectionEquality().equals(other._openGraph, _openGraph)&&const DeepCollectionEquality().equals(other._structuredData, _structuredData)&&(identical(other.textDirection, textDirection) || other.textDirection == textDirection)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._twitterCard, _twitterCard));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,author,baseHref,canonicalUrl,description,const DeepCollectionEquality().hash(_headers),const DeepCollectionEquality().hash(_images),const DeepCollectionEquality().hash(_keywords),language,const DeepCollectionEquality().hash(_links),const DeepCollectionEquality().hash(_metaTags),const DeepCollectionEquality().hash(_openGraph),const DeepCollectionEquality().hash(_structuredData),textDirection,title,const DeepCollectionEquality().hash(_twitterCard));

@override
String toString() {
  return 'HtmlMetadata(author: $author, baseHref: $baseHref, canonicalUrl: $canonicalUrl, description: $description, headers: $headers, images: $images, keywords: $keywords, language: $language, links: $links, metaTags: $metaTags, openGraph: $openGraph, structuredData: $structuredData, textDirection: $textDirection, title: $title, twitterCard: $twitterCard)';
}


}

/// @nodoc
abstract mixin class _$HtmlMetadataCopyWith<$Res> implements $HtmlMetadataCopyWith<$Res> {
  factory _$HtmlMetadataCopyWith(_HtmlMetadata value, $Res Function(_HtmlMetadata) _then) = __$HtmlMetadataCopyWithImpl;
@override @useResult
$Res call({
 String? author,@JsonKey(name: 'base_href') String? baseHref,@JsonKey(name: 'canonical_url') String? canonicalUrl, String? description, List<HeaderMetadata>? headers, List<ImageMetadataType>? images, List<String>? keywords, String? language, List<LinkMetadata>? links,@JsonKey(name: 'meta_tags') Map<String, String>? metaTags,@JsonKey(name: 'open_graph') Map<String, String>? openGraph,@JsonKey(name: 'structured_data') List<StructuredData>? structuredData,@JsonKey(name: 'text_direction') TextDirection? textDirection, String? title,@JsonKey(name: 'twitter_card') Map<String, String>? twitterCard
});




}
/// @nodoc
class __$HtmlMetadataCopyWithImpl<$Res>
    implements _$HtmlMetadataCopyWith<$Res> {
  __$HtmlMetadataCopyWithImpl(this._self, this._then);

  final _HtmlMetadata _self;
  final $Res Function(_HtmlMetadata) _then;

/// Create a copy of HtmlMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? author = freezed,Object? baseHref = freezed,Object? canonicalUrl = freezed,Object? description = freezed,Object? headers = freezed,Object? images = freezed,Object? keywords = freezed,Object? language = freezed,Object? links = freezed,Object? metaTags = freezed,Object? openGraph = freezed,Object? structuredData = freezed,Object? textDirection = freezed,Object? title = freezed,Object? twitterCard = freezed,}) {
  return _then(_HtmlMetadata(
author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,baseHref: freezed == baseHref ? _self.baseHref : baseHref // ignore: cast_nullable_to_non_nullable
as String?,canonicalUrl: freezed == canonicalUrl ? _self.canonicalUrl : canonicalUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,headers: freezed == headers ? _self._headers : headers // ignore: cast_nullable_to_non_nullable
as List<HeaderMetadata>?,images: freezed == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<ImageMetadataType>?,keywords: freezed == keywords ? _self._keywords : keywords // ignore: cast_nullable_to_non_nullable
as List<String>?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,links: freezed == links ? _self._links : links // ignore: cast_nullable_to_non_nullable
as List<LinkMetadata>?,metaTags: freezed == metaTags ? _self._metaTags : metaTags // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,openGraph: freezed == openGraph ? _self._openGraph : openGraph // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,structuredData: freezed == structuredData ? _self._structuredData : structuredData // ignore: cast_nullable_to_non_nullable
as List<StructuredData>?,textDirection: freezed == textDirection ? _self.textDirection : textDirection // ignore: cast_nullable_to_non_nullable
as TextDirection?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,twitterCard: freezed == twitterCard ? _self._twitterCard : twitterCard // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}


}

// dart format on
