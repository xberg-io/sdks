// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'attributes.dart';

part 'djot_link.freezed.dart';
part 'djot_link.g.dart';

/// Link element in Djot.
@Freezed()
abstract class DjotLink with _$DjotLink {
  const factory DjotLink({
    /// Link text content
    required String text,

    /// Link URL
    required String url,

    /// Element attributes
    Attributes? attributes,

    /// Optional title
    String? title,
  }) = _DjotLink;
  
  factory DjotLink.fromJson(Map<String, Object?> json) => _$DjotLinkFromJson(json);
}
