// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'processing_warning.freezed.dart';
part 'processing_warning.g.dart';

/// A non-fatal warning from a processing pipeline stage.
///
/// Captures errors from optional features that don't prevent extraction.
/// but may indicate degraded results.
@Freezed()
abstract class ProcessingWarning with _$ProcessingWarning {
  const factory ProcessingWarning({
    /// Human-readable description of what went wrong.
    required String message,

    /// The pipeline stage or feature that produced this warning.
    /// (e.g., "embedding", "chunking", "language_detection", "output_format").
    required String source,
  }) = _ProcessingWarning;
  
  factory ProcessingWarning.fromJson(Map<String, Object?> json) => _$ProcessingWarningFromJson(json);
}
