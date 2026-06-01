// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'format_metadata.dart';
import 'header_metadata.dart';
import 'image_metadata_type.dart';
import 'link_metadata.dart';
import 'structured_data.dart';
import 'text_direction.dart';

part 'html_metadata.freezed.dart';
part 'html_metadata.g.dart';

/// HTML metadata extracted from HTML documents.
///
/// Includes document-level metadata, Open Graph data, Twitter Card metadata,.
/// and extracted structural elements (headers, links, images, structured data).
@Freezed()
abstract class HtmlMetadata with _$HtmlMetadata {
  const factory HtmlMetadata({
    /// Document author from `<meta name="author">` tag
    String? author,

    /// Base URL from `<base href="">` tag for resolving relative URLs
    @JsonKey(name: 'base_href')
    String? baseHref,

    /// Canonical URL from `<link rel="canonical">` tag
    @JsonKey(name: 'canonical_url')
    String? canonicalUrl,

    /// Document description from `<meta name="description">` tag
    String? description,

    /// Extracted header elements with hierarchy
    List<HeaderMetadata>? headers,

    /// Extracted images with source and dimensions
    List<ImageMetadataType>? images,

    /// Document keywords from `<meta name="keywords">` tag, split on commas
    List<String>? keywords,

    /// Document language from `lang` attribute
    String? language,

    /// Extracted hyperlinks with type classification
    List<LinkMetadata>? links,

    /// Additional meta tags not covered by specific fields.
    /// Keys are meta name/property attributes, values are content.
    @JsonKey(name: 'meta_tags')
    Map<String, String>? metaTags,

    /// Open Graph metadata (og:* properties) for social media.
    /// Keys like "title", "description", "image", "url", etc.
    @JsonKey(name: 'open_graph')
    Map<String, String>? openGraph,

    /// Extracted structured data blocks
    @JsonKey(name: 'structured_data')
    List<StructuredData>? structuredData,

    /// Document text direction from `dir` attribute
    @JsonKey(name: 'text_direction')
    TextDirection? textDirection,

    /// Document title from `<title>` tag
    String? title,

    /// Twitter Card metadata (twitter:* properties).
    /// Keys like "card", "site", "creator", "title", "description", "image", etc.
    @JsonKey(name: 'twitter_card')
    Map<String, String>? twitterCard,
  }) = _HtmlMetadata;
  
  factory HtmlMetadata.fromJson(Map<String, Object?> json) => _$HtmlMetadataFromJson(json);
}
