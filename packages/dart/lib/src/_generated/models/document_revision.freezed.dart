// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_revision.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DocumentRevision {

/// The content changes that make up this revision.
 RevisionDelta get delta;/// Semantic kind of this revision.
 RevisionKind get kind;/// Format-specific revision identifier.
///
/// For DOCX this is the `w:id` attribute value on the change element.
/// (e.g. `"42"`). When the attribute is absent a synthetic fallback is.
/// generated (`"docx-ins-0"`, `"docx-del-3"`, …).
@JsonKey(name: 'revision_id') String get revisionId;/// Best-effort document location for this revision.
///
/// Resolution is format-dependent and may be `None` when the location.
/// cannot be determined (e.g. changes inside table cells before.
/// table-cell anchor support is added).
 RevisionAnchor? get anchor;/// Display name of the author who made this change, when available.
 String? get author;/// ISO-8601 timestamp of the change, when available.
///
/// Stored as a plain string so this type remains FFI-friendly and.
/// unconditionally available without the `chrono` optional dep.
/// DOCX populates this from the `w:date` attribute (e.g.
/// `"2024-03-15T10:30:00Z"`).
 String? get timestamp;
/// Create a copy of DocumentRevision
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentRevisionCopyWith<DocumentRevision> get copyWith => _$DocumentRevisionCopyWithImpl<DocumentRevision>(this as DocumentRevision, _$identity);

  /// Serializes this DocumentRevision to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentRevision&&(identical(other.delta, delta) || other.delta == delta)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.revisionId, revisionId) || other.revisionId == revisionId)&&(identical(other.anchor, anchor) || other.anchor == anchor)&&(identical(other.author, author) || other.author == author)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,delta,kind,revisionId,anchor,author,timestamp);

@override
String toString() {
  return 'DocumentRevision(delta: $delta, kind: $kind, revisionId: $revisionId, anchor: $anchor, author: $author, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $DocumentRevisionCopyWith<$Res>  {
  factory $DocumentRevisionCopyWith(DocumentRevision value, $Res Function(DocumentRevision) _then) = _$DocumentRevisionCopyWithImpl;
@useResult
$Res call({
 RevisionDelta delta, RevisionKind kind,@JsonKey(name: 'revision_id') String revisionId, RevisionAnchor? anchor, String? author, String? timestamp
});


$RevisionDeltaCopyWith<$Res> get delta;$RevisionAnchorCopyWith<$Res>? get anchor;

}
/// @nodoc
class _$DocumentRevisionCopyWithImpl<$Res>
    implements $DocumentRevisionCopyWith<$Res> {
  _$DocumentRevisionCopyWithImpl(this._self, this._then);

  final DocumentRevision _self;
  final $Res Function(DocumentRevision) _then;

/// Create a copy of DocumentRevision
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? delta = null,Object? kind = null,Object? revisionId = null,Object? anchor = freezed,Object? author = freezed,Object? timestamp = freezed,}) {
  return _then(_self.copyWith(
delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as RevisionDelta,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as RevisionKind,revisionId: null == revisionId ? _self.revisionId : revisionId // ignore: cast_nullable_to_non_nullable
as String,anchor: freezed == anchor ? _self.anchor : anchor // ignore: cast_nullable_to_non_nullable
as RevisionAnchor?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of DocumentRevision
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RevisionDeltaCopyWith<$Res> get delta {
  
  return $RevisionDeltaCopyWith<$Res>(_self.delta, (value) {
    return _then(_self.copyWith(delta: value));
  });
}/// Create a copy of DocumentRevision
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RevisionAnchorCopyWith<$Res>? get anchor {
    if (_self.anchor == null) {
    return null;
  }

  return $RevisionAnchorCopyWith<$Res>(_self.anchor!, (value) {
    return _then(_self.copyWith(anchor: value));
  });
}
}


/// Adds pattern-matching-related methods to [DocumentRevision].
extension DocumentRevisionPatterns on DocumentRevision {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DocumentRevision value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DocumentRevision() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DocumentRevision value)  $default,){
final _that = this;
switch (_that) {
case _DocumentRevision():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DocumentRevision value)?  $default,){
final _that = this;
switch (_that) {
case _DocumentRevision() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RevisionDelta delta,  RevisionKind kind, @JsonKey(name: 'revision_id')  String revisionId,  RevisionAnchor? anchor,  String? author,  String? timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DocumentRevision() when $default != null:
return $default(_that.delta,_that.kind,_that.revisionId,_that.anchor,_that.author,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RevisionDelta delta,  RevisionKind kind, @JsonKey(name: 'revision_id')  String revisionId,  RevisionAnchor? anchor,  String? author,  String? timestamp)  $default,) {final _that = this;
switch (_that) {
case _DocumentRevision():
return $default(_that.delta,_that.kind,_that.revisionId,_that.anchor,_that.author,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RevisionDelta delta,  RevisionKind kind, @JsonKey(name: 'revision_id')  String revisionId,  RevisionAnchor? anchor,  String? author,  String? timestamp)?  $default,) {final _that = this;
switch (_that) {
case _DocumentRevision() when $default != null:
return $default(_that.delta,_that.kind,_that.revisionId,_that.anchor,_that.author,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DocumentRevision implements DocumentRevision {
  const _DocumentRevision({required this.delta, required this.kind, @JsonKey(name: 'revision_id') required this.revisionId, this.anchor, this.author, this.timestamp});
  factory _DocumentRevision.fromJson(Map<String, dynamic> json) => _$DocumentRevisionFromJson(json);

/// The content changes that make up this revision.
@override final  RevisionDelta delta;
/// Semantic kind of this revision.
@override final  RevisionKind kind;
/// Format-specific revision identifier.
///
/// For DOCX this is the `w:id` attribute value on the change element.
/// (e.g. `"42"`). When the attribute is absent a synthetic fallback is.
/// generated (`"docx-ins-0"`, `"docx-del-3"`, …).
@override@JsonKey(name: 'revision_id') final  String revisionId;
/// Best-effort document location for this revision.
///
/// Resolution is format-dependent and may be `None` when the location.
/// cannot be determined (e.g. changes inside table cells before.
/// table-cell anchor support is added).
@override final  RevisionAnchor? anchor;
/// Display name of the author who made this change, when available.
@override final  String? author;
/// ISO-8601 timestamp of the change, when available.
///
/// Stored as a plain string so this type remains FFI-friendly and.
/// unconditionally available without the `chrono` optional dep.
/// DOCX populates this from the `w:date` attribute (e.g.
/// `"2024-03-15T10:30:00Z"`).
@override final  String? timestamp;

/// Create a copy of DocumentRevision
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentRevisionCopyWith<_DocumentRevision> get copyWith => __$DocumentRevisionCopyWithImpl<_DocumentRevision>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentRevisionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentRevision&&(identical(other.delta, delta) || other.delta == delta)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.revisionId, revisionId) || other.revisionId == revisionId)&&(identical(other.anchor, anchor) || other.anchor == anchor)&&(identical(other.author, author) || other.author == author)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,delta,kind,revisionId,anchor,author,timestamp);

@override
String toString() {
  return 'DocumentRevision(delta: $delta, kind: $kind, revisionId: $revisionId, anchor: $anchor, author: $author, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$DocumentRevisionCopyWith<$Res> implements $DocumentRevisionCopyWith<$Res> {
  factory _$DocumentRevisionCopyWith(_DocumentRevision value, $Res Function(_DocumentRevision) _then) = __$DocumentRevisionCopyWithImpl;
@override @useResult
$Res call({
 RevisionDelta delta, RevisionKind kind,@JsonKey(name: 'revision_id') String revisionId, RevisionAnchor? anchor, String? author, String? timestamp
});


@override $RevisionDeltaCopyWith<$Res> get delta;@override $RevisionAnchorCopyWith<$Res>? get anchor;

}
/// @nodoc
class __$DocumentRevisionCopyWithImpl<$Res>
    implements _$DocumentRevisionCopyWith<$Res> {
  __$DocumentRevisionCopyWithImpl(this._self, this._then);

  final _DocumentRevision _self;
  final $Res Function(_DocumentRevision) _then;

/// Create a copy of DocumentRevision
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? delta = null,Object? kind = null,Object? revisionId = null,Object? anchor = freezed,Object? author = freezed,Object? timestamp = freezed,}) {
  return _then(_DocumentRevision(
delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as RevisionDelta,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as RevisionKind,revisionId: null == revisionId ? _self.revisionId : revisionId // ignore: cast_nullable_to_non_nullable
as String,anchor: freezed == anchor ? _self.anchor : anchor // ignore: cast_nullable_to_non_nullable
as RevisionAnchor?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of DocumentRevision
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RevisionDeltaCopyWith<$Res> get delta {
  
  return $RevisionDeltaCopyWith<$Res>(_self.delta, (value) {
    return _then(_self.copyWith(delta: value));
  });
}/// Create a copy of DocumentRevision
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RevisionAnchorCopyWith<$Res>? get anchor {
    if (_self.anchor == null) {
    return null;
  }

  return $RevisionAnchorCopyWith<$Res>(_self.anchor!, (value) {
    return _then(_self.copyWith(anchor: value));
  });
}
}

// dart format on
