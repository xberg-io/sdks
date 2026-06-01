// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_filter_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentFilterConfig _$ContentFilterConfigFromJson(Map<String, dynamic> json) =>
    _ContentFilterConfig(
      includeFooters: json['include_footers'] as bool?,
      includeHeaders: json['include_headers'] as bool?,
      includeWatermarks: json['include_watermarks'] as bool?,
      stripRepeatingText: json['strip_repeating_text'] as bool?,
    );

Map<String, dynamic> _$ContentFilterConfigToJson(
  _ContentFilterConfig instance,
) => <String, dynamic>{
  'include_footers': instance.includeFooters,
  'include_headers': instance.includeHeaders,
  'include_watermarks': instance.includeWatermarks,
  'strip_repeating_text': instance.stripRepeatingText,
};
