// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'browser_overrides.freezed.dart';
part 'browser_overrides.g.dart';

/// Browser rendering overrides for a specific crawl request.
/// Allows per-request override of browser backend, mode, and stealth settings.
@Freezed()
abstract class BrowserOverrides with _$BrowserOverrides {
  const factory BrowserOverrides({
    /// Browser backend: "native" (lightweight Rust-based) or "chromiumoxide" (Chrome-based)
    String? backend,

    /// Browser mode: "auto" (default, use browser if needed), "always" (always use), or "never" (never use)
    String? mode,

    /// Enable browser stealth mode (TLS fingerprint + UA spoof) — only honored by native backend
    bool? stealth,
  }) = _BrowserOverrides;

  factory BrowserOverrides.fromJson(Map<String, Object?> json) =>
      _$BrowserOverridesFromJson(json);
}
