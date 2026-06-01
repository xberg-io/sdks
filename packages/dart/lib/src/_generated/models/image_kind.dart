// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// Heuristic classification of what an image likely depicts.
@JsonEnum()
enum ImageKind {
  @JsonValue('photograph')
  photograph('photograph'),
  @JsonValue('diagram')
  diagram('diagram'),
  @JsonValue('chart')
  chart('chart'),
  @JsonValue('drawing')
  drawing('drawing'),
  @JsonValue('text_block')
  textBlock('text_block'),
  @JsonValue('decoration')
  decoration('decoration'),
  @JsonValue('logo')
  logo('logo'),
  @JsonValue('icon')
  icon('icon'),
  @JsonValue('tile_fragment')
  tileFragment('tile_fragment'),
  @JsonValue('mask')
  mask('mask'),
  @JsonValue('page_raster')
  pageRaster('page_raster'),
  @JsonValue('unknown')
  unknown('unknown'),

  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const ImageKind(this.json);

  factory ImageKind.fromJson(String json) =>
      values.firstWhere((e) => e.json == json, orElse: () => $unknown);

  final String? json;
  String toJson() {
    final value = json;
    if (value == null) {
      throw StateError(
        'Cannot convert enum value with null JSON representation to String. '
        'This usually happens for \$unknown or @JsonValue(null) entries.',
      );
    }
    return value as String;
  }

  @override
  String toString() => json?.toString() ?? super.toString();

  /// Returns all defined enum values excluding the $unknown value.
  static List<ImageKind> get $valuesDefined =>
      values.where((value) => value != $unknown).toList();
}
