// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'format_metadata.dart';

part 'pst_metadata.freezed.dart';
part 'pst_metadata.g.dart';

/// Outlook PST archive metadata.
@Freezed()
abstract class PstMetadata with _$PstMetadata {
  const factory PstMetadata({
    @JsonKey(name: 'message_count') required int messageCount,
  }) = _PstMetadata;

  factory PstMetadata.fromJson(Map<String, Object?> json) =>
      _$PstMetadataFromJson(json);
}
