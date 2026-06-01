// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_processor_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostProcessorConfig _$PostProcessorConfigFromJson(Map<String, dynamic> json) =>
    _PostProcessorConfig(
      disabledProcessors: (json['disabled_processors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      enabled: json['enabled'] as bool?,
      enabledProcessors: (json['enabled_processors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PostProcessorConfigToJson(
  _PostProcessorConfig instance,
) => <String, dynamic>{
  'disabled_processors': instance.disabledProcessors,
  'enabled': instance.enabled,
  'enabled_processors': instance.enabledProcessors,
};
