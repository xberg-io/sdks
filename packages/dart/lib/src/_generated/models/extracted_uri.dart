// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'uri_kind.dart';

part 'extracted_uri.freezed.dart';
part 'extracted_uri.g.dart';

/// A URI extracted from a document.
///
/// Represents any link, reference, or resource pointer found during extraction.
/// The `kind` field classifies the URI semantically, while `label` carries.
/// optional human-readable display text.
@Freezed()
abstract class ExtractedUri with _$ExtractedUri {
  const factory ExtractedUri({
    /// Semantic classification of the URI.
    required UriKind kind,

    /// The URL or path string.
    required String url,

    /// Optional display text / label for the link.
    String? label,

    /// Optional page number where the URI was found (1-indexed).
    int? page,
  }) = _ExtractedUri;
  
  factory ExtractedUri.fromJson(Map<String, Object?> json) => _$ExtractedUriFromJson(json);
}
