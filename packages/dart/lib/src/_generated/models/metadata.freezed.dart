// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Metadata {
  @JsonKey(name: 'abstract_text')
  String? get abstractText;
  Map<String, dynamic>? get additional;
  List<String>? get authors;
  String? get category;
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @JsonKey(name: 'created_by')
  String? get createdBy;
  @JsonKey(name: 'document_version')
  String? get documentVersion;
  @JsonKey(name: 'extraction_duration_ms')
  int? get extractionDurationMs;
  List<String>? get keywords;
  String? get language;
  @JsonKey(name: 'modified_at')
  String? get modifiedAt;
  @JsonKey(name: 'modified_by')
  String? get modifiedBy;
  @JsonKey(name: 'output_format')
  String? get outputFormat;
  PageStructure? get pages;
  String? get subject;
  List<String>? get tags;
  String? get title;

  /// Create a copy of Metadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MetadataCopyWith<Metadata> get copyWith =>
      _$MetadataCopyWithImpl<Metadata>(this as Metadata, _$identity);

  /// Serializes this Metadata to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Metadata &&
            (identical(other.abstractText, abstractText) ||
                other.abstractText == abstractText) &&
            const DeepCollectionEquality()
                .equals(other.additional, additional) &&
            const DeepCollectionEquality().equals(other.authors, authors) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.documentVersion, documentVersion) ||
                other.documentVersion == documentVersion) &&
            (identical(other.extractionDurationMs, extractionDurationMs) ||
                other.extractionDurationMs == extractionDurationMs) &&
            const DeepCollectionEquality().equals(other.keywords, keywords) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.modifiedAt, modifiedAt) ||
                other.modifiedAt == modifiedAt) &&
            (identical(other.modifiedBy, modifiedBy) ||
                other.modifiedBy == modifiedBy) &&
            (identical(other.outputFormat, outputFormat) ||
                other.outputFormat == outputFormat) &&
            (identical(other.pages, pages) || other.pages == pages) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      abstractText,
      const DeepCollectionEquality().hash(additional),
      const DeepCollectionEquality().hash(authors),
      category,
      createdAt,
      createdBy,
      documentVersion,
      extractionDurationMs,
      const DeepCollectionEquality().hash(keywords),
      language,
      modifiedAt,
      modifiedBy,
      outputFormat,
      pages,
      subject,
      const DeepCollectionEquality().hash(tags),
      title);

  @override
  String toString() {
    return 'Metadata(abstractText: $abstractText, additional: $additional, authors: $authors, category: $category, createdAt: $createdAt, createdBy: $createdBy, documentVersion: $documentVersion, extractionDurationMs: $extractionDurationMs, keywords: $keywords, language: $language, modifiedAt: $modifiedAt, modifiedBy: $modifiedBy, outputFormat: $outputFormat, pages: $pages, subject: $subject, tags: $tags, title: $title)';
  }
}

/// @nodoc
abstract mixin class $MetadataCopyWith<$Res> {
  factory $MetadataCopyWith(Metadata value, $Res Function(Metadata) _then) =
      _$MetadataCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'abstract_text') String? abstractText,
      Map<String, dynamic>? additional,
      List<String>? authors,
      String? category,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(name: 'document_version') String? documentVersion,
      @JsonKey(name: 'extraction_duration_ms') int? extractionDurationMs,
      List<String>? keywords,
      String? language,
      @JsonKey(name: 'modified_at') String? modifiedAt,
      @JsonKey(name: 'modified_by') String? modifiedBy,
      @JsonKey(name: 'output_format') String? outputFormat,
      PageStructure? pages,
      String? subject,
      List<String>? tags,
      String? title});

  $PageStructureCopyWith<$Res>? get pages;
}

/// @nodoc
class _$MetadataCopyWithImpl<$Res> implements $MetadataCopyWith<$Res> {
  _$MetadataCopyWithImpl(this._self, this._then);

  final Metadata _self;
  final $Res Function(Metadata) _then;

  /// Create a copy of Metadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? abstractText = freezed,
    Object? additional = freezed,
    Object? authors = freezed,
    Object? category = freezed,
    Object? createdAt = freezed,
    Object? createdBy = freezed,
    Object? documentVersion = freezed,
    Object? extractionDurationMs = freezed,
    Object? keywords = freezed,
    Object? language = freezed,
    Object? modifiedAt = freezed,
    Object? modifiedBy = freezed,
    Object? outputFormat = freezed,
    Object? pages = freezed,
    Object? subject = freezed,
    Object? tags = freezed,
    Object? title = freezed,
  }) {
    return _then(_self.copyWith(
      abstractText: freezed == abstractText
          ? _self.abstractText
          : abstractText // ignore: cast_nullable_to_non_nullable
              as String?,
      additional: freezed == additional
          ? _self.additional
          : additional // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      authors: freezed == authors
          ? _self.authors
          : authors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      category: freezed == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _self.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      documentVersion: freezed == documentVersion
          ? _self.documentVersion
          : documentVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      extractionDurationMs: freezed == extractionDurationMs
          ? _self.extractionDurationMs
          : extractionDurationMs // ignore: cast_nullable_to_non_nullable
              as int?,
      keywords: freezed == keywords
          ? _self.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      language: freezed == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedAt: freezed == modifiedAt
          ? _self.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedBy: freezed == modifiedBy
          ? _self.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      outputFormat: freezed == outputFormat
          ? _self.outputFormat
          : outputFormat // ignore: cast_nullable_to_non_nullable
              as String?,
      pages: freezed == pages
          ? _self.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as PageStructure?,
      subject: freezed == subject
          ? _self.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of Metadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PageStructureCopyWith<$Res>? get pages {
    if (_self.pages == null) {
      return null;
    }

    return $PageStructureCopyWith<$Res>(_self.pages!, (value) {
      return _then(_self.copyWith(pages: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Metadata].
extension MetadataPatterns on Metadata {
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
    TResult Function(_Metadata value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Metadata() when $default != null:
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
    TResult Function(_Metadata value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Metadata():
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
    TResult? Function(_Metadata value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Metadata() when $default != null:
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
            @JsonKey(name: 'abstract_text') String? abstractText,
            Map<String, dynamic>? additional,
            List<String>? authors,
            String? category,
            @JsonKey(name: 'created_at') String? createdAt,
            @JsonKey(name: 'created_by') String? createdBy,
            @JsonKey(name: 'document_version') String? documentVersion,
            @JsonKey(name: 'extraction_duration_ms') int? extractionDurationMs,
            List<String>? keywords,
            String? language,
            @JsonKey(name: 'modified_at') String? modifiedAt,
            @JsonKey(name: 'modified_by') String? modifiedBy,
            @JsonKey(name: 'output_format') String? outputFormat,
            PageStructure? pages,
            String? subject,
            List<String>? tags,
            String? title)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Metadata() when $default != null:
        return $default(
            _that.abstractText,
            _that.additional,
            _that.authors,
            _that.category,
            _that.createdAt,
            _that.createdBy,
            _that.documentVersion,
            _that.extractionDurationMs,
            _that.keywords,
            _that.language,
            _that.modifiedAt,
            _that.modifiedBy,
            _that.outputFormat,
            _that.pages,
            _that.subject,
            _that.tags,
            _that.title);
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
            @JsonKey(name: 'abstract_text') String? abstractText,
            Map<String, dynamic>? additional,
            List<String>? authors,
            String? category,
            @JsonKey(name: 'created_at') String? createdAt,
            @JsonKey(name: 'created_by') String? createdBy,
            @JsonKey(name: 'document_version') String? documentVersion,
            @JsonKey(name: 'extraction_duration_ms') int? extractionDurationMs,
            List<String>? keywords,
            String? language,
            @JsonKey(name: 'modified_at') String? modifiedAt,
            @JsonKey(name: 'modified_by') String? modifiedBy,
            @JsonKey(name: 'output_format') String? outputFormat,
            PageStructure? pages,
            String? subject,
            List<String>? tags,
            String? title)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Metadata():
        return $default(
            _that.abstractText,
            _that.additional,
            _that.authors,
            _that.category,
            _that.createdAt,
            _that.createdBy,
            _that.documentVersion,
            _that.extractionDurationMs,
            _that.keywords,
            _that.language,
            _that.modifiedAt,
            _that.modifiedBy,
            _that.outputFormat,
            _that.pages,
            _that.subject,
            _that.tags,
            _that.title);
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
            @JsonKey(name: 'abstract_text') String? abstractText,
            Map<String, dynamic>? additional,
            List<String>? authors,
            String? category,
            @JsonKey(name: 'created_at') String? createdAt,
            @JsonKey(name: 'created_by') String? createdBy,
            @JsonKey(name: 'document_version') String? documentVersion,
            @JsonKey(name: 'extraction_duration_ms') int? extractionDurationMs,
            List<String>? keywords,
            String? language,
            @JsonKey(name: 'modified_at') String? modifiedAt,
            @JsonKey(name: 'modified_by') String? modifiedBy,
            @JsonKey(name: 'output_format') String? outputFormat,
            PageStructure? pages,
            String? subject,
            List<String>? tags,
            String? title)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Metadata() when $default != null:
        return $default(
            _that.abstractText,
            _that.additional,
            _that.authors,
            _that.category,
            _that.createdAt,
            _that.createdBy,
            _that.documentVersion,
            _that.extractionDurationMs,
            _that.keywords,
            _that.language,
            _that.modifiedAt,
            _that.modifiedBy,
            _that.outputFormat,
            _that.pages,
            _that.subject,
            _that.tags,
            _that.title);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Metadata implements Metadata {
  const _Metadata(
      {@JsonKey(name: 'abstract_text') this.abstractText,
      final Map<String, dynamic>? additional,
      final List<String>? authors,
      this.category,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'created_by') this.createdBy,
      @JsonKey(name: 'document_version') this.documentVersion,
      @JsonKey(name: 'extraction_duration_ms') this.extractionDurationMs,
      final List<String>? keywords,
      this.language,
      @JsonKey(name: 'modified_at') this.modifiedAt,
      @JsonKey(name: 'modified_by') this.modifiedBy,
      @JsonKey(name: 'output_format') this.outputFormat,
      this.pages,
      this.subject,
      final List<String>? tags,
      this.title})
      : _additional = additional,
        _authors = authors,
        _keywords = keywords,
        _tags = tags;
  factory _Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  @override
  @JsonKey(name: 'abstract_text')
  final String? abstractText;
  final Map<String, dynamic>? _additional;
  @override
  Map<String, dynamic>? get additional {
    final value = _additional;
    if (value == null) return null;
    if (_additional is EqualUnmodifiableMapView) return _additional;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String>? _authors;
  @override
  List<String>? get authors {
    final value = _authors;
    if (value == null) return null;
    if (_authors is EqualUnmodifiableListView) return _authors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? category;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @override
  @JsonKey(name: 'document_version')
  final String? documentVersion;
  @override
  @JsonKey(name: 'extraction_duration_ms')
  final int? extractionDurationMs;
  final List<String>? _keywords;
  @override
  List<String>? get keywords {
    final value = _keywords;
    if (value == null) return null;
    if (_keywords is EqualUnmodifiableListView) return _keywords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? language;
  @override
  @JsonKey(name: 'modified_at')
  final String? modifiedAt;
  @override
  @JsonKey(name: 'modified_by')
  final String? modifiedBy;
  @override
  @JsonKey(name: 'output_format')
  final String? outputFormat;
  @override
  final PageStructure? pages;
  @override
  final String? subject;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? title;

  /// Create a copy of Metadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MetadataCopyWith<_Metadata> get copyWith =>
      __$MetadataCopyWithImpl<_Metadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MetadataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Metadata &&
            (identical(other.abstractText, abstractText) ||
                other.abstractText == abstractText) &&
            const DeepCollectionEquality()
                .equals(other._additional, _additional) &&
            const DeepCollectionEquality().equals(other._authors, _authors) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.documentVersion, documentVersion) ||
                other.documentVersion == documentVersion) &&
            (identical(other.extractionDurationMs, extractionDurationMs) ||
                other.extractionDurationMs == extractionDurationMs) &&
            const DeepCollectionEquality().equals(other._keywords, _keywords) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.modifiedAt, modifiedAt) ||
                other.modifiedAt == modifiedAt) &&
            (identical(other.modifiedBy, modifiedBy) ||
                other.modifiedBy == modifiedBy) &&
            (identical(other.outputFormat, outputFormat) ||
                other.outputFormat == outputFormat) &&
            (identical(other.pages, pages) || other.pages == pages) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      abstractText,
      const DeepCollectionEquality().hash(_additional),
      const DeepCollectionEquality().hash(_authors),
      category,
      createdAt,
      createdBy,
      documentVersion,
      extractionDurationMs,
      const DeepCollectionEquality().hash(_keywords),
      language,
      modifiedAt,
      modifiedBy,
      outputFormat,
      pages,
      subject,
      const DeepCollectionEquality().hash(_tags),
      title);

  @override
  String toString() {
    return 'Metadata(abstractText: $abstractText, additional: $additional, authors: $authors, category: $category, createdAt: $createdAt, createdBy: $createdBy, documentVersion: $documentVersion, extractionDurationMs: $extractionDurationMs, keywords: $keywords, language: $language, modifiedAt: $modifiedAt, modifiedBy: $modifiedBy, outputFormat: $outputFormat, pages: $pages, subject: $subject, tags: $tags, title: $title)';
  }
}

/// @nodoc
abstract mixin class _$MetadataCopyWith<$Res>
    implements $MetadataCopyWith<$Res> {
  factory _$MetadataCopyWith(_Metadata value, $Res Function(_Metadata) _then) =
      __$MetadataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'abstract_text') String? abstractText,
      Map<String, dynamic>? additional,
      List<String>? authors,
      String? category,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(name: 'document_version') String? documentVersion,
      @JsonKey(name: 'extraction_duration_ms') int? extractionDurationMs,
      List<String>? keywords,
      String? language,
      @JsonKey(name: 'modified_at') String? modifiedAt,
      @JsonKey(name: 'modified_by') String? modifiedBy,
      @JsonKey(name: 'output_format') String? outputFormat,
      PageStructure? pages,
      String? subject,
      List<String>? tags,
      String? title});

  @override
  $PageStructureCopyWith<$Res>? get pages;
}

/// @nodoc
class __$MetadataCopyWithImpl<$Res> implements _$MetadataCopyWith<$Res> {
  __$MetadataCopyWithImpl(this._self, this._then);

  final _Metadata _self;
  final $Res Function(_Metadata) _then;

  /// Create a copy of Metadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? abstractText = freezed,
    Object? additional = freezed,
    Object? authors = freezed,
    Object? category = freezed,
    Object? createdAt = freezed,
    Object? createdBy = freezed,
    Object? documentVersion = freezed,
    Object? extractionDurationMs = freezed,
    Object? keywords = freezed,
    Object? language = freezed,
    Object? modifiedAt = freezed,
    Object? modifiedBy = freezed,
    Object? outputFormat = freezed,
    Object? pages = freezed,
    Object? subject = freezed,
    Object? tags = freezed,
    Object? title = freezed,
  }) {
    return _then(_Metadata(
      abstractText: freezed == abstractText
          ? _self.abstractText
          : abstractText // ignore: cast_nullable_to_non_nullable
              as String?,
      additional: freezed == additional
          ? _self._additional
          : additional // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      authors: freezed == authors
          ? _self._authors
          : authors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      category: freezed == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _self.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      documentVersion: freezed == documentVersion
          ? _self.documentVersion
          : documentVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      extractionDurationMs: freezed == extractionDurationMs
          ? _self.extractionDurationMs
          : extractionDurationMs // ignore: cast_nullable_to_non_nullable
              as int?,
      keywords: freezed == keywords
          ? _self._keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      language: freezed == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedAt: freezed == modifiedAt
          ? _self.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedBy: freezed == modifiedBy
          ? _self.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      outputFormat: freezed == outputFormat
          ? _self.outputFormat
          : outputFormat // ignore: cast_nullable_to_non_nullable
              as String?,
      pages: freezed == pages
          ? _self.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as PageStructure?,
      subject: freezed == subject
          ? _self.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of Metadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PageStructureCopyWith<$Res>? get pages {
    if (_self.pages == null) {
      return null;
    }

    return $PageStructureCopyWith<$Res>(_self.pages!, (value) {
      return _then(_self.copyWith(pages: value));
    });
  }
}

// dart format on
