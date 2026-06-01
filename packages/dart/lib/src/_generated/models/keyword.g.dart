// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyword.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Keyword _$KeywordFromJson(Map<String, dynamic> json) => _Keyword(
  algorithm: KeywordAlgorithm.fromJson(json['algorithm'] as String),
  score: (json['score'] as num).toDouble(),
  text: json['text'] as String,
  positions: (json['positions'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$KeywordToJson(_Keyword instance) => <String, dynamic>{
  'algorithm': instance.algorithm,
  'score': instance.score,
  'text': instance.text,
  'positions': instance.positions,
};
