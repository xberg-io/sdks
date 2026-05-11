// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'extracted_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExtractedImage {
  /// Bounding box on the page
  @JsonKey(name: 'bounding_box')
  BoundingBox? get boundingBox;

  /// Base64-encoded image data
  String? get data;

  /// Image description
  String? get description;

  /// Image format (e.g., "PNG", "JPEG")
  String? get format;

  /// Image height in pixels
  int? get height;

  /// Image index within the document
  @JsonKey(name: 'image_index')
  int? get imageIndex;

  /// Page number the image was found on
  @JsonKey(name: 'page_number')
  int? get pageNumber;

  /// Image width in pixels
  int? get width;

  /// Create a copy of ExtractedImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExtractedImageCopyWith<ExtractedImage> get copyWith =>
      _$ExtractedImageCopyWithImpl<ExtractedImage>(
          this as ExtractedImage, _$identity);

  /// Serializes this ExtractedImage to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExtractedImage &&
            (identical(other.boundingBox, boundingBox) ||
                other.boundingBox == boundingBox) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.imageIndex, imageIndex) ||
                other.imageIndex == imageIndex) &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber) &&
            (identical(other.width, width) || other.width == width));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, boundingBox, data, description,
      format, height, imageIndex, pageNumber, width);

  @override
  String toString() {
    return 'ExtractedImage(boundingBox: $boundingBox, data: $data, description: $description, format: $format, height: $height, imageIndex: $imageIndex, pageNumber: $pageNumber, width: $width)';
  }
}

/// @nodoc
abstract mixin class $ExtractedImageCopyWith<$Res> {
  factory $ExtractedImageCopyWith(
          ExtractedImage value, $Res Function(ExtractedImage) _then) =
      _$ExtractedImageCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'bounding_box') BoundingBox? boundingBox,
      String? data,
      String? description,
      String? format,
      int? height,
      @JsonKey(name: 'image_index') int? imageIndex,
      @JsonKey(name: 'page_number') int? pageNumber,
      int? width});

  $BoundingBoxCopyWith<$Res>? get boundingBox;
}

/// @nodoc
class _$ExtractedImageCopyWithImpl<$Res>
    implements $ExtractedImageCopyWith<$Res> {
  _$ExtractedImageCopyWithImpl(this._self, this._then);

  final ExtractedImage _self;
  final $Res Function(ExtractedImage) _then;

  /// Create a copy of ExtractedImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? boundingBox = freezed,
    Object? data = freezed,
    Object? description = freezed,
    Object? format = freezed,
    Object? height = freezed,
    Object? imageIndex = freezed,
    Object? pageNumber = freezed,
    Object? width = freezed,
  }) {
    return _then(_self.copyWith(
      boundingBox: freezed == boundingBox
          ? _self.boundingBox
          : boundingBox // ignore: cast_nullable_to_non_nullable
              as BoundingBox?,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      format: freezed == format
          ? _self.format
          : format // ignore: cast_nullable_to_non_nullable
              as String?,
      height: freezed == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      imageIndex: freezed == imageIndex
          ? _self.imageIndex
          : imageIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      pageNumber: freezed == pageNumber
          ? _self.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      width: freezed == width
          ? _self.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of ExtractedImage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BoundingBoxCopyWith<$Res>? get boundingBox {
    if (_self.boundingBox == null) {
      return null;
    }

    return $BoundingBoxCopyWith<$Res>(_self.boundingBox!, (value) {
      return _then(_self.copyWith(boundingBox: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ExtractedImage].
extension ExtractedImagePatterns on ExtractedImage {
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
    TResult Function(_ExtractedImage value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExtractedImage() when $default != null:
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
    TResult Function(_ExtractedImage value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExtractedImage():
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
    TResult? Function(_ExtractedImage value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExtractedImage() when $default != null:
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
            @JsonKey(name: 'bounding_box') BoundingBox? boundingBox,
            String? data,
            String? description,
            String? format,
            int? height,
            @JsonKey(name: 'image_index') int? imageIndex,
            @JsonKey(name: 'page_number') int? pageNumber,
            int? width)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExtractedImage() when $default != null:
        return $default(
            _that.boundingBox,
            _that.data,
            _that.description,
            _that.format,
            _that.height,
            _that.imageIndex,
            _that.pageNumber,
            _that.width);
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
            @JsonKey(name: 'bounding_box') BoundingBox? boundingBox,
            String? data,
            String? description,
            String? format,
            int? height,
            @JsonKey(name: 'image_index') int? imageIndex,
            @JsonKey(name: 'page_number') int? pageNumber,
            int? width)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExtractedImage():
        return $default(
            _that.boundingBox,
            _that.data,
            _that.description,
            _that.format,
            _that.height,
            _that.imageIndex,
            _that.pageNumber,
            _that.width);
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
            @JsonKey(name: 'bounding_box') BoundingBox? boundingBox,
            String? data,
            String? description,
            String? format,
            int? height,
            @JsonKey(name: 'image_index') int? imageIndex,
            @JsonKey(name: 'page_number') int? pageNumber,
            int? width)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExtractedImage() when $default != null:
        return $default(
            _that.boundingBox,
            _that.data,
            _that.description,
            _that.format,
            _that.height,
            _that.imageIndex,
            _that.pageNumber,
            _that.width);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExtractedImage implements ExtractedImage {
  const _ExtractedImage(
      {@JsonKey(name: 'bounding_box') this.boundingBox,
      this.data,
      this.description,
      this.format,
      this.height,
      @JsonKey(name: 'image_index') this.imageIndex,
      @JsonKey(name: 'page_number') this.pageNumber,
      this.width});
  factory _ExtractedImage.fromJson(Map<String, dynamic> json) =>
      _$ExtractedImageFromJson(json);

  /// Bounding box on the page
  @override
  @JsonKey(name: 'bounding_box')
  final BoundingBox? boundingBox;

  /// Base64-encoded image data
  @override
  final String? data;

  /// Image description
  @override
  final String? description;

  /// Image format (e.g., "PNG", "JPEG")
  @override
  final String? format;

  /// Image height in pixels
  @override
  final int? height;

  /// Image index within the document
  @override
  @JsonKey(name: 'image_index')
  final int? imageIndex;

  /// Page number the image was found on
  @override
  @JsonKey(name: 'page_number')
  final int? pageNumber;

  /// Image width in pixels
  @override
  final int? width;

  /// Create a copy of ExtractedImage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExtractedImageCopyWith<_ExtractedImage> get copyWith =>
      __$ExtractedImageCopyWithImpl<_ExtractedImage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExtractedImageToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExtractedImage &&
            (identical(other.boundingBox, boundingBox) ||
                other.boundingBox == boundingBox) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.imageIndex, imageIndex) ||
                other.imageIndex == imageIndex) &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber) &&
            (identical(other.width, width) || other.width == width));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, boundingBox, data, description,
      format, height, imageIndex, pageNumber, width);

  @override
  String toString() {
    return 'ExtractedImage(boundingBox: $boundingBox, data: $data, description: $description, format: $format, height: $height, imageIndex: $imageIndex, pageNumber: $pageNumber, width: $width)';
  }
}

/// @nodoc
abstract mixin class _$ExtractedImageCopyWith<$Res>
    implements $ExtractedImageCopyWith<$Res> {
  factory _$ExtractedImageCopyWith(
          _ExtractedImage value, $Res Function(_ExtractedImage) _then) =
      __$ExtractedImageCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'bounding_box') BoundingBox? boundingBox,
      String? data,
      String? description,
      String? format,
      int? height,
      @JsonKey(name: 'image_index') int? imageIndex,
      @JsonKey(name: 'page_number') int? pageNumber,
      int? width});

  @override
  $BoundingBoxCopyWith<$Res>? get boundingBox;
}

/// @nodoc
class __$ExtractedImageCopyWithImpl<$Res>
    implements _$ExtractedImageCopyWith<$Res> {
  __$ExtractedImageCopyWithImpl(this._self, this._then);

  final _ExtractedImage _self;
  final $Res Function(_ExtractedImage) _then;

  /// Create a copy of ExtractedImage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? boundingBox = freezed,
    Object? data = freezed,
    Object? description = freezed,
    Object? format = freezed,
    Object? height = freezed,
    Object? imageIndex = freezed,
    Object? pageNumber = freezed,
    Object? width = freezed,
  }) {
    return _then(_ExtractedImage(
      boundingBox: freezed == boundingBox
          ? _self.boundingBox
          : boundingBox // ignore: cast_nullable_to_non_nullable
              as BoundingBox?,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      format: freezed == format
          ? _self.format
          : format // ignore: cast_nullable_to_non_nullable
              as String?,
      height: freezed == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      imageIndex: freezed == imageIndex
          ? _self.imageIndex
          : imageIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      pageNumber: freezed == pageNumber
          ? _self.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      width: freezed == width
          ? _self.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of ExtractedImage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BoundingBoxCopyWith<$Res>? get boundingBox {
    if (_self.boundingBox == null) {
      return null;
    }

    return $BoundingBoxCopyWith<$Res>(_self.boundingBox!, (value) {
      return _then(_self.copyWith(boundingBox: value));
    });
  }
}

// dart format on
