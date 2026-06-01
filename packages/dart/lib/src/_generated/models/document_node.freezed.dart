// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_node.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DocumentNode {

/// Node content — tagged enum, type-specific data only.
 NodeContent get content;/// Deterministic identifier (hash of content + position).
 NodeId get id;/// Inline annotations (formatting, links) on this node's text content.
///
/// Only meaningful for text-carrying nodes; empty for containers.
 List<TextAnnotation>? get annotations;/// Format-specific key-value attributes.
///
/// Extensible bag for miscellaneous data without a dedicated typed field: CSS classes,.
/// LaTeX environment names, Excel cell formulas, slide layout names, etc.
 Map<String, String>? get attributes;/// Bounding box in document coordinates.
 BoundingBox? get bbox;/// Child node indices in reading order.
 List<NodeIndex>? get children;/// Content layer classification.
@JsonKey(name: 'content_layer') ContentLayer? get contentLayer;/// Page number where this node starts (1-indexed).
 int? get page;/// Page number where this node ends (for multi-page tables/sections).
@JsonKey(name: 'page_end') int? get pageEnd;/// Parent node index (`None` = root-level node).
 NodeIndex? get parent;
/// Create a copy of DocumentNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentNodeCopyWith<DocumentNode> get copyWith => _$DocumentNodeCopyWithImpl<DocumentNode>(this as DocumentNode, _$identity);

  /// Serializes this DocumentNode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentNode&&(identical(other.content, content) || other.content == content)&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.annotations, annotations)&&const DeepCollectionEquality().equals(other.attributes, attributes)&&(identical(other.bbox, bbox) || other.bbox == bbox)&&const DeepCollectionEquality().equals(other.children, children)&&(identical(other.contentLayer, contentLayer) || other.contentLayer == contentLayer)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageEnd, pageEnd) || other.pageEnd == pageEnd)&&(identical(other.parent, parent) || other.parent == parent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,id,const DeepCollectionEquality().hash(annotations),const DeepCollectionEquality().hash(attributes),bbox,const DeepCollectionEquality().hash(children),contentLayer,page,pageEnd,parent);

@override
String toString() {
  return 'DocumentNode(content: $content, id: $id, annotations: $annotations, attributes: $attributes, bbox: $bbox, children: $children, contentLayer: $contentLayer, page: $page, pageEnd: $pageEnd, parent: $parent)';
}


}

/// @nodoc
abstract mixin class $DocumentNodeCopyWith<$Res>  {
  factory $DocumentNodeCopyWith(DocumentNode value, $Res Function(DocumentNode) _then) = _$DocumentNodeCopyWithImpl;
@useResult
$Res call({
 NodeContent content, NodeId id, List<TextAnnotation>? annotations, Map<String, String>? attributes, BoundingBox? bbox, List<NodeIndex>? children,@JsonKey(name: 'content_layer') ContentLayer? contentLayer, int? page,@JsonKey(name: 'page_end') int? pageEnd, NodeIndex? parent
});


$NodeContentCopyWith<$Res> get content;$BoundingBoxCopyWith<$Res>? get bbox;

}
/// @nodoc
class _$DocumentNodeCopyWithImpl<$Res>
    implements $DocumentNodeCopyWith<$Res> {
  _$DocumentNodeCopyWithImpl(this._self, this._then);

  final DocumentNode _self;
  final $Res Function(DocumentNode) _then;

/// Create a copy of DocumentNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,Object? id = null,Object? annotations = freezed,Object? attributes = freezed,Object? bbox = freezed,Object? children = freezed,Object? contentLayer = freezed,Object? page = freezed,Object? pageEnd = freezed,Object? parent = freezed,}) {
  return _then(_self.copyWith(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as NodeContent,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as NodeId,annotations: freezed == annotations ? _self.annotations : annotations // ignore: cast_nullable_to_non_nullable
as List<TextAnnotation>?,attributes: freezed == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,bbox: freezed == bbox ? _self.bbox : bbox // ignore: cast_nullable_to_non_nullable
as BoundingBox?,children: freezed == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<NodeIndex>?,contentLayer: freezed == contentLayer ? _self.contentLayer : contentLayer // ignore: cast_nullable_to_non_nullable
as ContentLayer?,page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int?,pageEnd: freezed == pageEnd ? _self.pageEnd : pageEnd // ignore: cast_nullable_to_non_nullable
as int?,parent: freezed == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as NodeIndex?,
  ));
}
/// Create a copy of DocumentNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NodeContentCopyWith<$Res> get content {
  
  return $NodeContentCopyWith<$Res>(_self.content, (value) {
    return _then(_self.copyWith(content: value));
  });
}/// Create a copy of DocumentNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoundingBoxCopyWith<$Res>? get bbox {
    if (_self.bbox == null) {
    return null;
  }

  return $BoundingBoxCopyWith<$Res>(_self.bbox!, (value) {
    return _then(_self.copyWith(bbox: value));
  });
}
}


/// Adds pattern-matching-related methods to [DocumentNode].
extension DocumentNodePatterns on DocumentNode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DocumentNode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DocumentNode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DocumentNode value)  $default,){
final _that = this;
switch (_that) {
case _DocumentNode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DocumentNode value)?  $default,){
final _that = this;
switch (_that) {
case _DocumentNode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NodeContent content,  NodeId id,  List<TextAnnotation>? annotations,  Map<String, String>? attributes,  BoundingBox? bbox,  List<NodeIndex>? children, @JsonKey(name: 'content_layer')  ContentLayer? contentLayer,  int? page, @JsonKey(name: 'page_end')  int? pageEnd,  NodeIndex? parent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DocumentNode() when $default != null:
return $default(_that.content,_that.id,_that.annotations,_that.attributes,_that.bbox,_that.children,_that.contentLayer,_that.page,_that.pageEnd,_that.parent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NodeContent content,  NodeId id,  List<TextAnnotation>? annotations,  Map<String, String>? attributes,  BoundingBox? bbox,  List<NodeIndex>? children, @JsonKey(name: 'content_layer')  ContentLayer? contentLayer,  int? page, @JsonKey(name: 'page_end')  int? pageEnd,  NodeIndex? parent)  $default,) {final _that = this;
switch (_that) {
case _DocumentNode():
return $default(_that.content,_that.id,_that.annotations,_that.attributes,_that.bbox,_that.children,_that.contentLayer,_that.page,_that.pageEnd,_that.parent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NodeContent content,  NodeId id,  List<TextAnnotation>? annotations,  Map<String, String>? attributes,  BoundingBox? bbox,  List<NodeIndex>? children, @JsonKey(name: 'content_layer')  ContentLayer? contentLayer,  int? page, @JsonKey(name: 'page_end')  int? pageEnd,  NodeIndex? parent)?  $default,) {final _that = this;
switch (_that) {
case _DocumentNode() when $default != null:
return $default(_that.content,_that.id,_that.annotations,_that.attributes,_that.bbox,_that.children,_that.contentLayer,_that.page,_that.pageEnd,_that.parent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DocumentNode implements DocumentNode {
  const _DocumentNode({required this.content, required this.id, final  List<TextAnnotation>? annotations, final  Map<String, String>? attributes, this.bbox, final  List<NodeIndex>? children, @JsonKey(name: 'content_layer') this.contentLayer, this.page, @JsonKey(name: 'page_end') this.pageEnd, this.parent}): _annotations = annotations,_attributes = attributes,_children = children;
  factory _DocumentNode.fromJson(Map<String, dynamic> json) => _$DocumentNodeFromJson(json);

/// Node content — tagged enum, type-specific data only.
@override final  NodeContent content;
/// Deterministic identifier (hash of content + position).
@override final  NodeId id;
/// Inline annotations (formatting, links) on this node's text content.
///
/// Only meaningful for text-carrying nodes; empty for containers.
 final  List<TextAnnotation>? _annotations;
/// Inline annotations (formatting, links) on this node's text content.
///
/// Only meaningful for text-carrying nodes; empty for containers.
@override List<TextAnnotation>? get annotations {
  final value = _annotations;
  if (value == null) return null;
  if (_annotations is EqualUnmodifiableListView) return _annotations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Format-specific key-value attributes.
///
/// Extensible bag for miscellaneous data without a dedicated typed field: CSS classes,.
/// LaTeX environment names, Excel cell formulas, slide layout names, etc.
 final  Map<String, String>? _attributes;
/// Format-specific key-value attributes.
///
/// Extensible bag for miscellaneous data without a dedicated typed field: CSS classes,.
/// LaTeX environment names, Excel cell formulas, slide layout names, etc.
@override Map<String, String>? get attributes {
  final value = _attributes;
  if (value == null) return null;
  if (_attributes is EqualUnmodifiableMapView) return _attributes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Bounding box in document coordinates.
@override final  BoundingBox? bbox;
/// Child node indices in reading order.
 final  List<NodeIndex>? _children;
/// Child node indices in reading order.
@override List<NodeIndex>? get children {
  final value = _children;
  if (value == null) return null;
  if (_children is EqualUnmodifiableListView) return _children;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Content layer classification.
@override@JsonKey(name: 'content_layer') final  ContentLayer? contentLayer;
/// Page number where this node starts (1-indexed).
@override final  int? page;
/// Page number where this node ends (for multi-page tables/sections).
@override@JsonKey(name: 'page_end') final  int? pageEnd;
/// Parent node index (`None` = root-level node).
@override final  NodeIndex? parent;

/// Create a copy of DocumentNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentNodeCopyWith<_DocumentNode> get copyWith => __$DocumentNodeCopyWithImpl<_DocumentNode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentNodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentNode&&(identical(other.content, content) || other.content == content)&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._annotations, _annotations)&&const DeepCollectionEquality().equals(other._attributes, _attributes)&&(identical(other.bbox, bbox) || other.bbox == bbox)&&const DeepCollectionEquality().equals(other._children, _children)&&(identical(other.contentLayer, contentLayer) || other.contentLayer == contentLayer)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageEnd, pageEnd) || other.pageEnd == pageEnd)&&(identical(other.parent, parent) || other.parent == parent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,id,const DeepCollectionEquality().hash(_annotations),const DeepCollectionEquality().hash(_attributes),bbox,const DeepCollectionEquality().hash(_children),contentLayer,page,pageEnd,parent);

@override
String toString() {
  return 'DocumentNode(content: $content, id: $id, annotations: $annotations, attributes: $attributes, bbox: $bbox, children: $children, contentLayer: $contentLayer, page: $page, pageEnd: $pageEnd, parent: $parent)';
}


}

/// @nodoc
abstract mixin class _$DocumentNodeCopyWith<$Res> implements $DocumentNodeCopyWith<$Res> {
  factory _$DocumentNodeCopyWith(_DocumentNode value, $Res Function(_DocumentNode) _then) = __$DocumentNodeCopyWithImpl;
@override @useResult
$Res call({
 NodeContent content, NodeId id, List<TextAnnotation>? annotations, Map<String, String>? attributes, BoundingBox? bbox, List<NodeIndex>? children,@JsonKey(name: 'content_layer') ContentLayer? contentLayer, int? page,@JsonKey(name: 'page_end') int? pageEnd, NodeIndex? parent
});


@override $NodeContentCopyWith<$Res> get content;@override $BoundingBoxCopyWith<$Res>? get bbox;

}
/// @nodoc
class __$DocumentNodeCopyWithImpl<$Res>
    implements _$DocumentNodeCopyWith<$Res> {
  __$DocumentNodeCopyWithImpl(this._self, this._then);

  final _DocumentNode _self;
  final $Res Function(_DocumentNode) _then;

/// Create a copy of DocumentNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = null,Object? id = null,Object? annotations = freezed,Object? attributes = freezed,Object? bbox = freezed,Object? children = freezed,Object? contentLayer = freezed,Object? page = freezed,Object? pageEnd = freezed,Object? parent = freezed,}) {
  return _then(_DocumentNode(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as NodeContent,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as NodeId,annotations: freezed == annotations ? _self._annotations : annotations // ignore: cast_nullable_to_non_nullable
as List<TextAnnotation>?,attributes: freezed == attributes ? _self._attributes : attributes // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,bbox: freezed == bbox ? _self.bbox : bbox // ignore: cast_nullable_to_non_nullable
as BoundingBox?,children: freezed == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<NodeIndex>?,contentLayer: freezed == contentLayer ? _self.contentLayer : contentLayer // ignore: cast_nullable_to_non_nullable
as ContentLayer?,page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int?,pageEnd: freezed == pageEnd ? _self.pageEnd : pageEnd // ignore: cast_nullable_to_non_nullable
as int?,parent: freezed == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as NodeIndex?,
  ));
}

/// Create a copy of DocumentNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NodeContentCopyWith<$Res> get content {
  
  return $NodeContentCopyWith<$Res>(_self.content, (value) {
    return _then(_self.copyWith(content: value));
  });
}/// Create a copy of DocumentNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoundingBoxCopyWith<$Res>? get bbox {
    if (_self.bbox == null) {
    return null;
  }

  return $BoundingBoxCopyWith<$Res>(_self.bbox!, (value) {
    return _then(_self.copyWith(bbox: value));
  });
}
}

// dart format on
