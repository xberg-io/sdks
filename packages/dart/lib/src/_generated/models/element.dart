// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'element_id.dart';
import 'element_metadata.dart';
import 'element_type.dart';

part 'element.freezed.dart';
part 'element.g.dart';

/// Semantic element extracted from document.
///
/// Represents a logical unit of content with semantic classification,.
/// unique identifier, and metadata for tracking origin and position.
@Freezed()
abstract class Element with _$Element {
  const factory Element({
    /// Unique element identifier
    @JsonKey(name: 'element_id')
    required ElementId elementId,

    /// Semantic type of this element
    @JsonKey(name: 'element_type')
    required ElementType elementType,

    /// Metadata about the element
    required ElementMetadata metadata,

    /// Text content of the element
    required String text,
  }) = _Element;
  
  factory Element.fromJson(Map<String, Object?> json) => _$ElementFromJson(json);
}
