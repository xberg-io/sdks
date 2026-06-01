// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'bounding_box.dart';
import 'content_layer.dart';
import 'node_content.dart';
import 'node_id.dart';
import 'node_index.dart';
import 'text_annotation.dart';

part 'document_node.freezed.dart';
part 'document_node.g.dart';

/// A single node in the document tree.
///
/// Each node has deterministic `id`, typed `content`, optional `parent`/`children`.
/// for tree structure, and metadata like page number, bounding box, and content layer.
@Freezed()
abstract class DocumentNode with _$DocumentNode {
  const factory DocumentNode({
    /// Node content — tagged enum, type-specific data only.
    required NodeContent content,

    /// Deterministic identifier (hash of content + position).
    required NodeId id,

    /// Inline annotations (formatting, links) on this node's text content.
    ///
    /// Only meaningful for text-carrying nodes; empty for containers.
    List<TextAnnotation>? annotations,

    /// Format-specific key-value attributes.
    ///
    /// Extensible bag for miscellaneous data without a dedicated typed field: CSS classes,.
    /// LaTeX environment names, Excel cell formulas, slide layout names, etc.
    Map<String, String>? attributes,

    /// Bounding box in document coordinates.
    BoundingBox? bbox,

    /// Child node indices in reading order.
    List<NodeIndex>? children,

    /// Content layer classification.
    @JsonKey(name: 'content_layer')
    ContentLayer? contentLayer,

    /// Page number where this node starts (1-indexed).
    int? page,

    /// Page number where this node ends (for multi-page tables/sections).
    @JsonKey(name: 'page_end')
    int? pageEnd,

    /// Parent node index (`None` = root-level node).
    NodeIndex? parent,
  }) = _DocumentNode;
  
  factory DocumentNode.fromJson(Map<String, Object?> json) => _$DocumentNodeFromJson(json);
}
