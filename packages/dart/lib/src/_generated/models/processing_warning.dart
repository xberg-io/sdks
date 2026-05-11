// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'processing_warning.freezed.dart';
part 'processing_warning.g.dart';

/// Non-fatal processing warning.
@Freezed()
abstract class ProcessingWarning with _$ProcessingWarning {
  const factory ProcessingWarning({
    /// Warning message
    String? message,

    /// Warning source (e.g., "ocr", "pdf", "chunking")
    String? source,
  }) = _ProcessingWarning;
  
  factory ProcessingWarning.fromJson(Map<String, Object?> json) => _$ProcessingWarningFromJson(json);
}
