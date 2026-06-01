// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'node_index.dart';
import 'relationship_kind.dart';

part 'document_relationship.freezed.dart';
part 'document_relationship.g.dart';

/// A resolved relationship between two nodes in the document tree.
@Freezed()
abstract class DocumentRelationship with _$DocumentRelationship {
  const factory DocumentRelationship({
    /// Semantic kind of the relationship.
    required RelationshipKind kind,

    /// Source node index (the referencing node).
    required NodeIndex source,

    /// Target node index (the referenced node).
    required NodeIndex target,
  }) = _DocumentRelationship;
  
  factory DocumentRelationship.fromJson(Map<String, Object?> json) => _$DocumentRelationshipFromJson(json);
}
