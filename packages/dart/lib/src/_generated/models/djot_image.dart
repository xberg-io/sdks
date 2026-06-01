// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'attributes.dart';

part 'djot_image.freezed.dart';
part 'djot_image.g.dart';

/// Image element in Djot.
@Freezed()
abstract class DjotImage with _$DjotImage {
  const factory DjotImage({
    /// Alternative text
    required String alt,

    /// Image source URL or path
    required String src,

    /// Element attributes
    Attributes? attributes,

    /// Optional title
    String? title,
  }) = _DjotImage;
  
  factory DjotImage.fromJson(Map<String, Object?> json) => _$DjotImageFromJson(json);
}
