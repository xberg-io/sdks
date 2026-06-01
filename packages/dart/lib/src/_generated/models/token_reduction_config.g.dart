// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_reduction_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TokenReductionConfig _$TokenReductionConfigFromJson(
  Map<String, dynamic> json,
) => _TokenReductionConfig(
  mode: json['mode'] as String?,
  preserveImportantWords: json['preserve_important_words'] as bool?,
);

Map<String, dynamic> _$TokenReductionConfigToJson(
  _TokenReductionConfig instance,
) => <String, dynamic>{
  'mode': instance.mode,
  'preserve_important_words': instance.preserveImportantWords,
};
