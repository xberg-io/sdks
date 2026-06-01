// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// Semantic structural classification of a text chunk.
///
/// Assigned by the heuristic classifier in `chunking::classifier`.
/// Defaults to `Unknown` when no rule matches.
/// Designed to be extended in future versions without breaking changes.
@JsonEnum()
enum ChunkType {
  @JsonValue('heading')
  heading('heading'),
  @JsonValue('party_list')
  partyList('party_list'),
  @JsonValue('definitions')
  definitions('definitions'),
  @JsonValue('operative_clause')
  operativeClause('operative_clause'),
  @JsonValue('signature_block')
  signatureBlock('signature_block'),
  @JsonValue('schedule')
  schedule('schedule'),
  @JsonValue('table_like')
  tableLike('table_like'),
  @JsonValue('formula')
  formula('formula'),
  @JsonValue('code_block')
  codeBlock('code_block'),
  @JsonValue('image')
  image('image'),
  @JsonValue('org_chart')
  orgChart('org_chart'),
  @JsonValue('diagram')
  diagram('diagram'),
  @JsonValue('unknown')
  unknown('unknown'),
  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const ChunkType(this.json);

  factory ChunkType.fromJson(String json) => values.firstWhere(
        (e) => e.json == json,
        orElse: () => $unknown,
      );

  final String? json;
  String toJson() {
    final value = json;
    if (value == null) {
      throw StateError('Cannot convert enum value with null JSON representation to String. '
          'This usually happens for \$unknown or @JsonValue(null) entries.');
    }
    return value as String;
  }

  @override
  String toString() => json?.toString() ?? super.toString();
  /// Returns all defined enum values excluding the $unknown value.
  static List<ChunkType> get $valuesDefined => values.where((value) => value != $unknown).toList();
}
