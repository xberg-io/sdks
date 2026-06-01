// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EmailMetadata _$EmailMetadataFromJson(Map<String, dynamic> json) =>
    _EmailMetadata(
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      bccEmails: (json['bcc_emails'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      ccEmails: (json['cc_emails'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      toEmails: (json['to_emails'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      fromEmail: json['from_email'] as String?,
      fromName: json['from_name'] as String?,
      messageId: json['message_id'] as String?,
    );

Map<String, dynamic> _$EmailMetadataToJson(_EmailMetadata instance) =>
    <String, dynamic>{
      'attachments': instance.attachments,
      'bcc_emails': instance.bccEmails,
      'cc_emails': instance.ccEmails,
      'to_emails': instance.toEmails,
      'from_email': instance.fromEmail,
      'from_name': instance.fromName,
      'message_id': instance.messageId,
    };
