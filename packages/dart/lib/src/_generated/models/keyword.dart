// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'keyword_algorithm.dart';

part 'keyword.freezed.dart';
part 'keyword.g.dart';

/// Extracted keyword with metadata.
@Freezed()
abstract class Keyword with _$Keyword {
  const factory Keyword({
    /// Algorithm that extracted this keyword.
    required KeywordAlgorithm algorithm,

    /// Relevance score (higher is better, algorithm-specific range).
    required double score,

    /// The keyword text.
    required String text,

    /// Optional positions where keyword appears in text (character offsets).
    List<int>? positions,
  }) = _Keyword;
  
  factory Keyword.fromJson(Map<String, Object?> json) => _$KeywordFromJson(json);
}
