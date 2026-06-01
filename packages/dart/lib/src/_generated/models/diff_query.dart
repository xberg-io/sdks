// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'diff_query.freezed.dart';
part 'diff_query.g.dart';

/// Query parameters for diff computation.
@Freezed()
abstract class DiffQuery with _$DiffQuery {
  const factory DiffQuery({
    /// Version sequence or job ID for the "from" extraction.
    required String from,

    /// Version sequence or job ID for the "to" extraction.
    required String to,
  }) = _DiffQuery;

  factory DiffQuery.fromJson(Map<String, Object?> json) =>
      _$DiffQueryFromJson(json);
}
