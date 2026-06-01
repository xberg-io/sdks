// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_structure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DocumentStructure {

/// All nodes in document/reading order.
 List<DocumentNode> get nodes;/// Sorted, deduplicated list of node type names present in this document.
///
/// Each value is the snake_case `node_type` tag of the corresponding.
/// [`NodeContent`] variant (e.g. `"paragraph"`, `"heading"`, `"table"`, …).
///
/// Computed from [`nodes`] via [`DocumentStructure::finalize_node_types`].
/// Empty until that method is called (internal construction paths call it.
/// at the end of derivation).
@JsonKey(name: 'node_types') List<String>? get nodeTypes;/// Resolved relationships between nodes (footnote refs, citations, anchor links, etc.).
///
/// Populated during derivation from the internal document representation.
/// Empty when no relationships are detected.
 List<DocumentRelationship>? get relationships;/// Origin format identifier (e.g. "docx", "pptx", "html", "pdf").
///
/// Allows renderers to apply format-aware heuristics when converting.
/// the document tree to output formats.
@JsonKey(name: 'source_format') String? get sourceFormat;
/// Create a copy of DocumentStructure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentStructureCopyWith<DocumentStructure> get copyWith => _$DocumentStructureCopyWithImpl<DocumentStructure>(this as DocumentStructure, _$identity);

  /// Serializes this DocumentStructure to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentStructure&&const DeepCollectionEquality().equals(other.nodes, nodes)&&const DeepCollectionEquality().equals(other.nodeTypes, nodeTypes)&&const DeepCollectionEquality().equals(other.relationships, relationships)&&(identical(other.sourceFormat, sourceFormat) || other.sourceFormat == sourceFormat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(nodes),const DeepCollectionEquality().hash(nodeTypes),const DeepCollectionEquality().hash(relationships),sourceFormat);

@override
String toString() {
  return 'DocumentStructure(nodes: $nodes, nodeTypes: $nodeTypes, relationships: $relationships, sourceFormat: $sourceFormat)';
}


}

/// @nodoc
abstract mixin class $DocumentStructureCopyWith<$Res>  {
  factory $DocumentStructureCopyWith(DocumentStructure value, $Res Function(DocumentStructure) _then) = _$DocumentStructureCopyWithImpl;
@useResult
$Res call({
 List<DocumentNode> nodes,@JsonKey(name: 'node_types') List<String>? nodeTypes, List<DocumentRelationship>? relationships,@JsonKey(name: 'source_format') String? sourceFormat
});




}
/// @nodoc
class _$DocumentStructureCopyWithImpl<$Res>
    implements $DocumentStructureCopyWith<$Res> {
  _$DocumentStructureCopyWithImpl(this._self, this._then);

  final DocumentStructure _self;
  final $Res Function(DocumentStructure) _then;

/// Create a copy of DocumentStructure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nodes = null,Object? nodeTypes = freezed,Object? relationships = freezed,Object? sourceFormat = freezed,}) {
  return _then(_self.copyWith(
nodes: null == nodes ? _self.nodes : nodes // ignore: cast_nullable_to_non_nullable
as List<DocumentNode>,nodeTypes: freezed == nodeTypes ? _self.nodeTypes : nodeTypes // ignore: cast_nullable_to_non_nullable
as List<String>?,relationships: freezed == relationships ? _self.relationships : relationships // ignore: cast_nullable_to_non_nullable
as List<DocumentRelationship>?,sourceFormat: freezed == sourceFormat ? _self.sourceFormat : sourceFormat // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DocumentStructure].
extension DocumentStructurePatterns on DocumentStructure {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DocumentStructure value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DocumentStructure() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DocumentStructure value)  $default,){
final _that = this;
switch (_that) {
case _DocumentStructure():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DocumentStructure value)?  $default,){
final _that = this;
switch (_that) {
case _DocumentStructure() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DocumentNode> nodes, @JsonKey(name: 'node_types')  List<String>? nodeTypes,  List<DocumentRelationship>? relationships, @JsonKey(name: 'source_format')  String? sourceFormat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DocumentStructure() when $default != null:
return $default(_that.nodes,_that.nodeTypes,_that.relationships,_that.sourceFormat);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DocumentNode> nodes, @JsonKey(name: 'node_types')  List<String>? nodeTypes,  List<DocumentRelationship>? relationships, @JsonKey(name: 'source_format')  String? sourceFormat)  $default,) {final _that = this;
switch (_that) {
case _DocumentStructure():
return $default(_that.nodes,_that.nodeTypes,_that.relationships,_that.sourceFormat);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DocumentNode> nodes, @JsonKey(name: 'node_types')  List<String>? nodeTypes,  List<DocumentRelationship>? relationships, @JsonKey(name: 'source_format')  String? sourceFormat)?  $default,) {final _that = this;
switch (_that) {
case _DocumentStructure() when $default != null:
return $default(_that.nodes,_that.nodeTypes,_that.relationships,_that.sourceFormat);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DocumentStructure implements DocumentStructure {
  const _DocumentStructure({required final  List<DocumentNode> nodes, @JsonKey(name: 'node_types') final  List<String>? nodeTypes, final  List<DocumentRelationship>? relationships, @JsonKey(name: 'source_format') this.sourceFormat}): _nodes = nodes,_nodeTypes = nodeTypes,_relationships = relationships;
  factory _DocumentStructure.fromJson(Map<String, dynamic> json) => _$DocumentStructureFromJson(json);

/// All nodes in document/reading order.
 final  List<DocumentNode> _nodes;
/// All nodes in document/reading order.
@override List<DocumentNode> get nodes {
  if (_nodes is EqualUnmodifiableListView) return _nodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nodes);
}

/// Sorted, deduplicated list of node type names present in this document.
///
/// Each value is the snake_case `node_type` tag of the corresponding.
/// [`NodeContent`] variant (e.g. `"paragraph"`, `"heading"`, `"table"`, …).
///
/// Computed from [`nodes`] via [`DocumentStructure::finalize_node_types`].
/// Empty until that method is called (internal construction paths call it.
/// at the end of derivation).
 final  List<String>? _nodeTypes;
/// Sorted, deduplicated list of node type names present in this document.
///
/// Each value is the snake_case `node_type` tag of the corresponding.
/// [`NodeContent`] variant (e.g. `"paragraph"`, `"heading"`, `"table"`, …).
///
/// Computed from [`nodes`] via [`DocumentStructure::finalize_node_types`].
/// Empty until that method is called (internal construction paths call it.
/// at the end of derivation).
@override@JsonKey(name: 'node_types') List<String>? get nodeTypes {
  final value = _nodeTypes;
  if (value == null) return null;
  if (_nodeTypes is EqualUnmodifiableListView) return _nodeTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Resolved relationships between nodes (footnote refs, citations, anchor links, etc.).
///
/// Populated during derivation from the internal document representation.
/// Empty when no relationships are detected.
 final  List<DocumentRelationship>? _relationships;
/// Resolved relationships between nodes (footnote refs, citations, anchor links, etc.).
///
/// Populated during derivation from the internal document representation.
/// Empty when no relationships are detected.
@override List<DocumentRelationship>? get relationships {
  final value = _relationships;
  if (value == null) return null;
  if (_relationships is EqualUnmodifiableListView) return _relationships;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Origin format identifier (e.g. "docx", "pptx", "html", "pdf").
///
/// Allows renderers to apply format-aware heuristics when converting.
/// the document tree to output formats.
@override@JsonKey(name: 'source_format') final  String? sourceFormat;

/// Create a copy of DocumentStructure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentStructureCopyWith<_DocumentStructure> get copyWith => __$DocumentStructureCopyWithImpl<_DocumentStructure>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentStructureToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentStructure&&const DeepCollectionEquality().equals(other._nodes, _nodes)&&const DeepCollectionEquality().equals(other._nodeTypes, _nodeTypes)&&const DeepCollectionEquality().equals(other._relationships, _relationships)&&(identical(other.sourceFormat, sourceFormat) || other.sourceFormat == sourceFormat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_nodes),const DeepCollectionEquality().hash(_nodeTypes),const DeepCollectionEquality().hash(_relationships),sourceFormat);

@override
String toString() {
  return 'DocumentStructure(nodes: $nodes, nodeTypes: $nodeTypes, relationships: $relationships, sourceFormat: $sourceFormat)';
}


}

/// @nodoc
abstract mixin class _$DocumentStructureCopyWith<$Res> implements $DocumentStructureCopyWith<$Res> {
  factory _$DocumentStructureCopyWith(_DocumentStructure value, $Res Function(_DocumentStructure) _then) = __$DocumentStructureCopyWithImpl;
@override @useResult
$Res call({
 List<DocumentNode> nodes,@JsonKey(name: 'node_types') List<String>? nodeTypes, List<DocumentRelationship>? relationships,@JsonKey(name: 'source_format') String? sourceFormat
});




}
/// @nodoc
class __$DocumentStructureCopyWithImpl<$Res>
    implements _$DocumentStructureCopyWith<$Res> {
  __$DocumentStructureCopyWithImpl(this._self, this._then);

  final _DocumentStructure _self;
  final $Res Function(_DocumentStructure) _then;

/// Create a copy of DocumentStructure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nodes = null,Object? nodeTypes = freezed,Object? relationships = freezed,Object? sourceFormat = freezed,}) {
  return _then(_DocumentStructure(
nodes: null == nodes ? _self._nodes : nodes // ignore: cast_nullable_to_non_nullable
as List<DocumentNode>,nodeTypes: freezed == nodeTypes ? _self._nodeTypes : nodeTypes // ignore: cast_nullable_to_non_nullable
as List<String>?,relationships: freezed == relationships ? _self._relationships : relationships // ignore: cast_nullable_to_non_nullable
as List<DocumentRelationship>?,sourceFormat: freezed == sourceFormat ? _self.sourceFormat : sourceFormat // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
