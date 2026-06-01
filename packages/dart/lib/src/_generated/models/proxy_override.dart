// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'proxy_override.freezed.dart';
part 'proxy_override.g.dart';

/// Per-request proxy override. When set on a crawl request, this proxy is.
/// used instead of the worker's process-wide `CRAWL_PROXY_URLS` pool.
/// Maps 1:1 onto `kreuzcrawl::ProxyConfig`.
@Freezed()
abstract class ProxyOverride with _$ProxyOverride {
  const factory ProxyOverride({
    /// Full proxy URL — `http://`, `https://`, `socks5://` or `socks5h://`.
    required String url,

    /// Optional password for proxy auth.
    String? password,

    /// Optional username for proxy auth.
    String? username,
  }) = _ProxyOverride;
  
  factory ProxyOverride.fromJson(Map<String, Object?> json) => _$ProxyOverrideFromJson(json);
}
