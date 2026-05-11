// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobResponse {
  /// Job creation timestamp (RFC3339)
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Original filename
  String get filename;

  /// Unique job identifier (UUID)
  String get id;

  /// Job status
  JobStatus get status;

  /// Server-side processing duration in milliseconds (only present when completed)
  @JsonKey(name: 'processing_time_ms')
  int? get processingTimeMs;

  /// Extraction result (only present when status is completed/partial_success)
  ExtractionResult? get result;

  /// Create a copy of JobResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $JobResponseCopyWith<JobResponse> get copyWith =>
      _$JobResponseCopyWithImpl<JobResponse>(this as JobResponse, _$identity);

  /// Serializes this JobResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is JobResponse &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.processingTimeMs, processingTimeMs) ||
                other.processingTimeMs == processingTimeMs) &&
            (identical(other.result, result) || other.result == result));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, createdAt, filename, id, status, processingTimeMs, result);

  @override
  String toString() {
    return 'JobResponse(createdAt: $createdAt, filename: $filename, id: $id, status: $status, processingTimeMs: $processingTimeMs, result: $result)';
  }
}

/// @nodoc
abstract mixin class $JobResponseCopyWith<$Res> {
  factory $JobResponseCopyWith(
          JobResponse value, $Res Function(JobResponse) _then) =
      _$JobResponseCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'created_at') DateTime createdAt,
      String filename,
      String id,
      JobStatus status,
      @JsonKey(name: 'processing_time_ms') int? processingTimeMs,
      ExtractionResult? result});

  $ExtractionResultCopyWith<$Res>? get result;
}

/// @nodoc
class _$JobResponseCopyWithImpl<$Res> implements $JobResponseCopyWith<$Res> {
  _$JobResponseCopyWithImpl(this._self, this._then);

  final JobResponse _self;
  final $Res Function(JobResponse) _then;

  /// Create a copy of JobResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? filename = null,
    Object? id = null,
    Object? status = null,
    Object? processingTimeMs = freezed,
    Object? result = freezed,
  }) {
    return _then(_self.copyWith(
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      filename: null == filename
          ? _self.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as JobStatus,
      processingTimeMs: freezed == processingTimeMs
          ? _self.processingTimeMs
          : processingTimeMs // ignore: cast_nullable_to_non_nullable
              as int?,
      result: freezed == result
          ? _self.result
          : result // ignore: cast_nullable_to_non_nullable
              as ExtractionResult?,
    ));
  }

  /// Create a copy of JobResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExtractionResultCopyWith<$Res>? get result {
    if (_self.result == null) {
      return null;
    }

    return $ExtractionResultCopyWith<$Res>(_self.result!, (value) {
      return _then(_self.copyWith(result: value));
    });
  }
}

/// Adds pattern-matching-related methods to [JobResponse].
extension JobResponsePatterns on JobResponse {
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
    TResult Function(_JobResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _JobResponse() when $default != null:
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
    TResult Function(_JobResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _JobResponse():
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
    TResult? Function(_JobResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _JobResponse() when $default != null:
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
            @JsonKey(name: 'created_at') DateTime createdAt,
            String filename,
            String id,
            JobStatus status,
            @JsonKey(name: 'processing_time_ms') int? processingTimeMs,
            ExtractionResult? result)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _JobResponse() when $default != null:
        return $default(_that.createdAt, _that.filename, _that.id, _that.status,
            _that.processingTimeMs, _that.result);
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
            @JsonKey(name: 'created_at') DateTime createdAt,
            String filename,
            String id,
            JobStatus status,
            @JsonKey(name: 'processing_time_ms') int? processingTimeMs,
            ExtractionResult? result)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _JobResponse():
        return $default(_that.createdAt, _that.filename, _that.id, _that.status,
            _that.processingTimeMs, _that.result);
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
            @JsonKey(name: 'created_at') DateTime createdAt,
            String filename,
            String id,
            JobStatus status,
            @JsonKey(name: 'processing_time_ms') int? processingTimeMs,
            ExtractionResult? result)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _JobResponse() when $default != null:
        return $default(_that.createdAt, _that.filename, _that.id, _that.status,
            _that.processingTimeMs, _that.result);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _JobResponse implements JobResponse {
  const _JobResponse(
      {@JsonKey(name: 'created_at') required this.createdAt,
      required this.filename,
      required this.id,
      required this.status,
      @JsonKey(name: 'processing_time_ms') this.processingTimeMs,
      this.result});
  factory _JobResponse.fromJson(Map<String, dynamic> json) =>
      _$JobResponseFromJson(json);

  /// Job creation timestamp (RFC3339)
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// Original filename
  @override
  final String filename;

  /// Unique job identifier (UUID)
  @override
  final String id;

  /// Job status
  @override
  final JobStatus status;

  /// Server-side processing duration in milliseconds (only present when completed)
  @override
  @JsonKey(name: 'processing_time_ms')
  final int? processingTimeMs;

  /// Extraction result (only present when status is completed/partial_success)
  @override
  final ExtractionResult? result;

  /// Create a copy of JobResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$JobResponseCopyWith<_JobResponse> get copyWith =>
      __$JobResponseCopyWithImpl<_JobResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$JobResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _JobResponse &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.processingTimeMs, processingTimeMs) ||
                other.processingTimeMs == processingTimeMs) &&
            (identical(other.result, result) || other.result == result));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, createdAt, filename, id, status, processingTimeMs, result);

  @override
  String toString() {
    return 'JobResponse(createdAt: $createdAt, filename: $filename, id: $id, status: $status, processingTimeMs: $processingTimeMs, result: $result)';
  }
}

/// @nodoc
abstract mixin class _$JobResponseCopyWith<$Res>
    implements $JobResponseCopyWith<$Res> {
  factory _$JobResponseCopyWith(
          _JobResponse value, $Res Function(_JobResponse) _then) =
      __$JobResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'created_at') DateTime createdAt,
      String filename,
      String id,
      JobStatus status,
      @JsonKey(name: 'processing_time_ms') int? processingTimeMs,
      ExtractionResult? result});

  @override
  $ExtractionResultCopyWith<$Res>? get result;
}

/// @nodoc
class __$JobResponseCopyWithImpl<$Res> implements _$JobResponseCopyWith<$Res> {
  __$JobResponseCopyWithImpl(this._self, this._then);

  final _JobResponse _self;
  final $Res Function(_JobResponse) _then;

  /// Create a copy of JobResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? createdAt = null,
    Object? filename = null,
    Object? id = null,
    Object? status = null,
    Object? processingTimeMs = freezed,
    Object? result = freezed,
  }) {
    return _then(_JobResponse(
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      filename: null == filename
          ? _self.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as JobStatus,
      processingTimeMs: freezed == processingTimeMs
          ? _self.processingTimeMs
          : processingTimeMs // ignore: cast_nullable_to_non_nullable
              as int?,
      result: freezed == result
          ? _self.result
          : result // ignore: cast_nullable_to_non_nullable
              as ExtractionResult?,
    ));
  }

  /// Create a copy of JobResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExtractionResultCopyWith<$Res>? get result {
    if (_self.result == null) {
      return null;
    }

    return $ExtractionResultCopyWith<$Res>(_self.result!, (value) {
      return _then(_self.copyWith(result: value));
    });
  }
}

// dart format on
