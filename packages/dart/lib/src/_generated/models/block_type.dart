// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// Types of block-level elements in Djot.
@JsonEnum()
enum BlockType {
  @JsonValue('paragraph')
  paragraph('paragraph'),
  @JsonValue('heading')
  heading('heading'),
  @JsonValue('blockquote')
  blockquote('blockquote'),
  @JsonValue('code_block')
  codeBlock('code_block'),
  @JsonValue('list_item')
  listItem('list_item'),
  @JsonValue('ordered_list')
  orderedList('ordered_list'),
  @JsonValue('bullet_list')
  bulletList('bullet_list'),
  @JsonValue('task_list')
  taskList('task_list'),
  @JsonValue('definition_list')
  definitionList('definition_list'),
  @JsonValue('definition_term')
  definitionTerm('definition_term'),
  @JsonValue('definition_description')
  definitionDescription('definition_description'),
  @JsonValue('div')
  div('div'),
  @JsonValue('section')
  section('section'),
  @JsonValue('thematic_break')
  thematicBreak('thematic_break'),
  @JsonValue('raw_block')
  rawBlock('raw_block'),
  @JsonValue('math_display')
  mathDisplay('math_display'),
  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const BlockType(this.json);

  factory BlockType.fromJson(String json) => values.firstWhere(
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
  static List<BlockType> get $valuesDefined => values.where((value) => value != $unknown).toList();
}
