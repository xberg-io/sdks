// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bypass_request_override.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BypassRequestOverride _$BypassRequestOverrideFromJson(
  Map<String, dynamic> json,
) => _BypassRequestOverride(
  mode: BypassMode.fromJson(json['mode'] as String),
  vendor: json['vendor'] as String,
  credentials: json['credentials'],
);

Map<String, dynamic> _$BypassRequestOverrideToJson(
  _BypassRequestOverride instance,
) => <String, dynamic>{
  'mode': instance.mode,
  'vendor': instance.vendor,
  'credentials': instance.credentials,
};
