// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_versions_query.freezed.dart';
part 'list_versions_query.g.dart';

/// Query parameters for document versions list.
@Freezed()
abstract class ListVersionsQuery with _$ListVersionsQuery {
  const factory ListVersionsQuery({
    /// Maximum number of versions to return (default 50, max 200).
    int? limit,

    /// Number of versions to skip.
    int? offset,
  }) = _ListVersionsQuery;

  factory ListVersionsQuery.fromJson(Map<String, Object?> json) =>
      _$ListVersionsQueryFromJson(json);
}
