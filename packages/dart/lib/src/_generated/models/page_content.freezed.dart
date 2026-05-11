// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PageContent {
  /// Page number (0-indexed)
  @JsonKey(name: 'page_number')
  int get pageNumber;

  /// Extracted text for this page
  String? get content;

  /// Whether the page is blank
  @JsonKey(name: 'is_blank')
  bool? get isBlank;

  /// Create a copy of PageContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PageContentCopyWith<PageContent> get copyWith =>
      _$PageContentCopyWithImpl<PageContent>(this as PageContent, _$identity);

  /// Serializes this PageContent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PageContent &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isBlank, isBlank) || other.isBlank == isBlank));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, pageNumber, content, isBlank);

  @override
  String toString() {
    return 'PageContent(pageNumber: $pageNumber, content: $content, isBlank: $isBlank)';
  }
}

/// @nodoc
abstract mixin class $PageContentCopyWith<$Res> {
  factory $PageContentCopyWith(
          PageContent value, $Res Function(PageContent) _then) =
      _$PageContentCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'page_number') int pageNumber,
      String? content,
      @JsonKey(name: 'is_blank') bool? isBlank});
}

/// @nodoc
class _$PageContentCopyWithImpl<$Res> implements $PageContentCopyWith<$Res> {
  _$PageContentCopyWithImpl(this._self, this._then);

  final PageContent _self;
  final $Res Function(PageContent) _then;

  /// Create a copy of PageContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageNumber = null,
    Object? content = freezed,
    Object? isBlank = freezed,
  }) {
    return _then(_self.copyWith(
      pageNumber: null == pageNumber
          ? _self.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      isBlank: freezed == isBlank
          ? _self.isBlank
          : isBlank // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// Adds pattern-matching-related methods to [PageContent].
extension PageContentPatterns on PageContent {
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
    TResult Function(_PageContent value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PageContent() when $default != null:
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
    TResult Function(_PageContent value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PageContent():
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
    TResult? Function(_PageContent value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PageContent() when $default != null:
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
    TResult Function(@JsonKey(name: 'page_number') int pageNumber,
            String? content, @JsonKey(name: 'is_blank') bool? isBlank)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PageContent() when $default != null:
        return $default(_that.pageNumber, _that.content, _that.isBlank);
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
    TResult Function(@JsonKey(name: 'page_number') int pageNumber,
            String? content, @JsonKey(name: 'is_blank') bool? isBlank)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PageContent():
        return $default(_that.pageNumber, _that.content, _that.isBlank);
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
    TResult? Function(@JsonKey(name: 'page_number') int pageNumber,
            String? content, @JsonKey(name: 'is_blank') bool? isBlank)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PageContent() when $default != null:
        return $default(_that.pageNumber, _that.content, _that.isBlank);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PageContent implements PageContent {
  const _PageContent(
      {@JsonKey(name: 'page_number') required this.pageNumber,
      this.content,
      @JsonKey(name: 'is_blank') this.isBlank});
  factory _PageContent.fromJson(Map<String, dynamic> json) =>
      _$PageContentFromJson(json);

  /// Page number (0-indexed)
  @override
  @JsonKey(name: 'page_number')
  final int pageNumber;

  /// Extracted text for this page
  @override
  final String? content;

  /// Whether the page is blank
  @override
  @JsonKey(name: 'is_blank')
  final bool? isBlank;

  /// Create a copy of PageContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PageContentCopyWith<_PageContent> get copyWith =>
      __$PageContentCopyWithImpl<_PageContent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PageContentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PageContent &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isBlank, isBlank) || other.isBlank == isBlank));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, pageNumber, content, isBlank);

  @override
  String toString() {
    return 'PageContent(pageNumber: $pageNumber, content: $content, isBlank: $isBlank)';
  }
}

/// @nodoc
abstract mixin class _$PageContentCopyWith<$Res>
    implements $PageContentCopyWith<$Res> {
  factory _$PageContentCopyWith(
          _PageContent value, $Res Function(_PageContent) _then) =
      __$PageContentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'page_number') int pageNumber,
      String? content,
      @JsonKey(name: 'is_blank') bool? isBlank});
}

/// @nodoc
class __$PageContentCopyWithImpl<$Res> implements _$PageContentCopyWith<$Res> {
  __$PageContentCopyWithImpl(this._self, this._then);

  final _PageContent _self;
  final $Res Function(_PageContent) _then;

  /// Create a copy of PageContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? pageNumber = null,
    Object? content = freezed,
    Object? isBlank = freezed,
  }) {
    return _then(_PageContent(
      pageNumber: null == pageNumber
          ? _self.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      isBlank: freezed == isBlank
          ? _self.isBlank
          : isBlank // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

// dart format on
