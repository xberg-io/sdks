// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_submission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DocumentSubmission _$DocumentSubmissionFromJson(Map<String, dynamic> json) =>
    _DocumentSubmission(
      jobId: json['job_id'] as String,
      documentId: json['document_id'] as String?,
      versionSequence: (json['version_sequence'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DocumentSubmissionToJson(_DocumentSubmission instance) =>
    <String, dynamic>{
      'job_id': instance.jobId,
      'document_id': instance.documentId,
      'version_sequence': instance.versionSequence,
    };
