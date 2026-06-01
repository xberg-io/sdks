// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

/// Semantic element type classification.
///
/// Categorizes text content into semantic units for downstream processing.
/// Supports the element types commonly found in Unstructured documents.
@JsonEnum()
enum ElementType {
  @JsonValue('title')
  title('title'),
  @JsonValue('narrative_text')
  narrativeText('narrative_text'),
  @JsonValue('heading')
  heading('heading'),
  @JsonValue('list_item')
  listItem('list_item'),
  @JsonValue('table')
  table('table'),
  @JsonValue('image')
  image('image'),
  @JsonValue('page_break')
  pageBreak('page_break'),
  @JsonValue('code_block')
  codeBlock('code_block'),
  @JsonValue('block_quote')
  blockQuote('block_quote'),
  @JsonValue('footer')
  footer('footer'),
  @JsonValue('header')
  header('header'),
  /// Default value for all unparsed values, allows backward compatibility when adding new values on the backend.
  $unknown(null);

  const ElementType(this.json);

  factory ElementType.fromJson(String json) => values.firstWhere(
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
  static List<ElementType> get $valuesDefined => values.where((value) => value != $unknown).toList();
}
