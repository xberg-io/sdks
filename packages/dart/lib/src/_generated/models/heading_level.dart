// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'heading_level.freezed.dart';
part 'heading_level.g.dart';

/// A single heading in the hierarchy.
@Freezed()
abstract class HeadingLevel with _$HeadingLevel {
  const factory HeadingLevel({
    /// Heading depth (1 = h1, 2 = h2, etc.)
    required int level,

    /// The text content of the heading.
    required String text,
  }) = _HeadingLevel;
  
  factory HeadingLevel.fromJson(Map<String, Object?> json) => _$HeadingLevelFromJson(json);
}
