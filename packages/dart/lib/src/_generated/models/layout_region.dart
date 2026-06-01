// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'bounding_box.dart';

part 'layout_region.freezed.dart';
part 'layout_region.g.dart';

/// A detected layout region on a page.
///
/// When layout detection is enabled, each page may have layout regions.
/// identifying different content types (text, pictures, tables, etc.).
/// with confidence scores and spatial positions.
@Freezed()
abstract class LayoutRegion with _$LayoutRegion {
  const factory LayoutRegion({
    /// Fraction of the page area covered by this region (0.0 to 1.0).
    @JsonKey(name: 'area_fraction')
    required double areaFraction,

    /// Bounding box in document coordinate space.
    @JsonKey(name: 'bounding_box')
    required BoundingBox boundingBox,

    /// Layout class name (e.g. "picture", "table", "text", "section_header").
    @JsonKey(name: 'class_name')
    required String className,

    /// Confidence score from the layout detection model (0.0 to 1.0).
    required double confidence,
  }) = _LayoutRegion;
  
  factory LayoutRegion.fromJson(Map<String, Object?> json) => _$LayoutRegionFromJson(json);
}
