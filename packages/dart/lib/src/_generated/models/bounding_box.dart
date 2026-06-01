// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'bounding_box.freezed.dart';
part 'bounding_box.g.dart';

/// Bounding box coordinates for element positioning.
@Freezed()
abstract class BoundingBox with _$BoundingBox {
  const factory BoundingBox({
    /// Left x-coordinate
    required double x0,

    /// Right x-coordinate
    required double x1,

    /// Bottom y-coordinate
    required double y0,

    /// Top y-coordinate
    required double y1,
  }) = _BoundingBox;

  factory BoundingBox.fromJson(Map<String, Object?> json) =>
      _$BoundingBoxFromJson(json);
}
