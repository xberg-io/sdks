// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_sandbox_key_response.freezed.dart';
part 'create_sandbox_key_response.g.dart';

/// Sandbox key response
@Freezed()
abstract class CreateSandboxKeyResponse with _$CreateSandboxKeyResponse {
  const factory CreateSandboxKeyResponse({
    /// The sandbox API key (use in Authorization: Bearer header)
    @JsonKey(name: 'api_key') required String apiKey,

    /// When the key expires (RFC3339 format)
    @JsonKey(name: 'expires_at') required DateTime expiresAt,

    /// Page extraction quota for this key
    @JsonKey(name: 'pages_remaining') required int pagesRemaining,
  }) = _CreateSandboxKeyResponse;

  factory CreateSandboxKeyResponse.fromJson(Map<String, Object?> json) =>
      _$CreateSandboxKeyResponseFromJson(json);
}
