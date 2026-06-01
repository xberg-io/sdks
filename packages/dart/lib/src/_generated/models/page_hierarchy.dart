// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'hierarchical_block.dart';

part 'page_hierarchy.freezed.dart';
part 'page_hierarchy.g.dart';

/// Page hierarchy structure containing heading levels and block information.
///
/// Used when PDF text hierarchy extraction is enabled. Contains hierarchical.
/// blocks with heading levels (H1-H6) for semantic document structure.
@Freezed()
abstract class PageHierarchy with _$PageHierarchy {
  const factory PageHierarchy({
    /// Number of hierarchy blocks on this page
    @JsonKey(name: 'block_count') required int blockCount,

    /// Hierarchical blocks with heading levels
    List<HierarchicalBlock>? blocks,
  }) = _PageHierarchy;

  factory PageHierarchy.fromJson(Map<String, Object?> json) =>
      _$PageHierarchyFromJson(json);
}
