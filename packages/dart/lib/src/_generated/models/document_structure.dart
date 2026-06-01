// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'document_node.dart';
import 'document_relationship.dart';

part 'document_structure.freezed.dart';
part 'document_structure.g.dart';

/// Top-level structured document representation.
///
/// A flat array of nodes with index-based parent/child references forming a tree.
/// Root-level nodes have `parent: None`. Use `body_roots()` and `furniture_roots()`.
/// to iterate over top-level content by layer.
///
/// # Validation.
///
/// Call `validate()` after construction to verify all node indices are in bounds.
/// and parent-child relationships are bidirectionally consistent.
@Freezed()
abstract class DocumentStructure with _$DocumentStructure {
  const factory DocumentStructure({
    /// All nodes in document/reading order.
    required List<DocumentNode> nodes,

    /// Sorted, deduplicated list of node type names present in this document.
    ///
    /// Each value is the snake_case `node_type` tag of the corresponding.
    /// [`NodeContent`] variant (e.g. `"paragraph"`, `"heading"`, `"table"`, …).
    ///
    /// Computed from [`nodes`] via [`DocumentStructure::finalize_node_types`].
    /// Empty until that method is called (internal construction paths call it.
    /// at the end of derivation).
    @JsonKey(name: 'node_types')
    List<String>? nodeTypes,

    /// Resolved relationships between nodes (footnote refs, citations, anchor links, etc.).
    ///
    /// Populated during derivation from the internal document representation.
    /// Empty when no relationships are detected.
    List<DocumentRelationship>? relationships,

    /// Origin format identifier (e.g. "docx", "pptx", "html", "pdf").
    ///
    /// Allows renderers to apply format-aware heuristics when converting.
    /// the document tree to output formats.
    @JsonKey(name: 'source_format')
    String? sourceFormat,
  }) = _DocumentStructure;
  
  factory DocumentStructure.fromJson(Map<String, Object?> json) => _$DocumentStructureFromJson(json);
}
