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

/// Raw image data (PNG, JPEG, WebP, etc. bytes).
/// Uses `bytes::Bytes` for cheap cloning of large buffers.
 List<int> get data;/// Image format (e.g., "jpeg", "png", "webp").
/// Uses Cow<'static, str> to avoid allocation for static literals.
 String get format;/// Zero-indexed position of this image in the document/page
@JsonKey(name: 'image_index') int get imageIndex;/// Bits per color component (e.g., 8, 16)
@JsonKey(name: 'bits_per_component') int? get bitsPerComponent;/// Bounding box of the image on the page (PDF coordinates: x0=left, y0=bottom, x1=right, y1=top).
/// Only populated for PDF-extracted images when position data is available from the PDF extractor.
@JsonKey(name: 'bounding_box') BoundingBox? get boundingBox;/// Identifier shared across images that form a single logical figure.
/// (e.g. all raster tiles of one technical drawing). `None` for singletons.
@JsonKey(name: 'cluster_id') int? get clusterId;/// Colorspace information (e.g., "RGB", "CMYK", "Gray")
 String? get colorspace;/// Optional description of the image
 String? get description;/// Image height in pixels
 int? get height;/// Heuristic classification of what this image likely depicts.
/// `None` if classification was disabled or inconclusive.
@JsonKey(name: 'image_kind') ImageKind? get imageKind;/// Whether this image is a mask image
@JsonKey(name: 'is_mask') bool? get isMask;/// Confidence score for `image_kind`, in the range 0.0 to 1.0.
@JsonKey(name: 'kind_confidence') double? get kindConfidence;/// Nested OCR extraction result (if image was OCRed).
///
/// When OCR is performed on this image, the result is embedded here.
/// rather than in a separate collection, making the relationship explicit.
@JsonKey(name: 'ocr_result') ExtractionResult? get ocrResult;/// Page/slide number where image was found (1-indexed)
@JsonKey(name: 'page_number') int? get pageNumber;/// Original source path of the image within the document archive (e.g., "media/image1.png" in DOCX).
/// Used for rendering image references when the binary data is not extracted.
@JsonKey(name: 'source_path') String? get sourcePath;/// Image width in pixels
 int? get width;
/// Create a copy of ExtractedImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExtractedImageCopyWith<ExtractedImage> get copyWith => _$ExtractedImageCopyWithImpl<ExtractedImage>(this as ExtractedImage, _$identity);

  /// Serializes this ExtractedImage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExtractedImage&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.format, format) || other.format == format)&&(identical(other.imageIndex, imageIndex) || other.imageIndex == imageIndex)&&(identical(other.bitsPerComponent, bitsPerComponent) || other.bitsPerComponent == bitsPerComponent)&&(identical(other.boundingBox, boundingBox) || other.boundingBox == boundingBox)&&(identical(other.clusterId, clusterId) || other.clusterId == clusterId)&&(identical(other.colorspace, colorspace) || other.colorspace == colorspace)&&(identical(other.description, description) || other.description == description)&&(identical(other.height, height) || other.height == height)&&(identical(other.imageKind, imageKind) || other.imageKind == imageKind)&&(identical(other.isMask, isMask) || other.isMask == isMask)&&(identical(other.kindConfidence, kindConfidence) || other.kindConfidence == kindConfidence)&&(identical(other.ocrResult, ocrResult) || other.ocrResult == ocrResult)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.sourcePath, sourcePath) || other.sourcePath == sourcePath)&&(identical(other.width, width) || other.width == width));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),format,imageIndex,bitsPerComponent,boundingBox,clusterId,colorspace,description,height,imageKind,isMask,kindConfidence,ocrResult,pageNumber,sourcePath,width);

@override
String toString() {
  return 'ExtractedImage(data: $data, format: $format, imageIndex: $imageIndex, bitsPerComponent: $bitsPerComponent, boundingBox: $boundingBox, clusterId: $clusterId, colorspace: $colorspace, description: $description, height: $height, imageKind: $imageKind, isMask: $isMask, kindConfidence: $kindConfidence, ocrResult: $ocrResult, pageNumber: $pageNumber, sourcePath: $sourcePath, width: $width)';
}


}

/// @nodoc
abstract mixin class $ExtractedImageCopyWith<$Res>  {
  factory $ExtractedImageCopyWith(ExtractedImage value, $Res Function(ExtractedImage) _then) = _$ExtractedImageCopyWithImpl;
@useResult
$Res call({
 List<int> data, String format,@JsonKey(name: 'image_index') int imageIndex,@JsonKey(name: 'bits_per_component') int? bitsPerComponent,@JsonKey(name: 'bounding_box') BoundingBox? boundingBox,@JsonKey(name: 'cluster_id') int? clusterId, String? colorspace, String? description, int? height,@JsonKey(name: 'image_kind') ImageKind? imageKind,@JsonKey(name: 'is_mask') bool? isMask,@JsonKey(name: 'kind_confidence') double? kindConfidence,@JsonKey(name: 'ocr_result') ExtractionResult? ocrResult,@JsonKey(name: 'page_number') int? pageNumber,@JsonKey(name: 'source_path') String? sourcePath, int? width
});


$BoundingBoxCopyWith<$Res>? get boundingBox;$ExtractionResultCopyWith<$Res>? get ocrResult;

}
/// @nodoc
class _$ExtractedImageCopyWithImpl<$Res>
    implements $ExtractedImageCopyWith<$Res> {
  _$ExtractedImageCopyWithImpl(this._self, this._then);

  final ExtractedImage _self;
  final $Res Function(ExtractedImage) _then;

/// Create a copy of ExtractedImage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? format = null,Object? imageIndex = null,Object? bitsPerComponent = freezed,Object? boundingBox = freezed,Object? clusterId = freezed,Object? colorspace = freezed,Object? description = freezed,Object? height = freezed,Object? imageKind = freezed,Object? isMask = freezed,Object? kindConfidence = freezed,Object? ocrResult = freezed,Object? pageNumber = freezed,Object? sourcePath = freezed,Object? width = freezed,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<int>,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,imageIndex: null == imageIndex ? _self.imageIndex : imageIndex // ignore: cast_nullable_to_non_nullable
as int,bitsPerComponent: freezed == bitsPerComponent ? _self.bitsPerComponent : bitsPerComponent // ignore: cast_nullable_to_non_nullable
as int?,boundingBox: freezed == boundingBox ? _self.boundingBox : boundingBox // ignore: cast_nullable_to_non_nullable
as BoundingBox?,clusterId: freezed == clusterId ? _self.clusterId : clusterId // ignore: cast_nullable_to_non_nullable
as int?,colorspace: freezed == colorspace ? _self.colorspace : colorspace // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,imageKind: freezed == imageKind ? _self.imageKind : imageKind // ignore: cast_nullable_to_non_nullable
as ImageKind?,isMask: freezed == isMask ? _self.isMask : isMask // ignore: cast_nullable_to_non_nullable
as bool?,kindConfidence: freezed == kindConfidence ? _self.kindConfidence : kindConfidence // ignore: cast_nullable_to_non_nullable
as double?,ocrResult: freezed == ocrResult ? _self.ocrResult : ocrResult // ignore: cast_nullable_to_non_nullable
as ExtractionResult?,pageNumber: freezed == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int?,sourcePath: freezed == sourcePath ? _self.sourcePath : sourcePath // ignore: cast_nullable_to_non_nullable
as String?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
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
}/// Create a copy of ExtractedImage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExtractionResultCopyWith<$Res>? get ocrResult {
    if (_self.ocrResult == null) {
    return null;
  }

  return $ExtractionResultCopyWith<$Res>(_self.ocrResult!, (value) {
    return _then(_self.copyWith(ocrResult: value));
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExtractedImage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExtractedImage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExtractedImage value)  $default,){
final _that = this;
switch (_that) {
case _ExtractedImage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExtractedImage value)?  $default,){
final _that = this;
switch (_that) {
case _ExtractedImage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<int> data,  String format, @JsonKey(name: 'image_index')  int imageIndex, @JsonKey(name: 'bits_per_component')  int? bitsPerComponent, @JsonKey(name: 'bounding_box')  BoundingBox? boundingBox, @JsonKey(name: 'cluster_id')  int? clusterId,  String? colorspace,  String? description,  int? height, @JsonKey(name: 'image_kind')  ImageKind? imageKind, @JsonKey(name: 'is_mask')  bool? isMask, @JsonKey(name: 'kind_confidence')  double? kindConfidence, @JsonKey(name: 'ocr_result')  ExtractionResult? ocrResult, @JsonKey(name: 'page_number')  int? pageNumber, @JsonKey(name: 'source_path')  String? sourcePath,  int? width)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExtractedImage() when $default != null:
return $default(_that.data,_that.format,_that.imageIndex,_that.bitsPerComponent,_that.boundingBox,_that.clusterId,_that.colorspace,_that.description,_that.height,_that.imageKind,_that.isMask,_that.kindConfidence,_that.ocrResult,_that.pageNumber,_that.sourcePath,_that.width);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<int> data,  String format, @JsonKey(name: 'image_index')  int imageIndex, @JsonKey(name: 'bits_per_component')  int? bitsPerComponent, @JsonKey(name: 'bounding_box')  BoundingBox? boundingBox, @JsonKey(name: 'cluster_id')  int? clusterId,  String? colorspace,  String? description,  int? height, @JsonKey(name: 'image_kind')  ImageKind? imageKind, @JsonKey(name: 'is_mask')  bool? isMask, @JsonKey(name: 'kind_confidence')  double? kindConfidence, @JsonKey(name: 'ocr_result')  ExtractionResult? ocrResult, @JsonKey(name: 'page_number')  int? pageNumber, @JsonKey(name: 'source_path')  String? sourcePath,  int? width)  $default,) {final _that = this;
switch (_that) {
case _ExtractedImage():
return $default(_that.data,_that.format,_that.imageIndex,_that.bitsPerComponent,_that.boundingBox,_that.clusterId,_that.colorspace,_that.description,_that.height,_that.imageKind,_that.isMask,_that.kindConfidence,_that.ocrResult,_that.pageNumber,_that.sourcePath,_that.width);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<int> data,  String format, @JsonKey(name: 'image_index')  int imageIndex, @JsonKey(name: 'bits_per_component')  int? bitsPerComponent, @JsonKey(name: 'bounding_box')  BoundingBox? boundingBox, @JsonKey(name: 'cluster_id')  int? clusterId,  String? colorspace,  String? description,  int? height, @JsonKey(name: 'image_kind')  ImageKind? imageKind, @JsonKey(name: 'is_mask')  bool? isMask, @JsonKey(name: 'kind_confidence')  double? kindConfidence, @JsonKey(name: 'ocr_result')  ExtractionResult? ocrResult, @JsonKey(name: 'page_number')  int? pageNumber, @JsonKey(name: 'source_path')  String? sourcePath,  int? width)?  $default,) {final _that = this;
switch (_that) {
case _ExtractedImage() when $default != null:
return $default(_that.data,_that.format,_that.imageIndex,_that.bitsPerComponent,_that.boundingBox,_that.clusterId,_that.colorspace,_that.description,_that.height,_that.imageKind,_that.isMask,_that.kindConfidence,_that.ocrResult,_that.pageNumber,_that.sourcePath,_that.width);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExtractedImage implements ExtractedImage {
  const _ExtractedImage({required final  List<int> data, required this.format, @JsonKey(name: 'image_index') required this.imageIndex, @JsonKey(name: 'bits_per_component') this.bitsPerComponent, @JsonKey(name: 'bounding_box') this.boundingBox, @JsonKey(name: 'cluster_id') this.clusterId, this.colorspace, this.description, this.height, @JsonKey(name: 'image_kind') this.imageKind, @JsonKey(name: 'is_mask') this.isMask, @JsonKey(name: 'kind_confidence') this.kindConfidence, @JsonKey(name: 'ocr_result') this.ocrResult, @JsonKey(name: 'page_number') this.pageNumber, @JsonKey(name: 'source_path') this.sourcePath, this.width}): _data = data;
  factory _ExtractedImage.fromJson(Map<String, dynamic> json) => _$ExtractedImageFromJson(json);

/// Raw image data (PNG, JPEG, WebP, etc. bytes).
/// Uses `bytes::Bytes` for cheap cloning of large buffers.
 final  List<int> _data;
/// Raw image data (PNG, JPEG, WebP, etc. bytes).
/// Uses `bytes::Bytes` for cheap cloning of large buffers.
@override List<int> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

/// Image format (e.g., "jpeg", "png", "webp").
/// Uses Cow<'static, str> to avoid allocation for static literals.
@override final  String format;
/// Zero-indexed position of this image in the document/page
@override@JsonKey(name: 'image_index') final  int imageIndex;
/// Bits per color component (e.g., 8, 16)
@override@JsonKey(name: 'bits_per_component') final  int? bitsPerComponent;
/// Bounding box of the image on the page (PDF coordinates: x0=left, y0=bottom, x1=right, y1=top).
/// Only populated for PDF-extracted images when position data is available from the PDF extractor.
@override@JsonKey(name: 'bounding_box') final  BoundingBox? boundingBox;
/// Identifier shared across images that form a single logical figure.
/// (e.g. all raster tiles of one technical drawing). `None` for singletons.
@override@JsonKey(name: 'cluster_id') final  int? clusterId;
/// Colorspace information (e.g., "RGB", "CMYK", "Gray")
@override final  String? colorspace;
/// Optional description of the image
@override final  String? description;
/// Image height in pixels
@override final  int? height;
/// Heuristic classification of what this image likely depicts.
/// `None` if classification was disabled or inconclusive.
@override@JsonKey(name: 'image_kind') final  ImageKind? imageKind;
/// Whether this image is a mask image
@override@JsonKey(name: 'is_mask') final  bool? isMask;
/// Confidence score for `image_kind`, in the range 0.0 to 1.0.
@override@JsonKey(name: 'kind_confidence') final  double? kindConfidence;
/// Nested OCR extraction result (if image was OCRed).
///
/// When OCR is performed on this image, the result is embedded here.
/// rather than in a separate collection, making the relationship explicit.
@override@JsonKey(name: 'ocr_result') final  ExtractionResult? ocrResult;
/// Page/slide number where image was found (1-indexed)
@override@JsonKey(name: 'page_number') final  int? pageNumber;
/// Original source path of the image within the document archive (e.g., "media/image1.png" in DOCX).
/// Used for rendering image references when the binary data is not extracted.
@override@JsonKey(name: 'source_path') final  String? sourcePath;
/// Image width in pixels
@override final  int? width;

/// Create a copy of ExtractedImage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExtractedImageCopyWith<_ExtractedImage> get copyWith => __$ExtractedImageCopyWithImpl<_ExtractedImage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExtractedImageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExtractedImage&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.format, format) || other.format == format)&&(identical(other.imageIndex, imageIndex) || other.imageIndex == imageIndex)&&(identical(other.bitsPerComponent, bitsPerComponent) || other.bitsPerComponent == bitsPerComponent)&&(identical(other.boundingBox, boundingBox) || other.boundingBox == boundingBox)&&(identical(other.clusterId, clusterId) || other.clusterId == clusterId)&&(identical(other.colorspace, colorspace) || other.colorspace == colorspace)&&(identical(other.description, description) || other.description == description)&&(identical(other.height, height) || other.height == height)&&(identical(other.imageKind, imageKind) || other.imageKind == imageKind)&&(identical(other.isMask, isMask) || other.isMask == isMask)&&(identical(other.kindConfidence, kindConfidence) || other.kindConfidence == kindConfidence)&&(identical(other.ocrResult, ocrResult) || other.ocrResult == ocrResult)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.sourcePath, sourcePath) || other.sourcePath == sourcePath)&&(identical(other.width, width) || other.width == width));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),format,imageIndex,bitsPerComponent,boundingBox,clusterId,colorspace,description,height,imageKind,isMask,kindConfidence,ocrResult,pageNumber,sourcePath,width);

@override
String toString() {
  return 'ExtractedImage(data: $data, format: $format, imageIndex: $imageIndex, bitsPerComponent: $bitsPerComponent, boundingBox: $boundingBox, clusterId: $clusterId, colorspace: $colorspace, description: $description, height: $height, imageKind: $imageKind, isMask: $isMask, kindConfidence: $kindConfidence, ocrResult: $ocrResult, pageNumber: $pageNumber, sourcePath: $sourcePath, width: $width)';
}


}

/// @nodoc
abstract mixin class _$ExtractedImageCopyWith<$Res> implements $ExtractedImageCopyWith<$Res> {
  factory _$ExtractedImageCopyWith(_ExtractedImage value, $Res Function(_ExtractedImage) _then) = __$ExtractedImageCopyWithImpl;
@override @useResult
$Res call({
 List<int> data, String format,@JsonKey(name: 'image_index') int imageIndex,@JsonKey(name: 'bits_per_component') int? bitsPerComponent,@JsonKey(name: 'bounding_box') BoundingBox? boundingBox,@JsonKey(name: 'cluster_id') int? clusterId, String? colorspace, String? description, int? height,@JsonKey(name: 'image_kind') ImageKind? imageKind,@JsonKey(name: 'is_mask') bool? isMask,@JsonKey(name: 'kind_confidence') double? kindConfidence,@JsonKey(name: 'ocr_result') ExtractionResult? ocrResult,@JsonKey(name: 'page_number') int? pageNumber,@JsonKey(name: 'source_path') String? sourcePath, int? width
});


@override $BoundingBoxCopyWith<$Res>? get boundingBox;@override $ExtractionResultCopyWith<$Res>? get ocrResult;

}
/// @nodoc
class __$ExtractedImageCopyWithImpl<$Res>
    implements _$ExtractedImageCopyWith<$Res> {
  __$ExtractedImageCopyWithImpl(this._self, this._then);

  final _ExtractedImage _self;
  final $Res Function(_ExtractedImage) _then;

/// Create a copy of ExtractedImage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? format = null,Object? imageIndex = null,Object? bitsPerComponent = freezed,Object? boundingBox = freezed,Object? clusterId = freezed,Object? colorspace = freezed,Object? description = freezed,Object? height = freezed,Object? imageKind = freezed,Object? isMask = freezed,Object? kindConfidence = freezed,Object? ocrResult = freezed,Object? pageNumber = freezed,Object? sourcePath = freezed,Object? width = freezed,}) {
  return _then(_ExtractedImage(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<int>,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,imageIndex: null == imageIndex ? _self.imageIndex : imageIndex // ignore: cast_nullable_to_non_nullable
as int,bitsPerComponent: freezed == bitsPerComponent ? _self.bitsPerComponent : bitsPerComponent // ignore: cast_nullable_to_non_nullable
as int?,boundingBox: freezed == boundingBox ? _self.boundingBox : boundingBox // ignore: cast_nullable_to_non_nullable
as BoundingBox?,clusterId: freezed == clusterId ? _self.clusterId : clusterId // ignore: cast_nullable_to_non_nullable
as int?,colorspace: freezed == colorspace ? _self.colorspace : colorspace // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,imageKind: freezed == imageKind ? _self.imageKind : imageKind // ignore: cast_nullable_to_non_nullable
as ImageKind?,isMask: freezed == isMask ? _self.isMask : isMask // ignore: cast_nullable_to_non_nullable
as bool?,kindConfidence: freezed == kindConfidence ? _self.kindConfidence : kindConfidence // ignore: cast_nullable_to_non_nullable
as double?,ocrResult: freezed == ocrResult ? _self.ocrResult : ocrResult // ignore: cast_nullable_to_non_nullable
as ExtractionResult?,pageNumber: freezed == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int?,sourcePath: freezed == sourcePath ? _self.sourcePath : sourcePath // ignore: cast_nullable_to_non_nullable
as String?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
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
}/// Create a copy of ExtractedImage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExtractionResultCopyWith<$Res>? get ocrResult {
    if (_self.ocrResult == null) {
    return null;
  }

  return $ExtractionResultCopyWith<$Res>(_self.ocrResult!, (value) {
    return _then(_self.copyWith(ocrResult: value));
  });
}
}

// dart format on
