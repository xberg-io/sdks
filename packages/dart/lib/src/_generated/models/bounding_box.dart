// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'bounding_box.freezed.dart';
part 'bounding_box.g.dart';

/// Bounding box coordinates.
@Freezed()
abstract class BoundingBox with _$BoundingBox {
  const factory BoundingBox({
    required double x0,
    required double x1,
    required double y0,
    required double y1,
  }) = _BoundingBox;
  
  factory BoundingBox.fromJson(Map<String, Object?> json) => _$BoundingBoxFromJson(json);
}
