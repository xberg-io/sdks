// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'format_metadata.dart';

part 'email_metadata.freezed.dart';
part 'email_metadata.g.dart';

/// Email metadata extracted from .eml and .msg files.
///
/// Includes sender/recipient information, message ID, and attachment list.
@Freezed()
abstract class EmailMetadata with _$EmailMetadata {
  const factory EmailMetadata({
    /// List of attachment filenames
    required List<String> attachments,

    /// BCC recipients
    @JsonKey(name: 'bcc_emails') required List<String> bccEmails,

    /// CC recipients
    @JsonKey(name: 'cc_emails') required List<String> ccEmails,

    /// Primary recipients
    @JsonKey(name: 'to_emails') required List<String> toEmails,

    /// Sender's email address
    @JsonKey(name: 'from_email') String? fromEmail,

    /// Sender's display name
    @JsonKey(name: 'from_name') String? fromName,

    /// Message-ID header value
    @JsonKey(name: 'message_id') String? messageId,
  }) = _EmailMetadata;

  factory EmailMetadata.fromJson(Map<String, Object?> json) =>
      _$EmailMetadataFromJson(json);
}
