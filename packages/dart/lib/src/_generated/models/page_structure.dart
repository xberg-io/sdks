// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_structure.freezed.dart';
part 'page_structure.g.dart';

/// Page structure metadata.
@Freezed()
abstract class PageStructure with _$PageStructure {
  const factory PageStructure({
    @JsonKey(name: 'total_count')
    required int totalCount,
  }) = _PageStructure;
  
  factory PageStructure.fromJson(Map<String, Object?> json) => _$PageStructureFromJson(json);
}
