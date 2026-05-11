// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chunk.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Chunk {
  /// Chunk text content
  String? get content;

  /// Embedding vector (when embedding is enabled)
  List<double>? get embedding;

  /// Chunk position metadata
  ChunkMetadata? get metadata;

  /// Create a copy of Chunk
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChunkCopyWith<Chunk> get copyWith =>
      _$ChunkCopyWithImpl<Chunk>(this as Chunk, _$identity);

  /// Serializes this Chunk to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Chunk &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other.embedding, embedding) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, content,
      const DeepCollectionEquality().hash(embedding), metadata);

  @override
  String toString() {
    return 'Chunk(content: $content, embedding: $embedding, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class $ChunkCopyWith<$Res> {
  factory $ChunkCopyWith(Chunk value, $Res Function(Chunk) _then) =
      _$ChunkCopyWithImpl;
  @useResult
  $Res call(
      {String? content, List<double>? embedding, ChunkMetadata? metadata});

  $ChunkMetadataCopyWith<$Res>? get metadata;
}

/// @nodoc
class _$ChunkCopyWithImpl<$Res> implements $ChunkCopyWith<$Res> {
  _$ChunkCopyWithImpl(this._self, this._then);

  final Chunk _self;
  final $Res Function(Chunk) _then;

  /// Create a copy of Chunk
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = freezed,
    Object? embedding = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_self.copyWith(
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      embedding: freezed == embedding
          ? _self.embedding
          : embedding // ignore: cast_nullable_to_non_nullable
              as List<double>?,
      metadata: freezed == metadata
          ? _self.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as ChunkMetadata?,
    ));
  }

  /// Create a copy of Chunk
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChunkMetadataCopyWith<$Res>? get metadata {
    if (_self.metadata == null) {
      return null;
    }

    return $ChunkMetadataCopyWith<$Res>(_self.metadata!, (value) {
      return _then(_self.copyWith(metadata: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Chunk].
extension ChunkPatterns on Chunk {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Chunk value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Chunk() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Chunk value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Chunk():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Chunk value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Chunk() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String? content, List<double>? embedding, ChunkMetadata? metadata)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Chunk() when $default != null:
        return $default(_that.content, _that.embedding, _that.metadata);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String? content, List<double>? embedding, ChunkMetadata? metadata)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Chunk():
        return $default(_that.content, _that.embedding, _that.metadata);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String? content, List<double>? embedding, ChunkMetadata? metadata)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Chunk() when $default != null:
        return $default(_that.content, _that.embedding, _that.metadata);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Chunk implements Chunk {
  const _Chunk({this.content, final List<double>? embedding, this.metadata})
      : _embedding = embedding;
  factory _Chunk.fromJson(Map<String, dynamic> json) => _$ChunkFromJson(json);

  /// Chunk text content
  @override
  final String? content;

  /// Embedding vector (when embedding is enabled)
  final List<double>? _embedding;

  /// Embedding vector (when embedding is enabled)
  @override
  List<double>? get embedding {
    final value = _embedding;
    if (value == null) return null;
    if (_embedding is EqualUnmodifiableListView) return _embedding;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Chunk position metadata
  @override
  final ChunkMetadata? metadata;

  /// Create a copy of Chunk
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChunkCopyWith<_Chunk> get copyWith =>
      __$ChunkCopyWithImpl<_Chunk>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChunkToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Chunk &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality()
                .equals(other._embedding, _embedding) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, content,
      const DeepCollectionEquality().hash(_embedding), metadata);

  @override
  String toString() {
    return 'Chunk(content: $content, embedding: $embedding, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class _$ChunkCopyWith<$Res> implements $ChunkCopyWith<$Res> {
  factory _$ChunkCopyWith(_Chunk value, $Res Function(_Chunk) _then) =
      __$ChunkCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? content, List<double>? embedding, ChunkMetadata? metadata});

  @override
  $ChunkMetadataCopyWith<$Res>? get metadata;
}

/// @nodoc
class __$ChunkCopyWithImpl<$Res> implements _$ChunkCopyWith<$Res> {
  __$ChunkCopyWithImpl(this._self, this._then);

  final _Chunk _self;
  final $Res Function(_Chunk) _then;

  /// Create a copy of Chunk
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? content = freezed,
    Object? embedding = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_Chunk(
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      embedding: freezed == embedding
          ? _self._embedding
          : embedding // ignore: cast_nullable_to_non_nullable
              as List<double>?,
      metadata: freezed == metadata
          ? _self.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as ChunkMetadata?,
    ));
  }

  /// Create a copy of Chunk
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChunkMetadataCopyWith<$Res>? get metadata {
    if (_self.metadata == null) {
      return null;
    }

    return $ChunkMetadataCopyWith<$Res>(_self.metadata!, (value) {
      return _then(_self.copyWith(metadata: value));
    });
  }
}

// dart format on
