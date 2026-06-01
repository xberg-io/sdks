// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'bounding_box.dart';
import 'pdf_annotation_type.dart';

part 'pdf_annotation.freezed.dart';
part 'pdf_annotation.g.dart';

/// A PDF annotation extracted from a document page.
@Freezed()
abstract class PdfAnnotation with _$PdfAnnotation {
  const factory PdfAnnotation({
    /// The type of annotation.
    @JsonKey(name: 'annotation_type')
    required PdfAnnotationType annotationType,

    /// Page number where the annotation appears (1-indexed).
    @JsonKey(name: 'page_number')
    required int pageNumber,

    /// Bounding box of the annotation on the page.
    @JsonKey(name: 'bounding_box')
    BoundingBox? boundingBox,

    /// Text content of the annotation (e.g., comment text, link URL).
    String? content,
  }) = _PdfAnnotation;
  
  factory PdfAnnotation.fromJson(Map<String, Object?> json) => _$PdfAnnotationFromJson(json);
}
