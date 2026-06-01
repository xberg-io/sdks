// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sandbox_error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SandboxErrorResponse _$SandboxErrorResponseFromJson(
  Map<String, dynamic> json,
) => _SandboxErrorResponse(
  error: json['error'] as String,
  message: json['message'] as String,
);

Map<String, dynamic> _$SandboxErrorResponseToJson(
  _SandboxErrorResponse instance,
) => <String, dynamic>{'error': instance.error, 'message': instance.message};
