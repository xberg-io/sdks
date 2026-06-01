// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_sandbox_key_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateSandboxKeyResponse _$CreateSandboxKeyResponseFromJson(
  Map<String, dynamic> json,
) => _CreateSandboxKeyResponse(
  apiKey: json['api_key'] as String,
  expiresAt: DateTime.parse(json['expires_at'] as String),
  pagesRemaining: (json['pages_remaining'] as num).toInt(),
);

Map<String, dynamic> _$CreateSandboxKeyResponseToJson(
  _CreateSandboxKeyResponse instance,
) => <String, dynamic>{
  'api_key': instance.apiKey,
  'expires_at': instance.expiresAt.toIso8601String(),
  'pages_remaining': instance.pagesRemaining,
};
