// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'hierarchical_block.freezed.dart';
part 'hierarchical_block.g.dart';

/// A text block with hierarchy level assignment.
///
/// Represents a block of text with semantic heading information extracted from.
/// font size clustering and hierarchical analysis.
@Freezed()
abstract class HierarchicalBlock with _$HierarchicalBlock {
  const factory HierarchicalBlock({
    /// The font size of the text in this block
    @JsonKey(name: 'font_size')
    required double fontSize,

    /// The hierarchy level of this block (H1-H6 or Body).
    ///
    /// Levels correspond to HTML heading tags:.
    /// - "h1": Top-level heading.
    /// - "h2": Secondary heading.
    /// - "h3": Tertiary heading.
    /// - "h4": Quaternary heading.
    /// - "h5": Quinary heading.
    /// - "h6": Senary heading.
    /// - "body": Body text (no heading level).
    required String level,

    /// The text content of this block
    required String text,

    /// Bounding box information for the block.
    ///
    /// Contains coordinates as (left, top, right, bottom) in PDF units.
    List<double>? bbox,
  }) = _HierarchicalBlock;
  
  factory HierarchicalBlock.fromJson(Map<String, Object?> json) => _$HierarchicalBlockFromJson(json);
}
