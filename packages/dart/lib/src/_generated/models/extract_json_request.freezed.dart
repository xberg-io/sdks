// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'extract_json_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExtractJsonRequest {
  /// Documents to process
  List<DocumentInput> get documents;

  /// Extraction options (optional)
  ExtractionOptions? get options;

  /// Webhook configuration for async result delivery (optional)
  WebhookConfig? get webhook;

  /// Create a copy of ExtractJsonRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExtractJsonRequestCopyWith<ExtractJsonRequest> get copyWith =>
      _$ExtractJsonRequestCopyWithImpl<ExtractJsonRequest>(
          this as ExtractJsonRequest, _$identity);

  /// Serializes this ExtractJsonRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExtractJsonRequest &&
            const DeepCollectionEquality().equals(other.documents, documents) &&
            (identical(other.options, options) || other.options == options) &&
            (identical(other.webhook, webhook) || other.webhook == webhook));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(documents), options, webhook);

  @override
  String toString() {
    return 'ExtractJsonRequest(documents: $documents, options: $options, webhook: $webhook)';
  }
}

/// @nodoc
abstract mixin class $ExtractJsonRequestCopyWith<$Res> {
  factory $ExtractJsonRequestCopyWith(
          ExtractJsonRequest value, $Res Function(ExtractJsonRequest) _then) =
      _$ExtractJsonRequestCopyWithImpl;
  @useResult
  $Res call(
      {List<DocumentInput> documents,
      ExtractionOptions? options,
      WebhookConfig? webhook});

  $ExtractionOptionsCopyWith<$Res>? get options;
  $WebhookConfigCopyWith<$Res>? get webhook;
}

/// @nodoc
class _$ExtractJsonRequestCopyWithImpl<$Res>
    implements $ExtractJsonRequestCopyWith<$Res> {
  _$ExtractJsonRequestCopyWithImpl(this._self, this._then);

  final ExtractJsonRequest _self;
  final $Res Function(ExtractJsonRequest) _then;

  /// Create a copy of ExtractJsonRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? documents = null,
    Object? options = freezed,
    Object? webhook = freezed,
  }) {
    return _then(_self.copyWith(
      documents: null == documents
          ? _self.documents
          : documents // ignore: cast_nullable_to_non_nullable
              as List<DocumentInput>,
      options: freezed == options
          ? _self.options
          : options // ignore: cast_nullable_to_non_nullable
              as ExtractionOptions?,
      webhook: freezed == webhook
          ? _self.webhook
          : webhook // ignore: cast_nullable_to_non_nullable
              as WebhookConfig?,
    ));
  }

  /// Create a copy of ExtractJsonRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExtractionOptionsCopyWith<$Res>? get options {
    if (_self.options == null) {
      return null;
    }

    return $ExtractionOptionsCopyWith<$Res>(_self.options!, (value) {
      return _then(_self.copyWith(options: value));
    });
  }

  /// Create a copy of ExtractJsonRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WebhookConfigCopyWith<$Res>? get webhook {
    if (_self.webhook == null) {
      return null;
    }

    return $WebhookConfigCopyWith<$Res>(_self.webhook!, (value) {
      return _then(_self.copyWith(webhook: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ExtractJsonRequest].
extension ExtractJsonRequestPatterns on ExtractJsonRequest {
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
    TResult Function(_ExtractJsonRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExtractJsonRequest() when $default != null:
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
    TResult Function(_ExtractJsonRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExtractJsonRequest():
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
    TResult? Function(_ExtractJsonRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExtractJsonRequest() when $default != null:
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
    TResult Function(List<DocumentInput> documents, ExtractionOptions? options,
            WebhookConfig? webhook)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExtractJsonRequest() when $default != null:
        return $default(_that.documents, _that.options, _that.webhook);
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
    TResult Function(List<DocumentInput> documents, ExtractionOptions? options,
            WebhookConfig? webhook)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExtractJsonRequest():
        return $default(_that.documents, _that.options, _that.webhook);
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
    TResult? Function(List<DocumentInput> documents, ExtractionOptions? options,
            WebhookConfig? webhook)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExtractJsonRequest() when $default != null:
        return $default(_that.documents, _that.options, _that.webhook);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExtractJsonRequest implements ExtractJsonRequest {
  const _ExtractJsonRequest(
      {required final List<DocumentInput> documents,
      this.options,
      this.webhook})
      : _documents = documents;
  factory _ExtractJsonRequest.fromJson(Map<String, dynamic> json) =>
      _$ExtractJsonRequestFromJson(json);

  /// Documents to process
  final List<DocumentInput> _documents;

  /// Documents to process
  @override
  List<DocumentInput> get documents {
    if (_documents is EqualUnmodifiableListView) return _documents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_documents);
  }

  /// Extraction options (optional)
  @override
  final ExtractionOptions? options;

  /// Webhook configuration for async result delivery (optional)
  @override
  final WebhookConfig? webhook;

  /// Create a copy of ExtractJsonRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExtractJsonRequestCopyWith<_ExtractJsonRequest> get copyWith =>
      __$ExtractJsonRequestCopyWithImpl<_ExtractJsonRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExtractJsonRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExtractJsonRequest &&
            const DeepCollectionEquality()
                .equals(other._documents, _documents) &&
            (identical(other.options, options) || other.options == options) &&
            (identical(other.webhook, webhook) || other.webhook == webhook));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_documents), options, webhook);

  @override
  String toString() {
    return 'ExtractJsonRequest(documents: $documents, options: $options, webhook: $webhook)';
  }
}

/// @nodoc
abstract mixin class _$ExtractJsonRequestCopyWith<$Res>
    implements $ExtractJsonRequestCopyWith<$Res> {
  factory _$ExtractJsonRequestCopyWith(
          _ExtractJsonRequest value, $Res Function(_ExtractJsonRequest) _then) =
      __$ExtractJsonRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<DocumentInput> documents,
      ExtractionOptions? options,
      WebhookConfig? webhook});

  @override
  $ExtractionOptionsCopyWith<$Res>? get options;
  @override
  $WebhookConfigCopyWith<$Res>? get webhook;
}

/// @nodoc
class __$ExtractJsonRequestCopyWithImpl<$Res>
    implements _$ExtractJsonRequestCopyWith<$Res> {
  __$ExtractJsonRequestCopyWithImpl(this._self, this._then);

  final _ExtractJsonRequest _self;
  final $Res Function(_ExtractJsonRequest) _then;

  /// Create a copy of ExtractJsonRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? documents = null,
    Object? options = freezed,
    Object? webhook = freezed,
  }) {
    return _then(_ExtractJsonRequest(
      documents: null == documents
          ? _self._documents
          : documents // ignore: cast_nullable_to_non_nullable
              as List<DocumentInput>,
      options: freezed == options
          ? _self.options
          : options // ignore: cast_nullable_to_non_nullable
              as ExtractionOptions?,
      webhook: freezed == webhook
          ? _self.webhook
          : webhook // ignore: cast_nullable_to_non_nullable
              as WebhookConfig?,
    ));
  }

  /// Create a copy of ExtractJsonRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExtractionOptionsCopyWith<$Res>? get options {
    if (_self.options == null) {
      return null;
    }

    return $ExtractionOptionsCopyWith<$Res>(_self.options!, (value) {
      return _then(_self.copyWith(options: value));
    });
  }

  /// Create a copy of ExtractJsonRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WebhookConfigCopyWith<$Res>? get webhook {
    if (_self.webhook == null) {
      return null;
    }

    return $WebhookConfigCopyWith<$Res>(_self.webhook!, (value) {
      return _then(_self.copyWith(webhook: value));
    });
  }
}

// dart format on
