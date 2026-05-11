// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'extraction_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExtractionResult {
  /// Text chunks (when chunking is enabled)
  List<Chunk>? get chunks;

  /// Full extracted text content
  String? get content;

  /// Detected document languages
  @JsonKey(name: 'detected_languages')
  List<String>? get detectedLanguages;

  /// Extracted images (base64 encoded)
  List<ExtractedImage>? get images;

  /// Document metadata
  Metadata? get metadata;

  /// Content MIME type (e.g., "text/plain", "text/markdown")
  @JsonKey(name: 'mime_type')
  String? get mimeType;

  /// Per-page content (when page extraction is enabled)
  List<PageContent>? get pages;

  /// Non-fatal processing warnings
  @JsonKey(name: 'processing_warnings')
  List<ProcessingWarning>? get processingWarnings;

  /// Document quality score (0.0-1.0)
  @JsonKey(name: 'quality_score')
  double? get qualityScore;

  /// Extracted tables
  List<Table>? get tables;

  /// Create a copy of ExtractionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExtractionResultCopyWith<ExtractionResult> get copyWith =>
      _$ExtractionResultCopyWithImpl<ExtractionResult>(
          this as ExtractionResult, _$identity);

  /// Serializes this ExtractionResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExtractionResult &&
            const DeepCollectionEquality().equals(other.chunks, chunks) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality()
                .equals(other.detectedLanguages, detectedLanguages) &&
            const DeepCollectionEquality().equals(other.images, images) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            const DeepCollectionEquality().equals(other.pages, pages) &&
            const DeepCollectionEquality()
                .equals(other.processingWarnings, processingWarnings) &&
            (identical(other.qualityScore, qualityScore) ||
                other.qualityScore == qualityScore) &&
            const DeepCollectionEquality().equals(other.tables, tables));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(chunks),
      content,
      const DeepCollectionEquality().hash(detectedLanguages),
      const DeepCollectionEquality().hash(images),
      metadata,
      mimeType,
      const DeepCollectionEquality().hash(pages),
      const DeepCollectionEquality().hash(processingWarnings),
      qualityScore,
      const DeepCollectionEquality().hash(tables));

  @override
  String toString() {
    return 'ExtractionResult(chunks: $chunks, content: $content, detectedLanguages: $detectedLanguages, images: $images, metadata: $metadata, mimeType: $mimeType, pages: $pages, processingWarnings: $processingWarnings, qualityScore: $qualityScore, tables: $tables)';
  }
}

/// @nodoc
abstract mixin class $ExtractionResultCopyWith<$Res> {
  factory $ExtractionResultCopyWith(
          ExtractionResult value, $Res Function(ExtractionResult) _then) =
      _$ExtractionResultCopyWithImpl;
  @useResult
  $Res call(
      {List<Chunk>? chunks,
      String? content,
      @JsonKey(name: 'detected_languages') List<String>? detectedLanguages,
      List<ExtractedImage>? images,
      Metadata? metadata,
      @JsonKey(name: 'mime_type') String? mimeType,
      List<PageContent>? pages,
      @JsonKey(name: 'processing_warnings')
      List<ProcessingWarning>? processingWarnings,
      @JsonKey(name: 'quality_score') double? qualityScore,
      List<Table>? tables});

  $MetadataCopyWith<$Res>? get metadata;
}

/// @nodoc
class _$ExtractionResultCopyWithImpl<$Res>
    implements $ExtractionResultCopyWith<$Res> {
  _$ExtractionResultCopyWithImpl(this._self, this._then);

  final ExtractionResult _self;
  final $Res Function(ExtractionResult) _then;

  /// Create a copy of ExtractionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chunks = freezed,
    Object? content = freezed,
    Object? detectedLanguages = freezed,
    Object? images = freezed,
    Object? metadata = freezed,
    Object? mimeType = freezed,
    Object? pages = freezed,
    Object? processingWarnings = freezed,
    Object? qualityScore = freezed,
    Object? tables = freezed,
  }) {
    return _then(_self.copyWith(
      chunks: freezed == chunks
          ? _self.chunks
          : chunks // ignore: cast_nullable_to_non_nullable
              as List<Chunk>?,
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      detectedLanguages: freezed == detectedLanguages
          ? _self.detectedLanguages
          : detectedLanguages // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      images: freezed == images
          ? _self.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<ExtractedImage>?,
      metadata: freezed == metadata
          ? _self.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Metadata?,
      mimeType: freezed == mimeType
          ? _self.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String?,
      pages: freezed == pages
          ? _self.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<PageContent>?,
      processingWarnings: freezed == processingWarnings
          ? _self.processingWarnings
          : processingWarnings // ignore: cast_nullable_to_non_nullable
              as List<ProcessingWarning>?,
      qualityScore: freezed == qualityScore
          ? _self.qualityScore
          : qualityScore // ignore: cast_nullable_to_non_nullable
              as double?,
      tables: freezed == tables
          ? _self.tables
          : tables // ignore: cast_nullable_to_non_nullable
              as List<Table>?,
    ));
  }

  /// Create a copy of ExtractionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MetadataCopyWith<$Res>? get metadata {
    if (_self.metadata == null) {
      return null;
    }

    return $MetadataCopyWith<$Res>(_self.metadata!, (value) {
      return _then(_self.copyWith(metadata: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ExtractionResult].
extension ExtractionResultPatterns on ExtractionResult {
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
    TResult Function(_ExtractionResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExtractionResult() when $default != null:
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
    TResult Function(_ExtractionResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExtractionResult():
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
    TResult? Function(_ExtractionResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExtractionResult() when $default != null:
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
            List<Chunk>? chunks,
            String? content,
            @JsonKey(name: 'detected_languages')
            List<String>? detectedLanguages,
            List<ExtractedImage>? images,
            Metadata? metadata,
            @JsonKey(name: 'mime_type') String? mimeType,
            List<PageContent>? pages,
            @JsonKey(name: 'processing_warnings')
            List<ProcessingWarning>? processingWarnings,
            @JsonKey(name: 'quality_score') double? qualityScore,
            List<Table>? tables)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExtractionResult() when $default != null:
        return $default(
            _that.chunks,
            _that.content,
            _that.detectedLanguages,
            _that.images,
            _that.metadata,
            _that.mimeType,
            _that.pages,
            _that.processingWarnings,
            _that.qualityScore,
            _that.tables);
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
            List<Chunk>? chunks,
            String? content,
            @JsonKey(name: 'detected_languages')
            List<String>? detectedLanguages,
            List<ExtractedImage>? images,
            Metadata? metadata,
            @JsonKey(name: 'mime_type') String? mimeType,
            List<PageContent>? pages,
            @JsonKey(name: 'processing_warnings')
            List<ProcessingWarning>? processingWarnings,
            @JsonKey(name: 'quality_score') double? qualityScore,
            List<Table>? tables)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExtractionResult():
        return $default(
            _that.chunks,
            _that.content,
            _that.detectedLanguages,
            _that.images,
            _that.metadata,
            _that.mimeType,
            _that.pages,
            _that.processingWarnings,
            _that.qualityScore,
            _that.tables);
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
            List<Chunk>? chunks,
            String? content,
            @JsonKey(name: 'detected_languages')
            List<String>? detectedLanguages,
            List<ExtractedImage>? images,
            Metadata? metadata,
            @JsonKey(name: 'mime_type') String? mimeType,
            List<PageContent>? pages,
            @JsonKey(name: 'processing_warnings')
            List<ProcessingWarning>? processingWarnings,
            @JsonKey(name: 'quality_score') double? qualityScore,
            List<Table>? tables)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExtractionResult() when $default != null:
        return $default(
            _that.chunks,
            _that.content,
            _that.detectedLanguages,
            _that.images,
            _that.metadata,
            _that.mimeType,
            _that.pages,
            _that.processingWarnings,
            _that.qualityScore,
            _that.tables);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExtractionResult implements ExtractionResult {
  const _ExtractionResult(
      {final List<Chunk>? chunks,
      this.content,
      @JsonKey(name: 'detected_languages')
      final List<String>? detectedLanguages,
      final List<ExtractedImage>? images,
      this.metadata,
      @JsonKey(name: 'mime_type') this.mimeType,
      final List<PageContent>? pages,
      @JsonKey(name: 'processing_warnings')
      final List<ProcessingWarning>? processingWarnings,
      @JsonKey(name: 'quality_score') this.qualityScore,
      final List<Table>? tables})
      : _chunks = chunks,
        _detectedLanguages = detectedLanguages,
        _images = images,
        _pages = pages,
        _processingWarnings = processingWarnings,
        _tables = tables;
  factory _ExtractionResult.fromJson(Map<String, dynamic> json) =>
      _$ExtractionResultFromJson(json);

  /// Text chunks (when chunking is enabled)
  final List<Chunk>? _chunks;

  /// Text chunks (when chunking is enabled)
  @override
  List<Chunk>? get chunks {
    final value = _chunks;
    if (value == null) return null;
    if (_chunks is EqualUnmodifiableListView) return _chunks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Full extracted text content
  @override
  final String? content;

  /// Detected document languages
  final List<String>? _detectedLanguages;

  /// Detected document languages
  @override
  @JsonKey(name: 'detected_languages')
  List<String>? get detectedLanguages {
    final value = _detectedLanguages;
    if (value == null) return null;
    if (_detectedLanguages is EqualUnmodifiableListView)
      return _detectedLanguages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Extracted images (base64 encoded)
  final List<ExtractedImage>? _images;

  /// Extracted images (base64 encoded)
  @override
  List<ExtractedImage>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Document metadata
  @override
  final Metadata? metadata;

  /// Content MIME type (e.g., "text/plain", "text/markdown")
  @override
  @JsonKey(name: 'mime_type')
  final String? mimeType;

  /// Per-page content (when page extraction is enabled)
  final List<PageContent>? _pages;

  /// Per-page content (when page extraction is enabled)
  @override
  List<PageContent>? get pages {
    final value = _pages;
    if (value == null) return null;
    if (_pages is EqualUnmodifiableListView) return _pages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Non-fatal processing warnings
  final List<ProcessingWarning>? _processingWarnings;

  /// Non-fatal processing warnings
  @override
  @JsonKey(name: 'processing_warnings')
  List<ProcessingWarning>? get processingWarnings {
    final value = _processingWarnings;
    if (value == null) return null;
    if (_processingWarnings is EqualUnmodifiableListView)
      return _processingWarnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Document quality score (0.0-1.0)
  @override
  @JsonKey(name: 'quality_score')
  final double? qualityScore;

  /// Extracted tables
  final List<Table>? _tables;

  /// Extracted tables
  @override
  List<Table>? get tables {
    final value = _tables;
    if (value == null) return null;
    if (_tables is EqualUnmodifiableListView) return _tables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of ExtractionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExtractionResultCopyWith<_ExtractionResult> get copyWith =>
      __$ExtractionResultCopyWithImpl<_ExtractionResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExtractionResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExtractionResult &&
            const DeepCollectionEquality().equals(other._chunks, _chunks) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality()
                .equals(other._detectedLanguages, _detectedLanguages) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            const DeepCollectionEquality().equals(other._pages, _pages) &&
            const DeepCollectionEquality()
                .equals(other._processingWarnings, _processingWarnings) &&
            (identical(other.qualityScore, qualityScore) ||
                other.qualityScore == qualityScore) &&
            const DeepCollectionEquality().equals(other._tables, _tables));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_chunks),
      content,
      const DeepCollectionEquality().hash(_detectedLanguages),
      const DeepCollectionEquality().hash(_images),
      metadata,
      mimeType,
      const DeepCollectionEquality().hash(_pages),
      const DeepCollectionEquality().hash(_processingWarnings),
      qualityScore,
      const DeepCollectionEquality().hash(_tables));

  @override
  String toString() {
    return 'ExtractionResult(chunks: $chunks, content: $content, detectedLanguages: $detectedLanguages, images: $images, metadata: $metadata, mimeType: $mimeType, pages: $pages, processingWarnings: $processingWarnings, qualityScore: $qualityScore, tables: $tables)';
  }
}

/// @nodoc
abstract mixin class _$ExtractionResultCopyWith<$Res>
    implements $ExtractionResultCopyWith<$Res> {
  factory _$ExtractionResultCopyWith(
          _ExtractionResult value, $Res Function(_ExtractionResult) _then) =
      __$ExtractionResultCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<Chunk>? chunks,
      String? content,
      @JsonKey(name: 'detected_languages') List<String>? detectedLanguages,
      List<ExtractedImage>? images,
      Metadata? metadata,
      @JsonKey(name: 'mime_type') String? mimeType,
      List<PageContent>? pages,
      @JsonKey(name: 'processing_warnings')
      List<ProcessingWarning>? processingWarnings,
      @JsonKey(name: 'quality_score') double? qualityScore,
      List<Table>? tables});

  @override
  $MetadataCopyWith<$Res>? get metadata;
}

/// @nodoc
class __$ExtractionResultCopyWithImpl<$Res>
    implements _$ExtractionResultCopyWith<$Res> {
  __$ExtractionResultCopyWithImpl(this._self, this._then);

  final _ExtractionResult _self;
  final $Res Function(_ExtractionResult) _then;

  /// Create a copy of ExtractionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? chunks = freezed,
    Object? content = freezed,
    Object? detectedLanguages = freezed,
    Object? images = freezed,
    Object? metadata = freezed,
    Object? mimeType = freezed,
    Object? pages = freezed,
    Object? processingWarnings = freezed,
    Object? qualityScore = freezed,
    Object? tables = freezed,
  }) {
    return _then(_ExtractionResult(
      chunks: freezed == chunks
          ? _self._chunks
          : chunks // ignore: cast_nullable_to_non_nullable
              as List<Chunk>?,
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      detectedLanguages: freezed == detectedLanguages
          ? _self._detectedLanguages
          : detectedLanguages // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      images: freezed == images
          ? _self._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<ExtractedImage>?,
      metadata: freezed == metadata
          ? _self.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Metadata?,
      mimeType: freezed == mimeType
          ? _self.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String?,
      pages: freezed == pages
          ? _self._pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<PageContent>?,
      processingWarnings: freezed == processingWarnings
          ? _self._processingWarnings
          : processingWarnings // ignore: cast_nullable_to_non_nullable
              as List<ProcessingWarning>?,
      qualityScore: freezed == qualityScore
          ? _self.qualityScore
          : qualityScore // ignore: cast_nullable_to_non_nullable
              as double?,
      tables: freezed == tables
          ? _self._tables
          : tables // ignore: cast_nullable_to_non_nullable
              as List<Table>?,
    ));
  }

  /// Create a copy of ExtractionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MetadataCopyWith<$Res>? get metadata {
    if (_self.metadata == null) {
      return null;
    }

    return $MetadataCopyWith<$Res>(_self.metadata!, (value) {
      return _then(_self.copyWith(metadata: value));
    });
  }
}

// dart format on
