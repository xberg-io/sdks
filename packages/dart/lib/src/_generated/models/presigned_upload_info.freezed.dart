// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'presigned_upload_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PresignedUploadInfo {
  /// Seconds until the URL expires
  @JsonKey(name: 'expires_in_secs')
  int get expiresInSecs;

  /// Job ID for this document
  @JsonKey(name: 'job_id')
  String get jobId;

  /// HTTP method to use (PUT)
  String get method;

  /// Storage object key
  @JsonKey(name: 'object_key')
  String get objectKey;

  /// Presigned URL to upload the document to
  @JsonKey(name: 'upload_url')
  String get uploadUrl;

  /// Create a copy of PresignedUploadInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PresignedUploadInfoCopyWith<PresignedUploadInfo> get copyWith =>
      _$PresignedUploadInfoCopyWithImpl<PresignedUploadInfo>(
          this as PresignedUploadInfo, _$identity);

  /// Serializes this PresignedUploadInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PresignedUploadInfo &&
            (identical(other.expiresInSecs, expiresInSecs) ||
                other.expiresInSecs == expiresInSecs) &&
            (identical(other.jobId, jobId) || other.jobId == jobId) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.objectKey, objectKey) ||
                other.objectKey == objectKey) &&
            (identical(other.uploadUrl, uploadUrl) ||
                other.uploadUrl == uploadUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, expiresInSecs, jobId, method, objectKey, uploadUrl);

  @override
  String toString() {
    return 'PresignedUploadInfo(expiresInSecs: $expiresInSecs, jobId: $jobId, method: $method, objectKey: $objectKey, uploadUrl: $uploadUrl)';
  }
}

/// @nodoc
abstract mixin class $PresignedUploadInfoCopyWith<$Res> {
  factory $PresignedUploadInfoCopyWith(
          PresignedUploadInfo value, $Res Function(PresignedUploadInfo) _then) =
      _$PresignedUploadInfoCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'expires_in_secs') int expiresInSecs,
      @JsonKey(name: 'job_id') String jobId,
      String method,
      @JsonKey(name: 'object_key') String objectKey,
      @JsonKey(name: 'upload_url') String uploadUrl});
}

/// @nodoc
class _$PresignedUploadInfoCopyWithImpl<$Res>
    implements $PresignedUploadInfoCopyWith<$Res> {
  _$PresignedUploadInfoCopyWithImpl(this._self, this._then);

  final PresignedUploadInfo _self;
  final $Res Function(PresignedUploadInfo) _then;

  /// Create a copy of PresignedUploadInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expiresInSecs = null,
    Object? jobId = null,
    Object? method = null,
    Object? objectKey = null,
    Object? uploadUrl = null,
  }) {
    return _then(_self.copyWith(
      expiresInSecs: null == expiresInSecs
          ? _self.expiresInSecs
          : expiresInSecs // ignore: cast_nullable_to_non_nullable
              as int,
      jobId: null == jobId
          ? _self.jobId
          : jobId // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _self.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      objectKey: null == objectKey
          ? _self.objectKey
          : objectKey // ignore: cast_nullable_to_non_nullable
              as String,
      uploadUrl: null == uploadUrl
          ? _self.uploadUrl
          : uploadUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [PresignedUploadInfo].
extension PresignedUploadInfoPatterns on PresignedUploadInfo {
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
    TResult Function(_PresignedUploadInfo value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PresignedUploadInfo() when $default != null:
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
    TResult Function(_PresignedUploadInfo value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PresignedUploadInfo():
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
    TResult? Function(_PresignedUploadInfo value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PresignedUploadInfo() when $default != null:
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
            @JsonKey(name: 'expires_in_secs') int expiresInSecs,
            @JsonKey(name: 'job_id') String jobId,
            String method,
            @JsonKey(name: 'object_key') String objectKey,
            @JsonKey(name: 'upload_url') String uploadUrl)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PresignedUploadInfo() when $default != null:
        return $default(_that.expiresInSecs, _that.jobId, _that.method,
            _that.objectKey, _that.uploadUrl);
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
            @JsonKey(name: 'expires_in_secs') int expiresInSecs,
            @JsonKey(name: 'job_id') String jobId,
            String method,
            @JsonKey(name: 'object_key') String objectKey,
            @JsonKey(name: 'upload_url') String uploadUrl)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PresignedUploadInfo():
        return $default(_that.expiresInSecs, _that.jobId, _that.method,
            _that.objectKey, _that.uploadUrl);
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
            @JsonKey(name: 'expires_in_secs') int expiresInSecs,
            @JsonKey(name: 'job_id') String jobId,
            String method,
            @JsonKey(name: 'object_key') String objectKey,
            @JsonKey(name: 'upload_url') String uploadUrl)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PresignedUploadInfo() when $default != null:
        return $default(_that.expiresInSecs, _that.jobId, _that.method,
            _that.objectKey, _that.uploadUrl);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PresignedUploadInfo implements PresignedUploadInfo {
  const _PresignedUploadInfo(
      {@JsonKey(name: 'expires_in_secs') required this.expiresInSecs,
      @JsonKey(name: 'job_id') required this.jobId,
      required this.method,
      @JsonKey(name: 'object_key') required this.objectKey,
      @JsonKey(name: 'upload_url') required this.uploadUrl});
  factory _PresignedUploadInfo.fromJson(Map<String, dynamic> json) =>
      _$PresignedUploadInfoFromJson(json);

  /// Seconds until the URL expires
  @override
  @JsonKey(name: 'expires_in_secs')
  final int expiresInSecs;

  /// Job ID for this document
  @override
  @JsonKey(name: 'job_id')
  final String jobId;

  /// HTTP method to use (PUT)
  @override
  final String method;

  /// Storage object key
  @override
  @JsonKey(name: 'object_key')
  final String objectKey;

  /// Presigned URL to upload the document to
  @override
  @JsonKey(name: 'upload_url')
  final String uploadUrl;

  /// Create a copy of PresignedUploadInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PresignedUploadInfoCopyWith<_PresignedUploadInfo> get copyWith =>
      __$PresignedUploadInfoCopyWithImpl<_PresignedUploadInfo>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PresignedUploadInfoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PresignedUploadInfo &&
            (identical(other.expiresInSecs, expiresInSecs) ||
                other.expiresInSecs == expiresInSecs) &&
            (identical(other.jobId, jobId) || other.jobId == jobId) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.objectKey, objectKey) ||
                other.objectKey == objectKey) &&
            (identical(other.uploadUrl, uploadUrl) ||
                other.uploadUrl == uploadUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, expiresInSecs, jobId, method, objectKey, uploadUrl);

  @override
  String toString() {
    return 'PresignedUploadInfo(expiresInSecs: $expiresInSecs, jobId: $jobId, method: $method, objectKey: $objectKey, uploadUrl: $uploadUrl)';
  }
}

/// @nodoc
abstract mixin class _$PresignedUploadInfoCopyWith<$Res>
    implements $PresignedUploadInfoCopyWith<$Res> {
  factory _$PresignedUploadInfoCopyWith(_PresignedUploadInfo value,
          $Res Function(_PresignedUploadInfo) _then) =
      __$PresignedUploadInfoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'expires_in_secs') int expiresInSecs,
      @JsonKey(name: 'job_id') String jobId,
      String method,
      @JsonKey(name: 'object_key') String objectKey,
      @JsonKey(name: 'upload_url') String uploadUrl});
}

/// @nodoc
class __$PresignedUploadInfoCopyWithImpl<$Res>
    implements _$PresignedUploadInfoCopyWith<$Res> {
  __$PresignedUploadInfoCopyWithImpl(this._self, this._then);

  final _PresignedUploadInfo _self;
  final $Res Function(_PresignedUploadInfo) _then;

  /// Create a copy of PresignedUploadInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? expiresInSecs = null,
    Object? jobId = null,
    Object? method = null,
    Object? objectKey = null,
    Object? uploadUrl = null,
  }) {
    return _then(_PresignedUploadInfo(
      expiresInSecs: null == expiresInSecs
          ? _self.expiresInSecs
          : expiresInSecs // ignore: cast_nullable_to_non_nullable
              as int,
      jobId: null == jobId
          ? _self.jobId
          : jobId // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _self.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      objectKey: null == objectKey
          ? _self.objectKey
          : objectKey // ignore: cast_nullable_to_non_nullable
              as String,
      uploadUrl: null == uploadUrl
          ? _self.uploadUrl
          : uploadUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
