// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proxy_override.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProxyOverride _$ProxyOverrideFromJson(Map<String, dynamic> json) =>
    _ProxyOverride(
      url: json['url'] as String,
      password: json['password'] as String?,
      username: json['username'] as String?,
    );

Map<String, dynamic> _$ProxyOverrideToJson(_ProxyOverride instance) =>
    <String, dynamic>{
      'url': instance.url,
      'password': instance.password,
      'username': instance.username,
    };
