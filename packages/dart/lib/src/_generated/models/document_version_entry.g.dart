// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_version_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DocumentVersionEntry _$DocumentVersionEntryFromJson(
  Map<String, dynamic> json,
) => _DocumentVersionEntry(
  billablePages: (json['billable_pages'] as num).toInt(),
  contentHash: json['content_hash'] as String,
  createdAt: json['created_at'] as String,
  fileSizeBytes: (json['file_size_bytes'] as num).toInt(),
  filename: json['filename'] as String,
  jobId: json['job_id'] as String,
  mimeType: json['mime_type'] as String,
  pagesExtracted: (json['pages_extracted'] as num).toInt(),
  status: json['status'] as String,
  versionSequence: (json['version_sequence'] as num).toInt(),
  processingCompletedAt: json['processing_completed_at'] as String?,
);

Map<String, dynamic> _$DocumentVersionEntryToJson(
  _DocumentVersionEntry instance,
) => <String, dynamic>{
  'billable_pages': instance.billablePages,
  'content_hash': instance.contentHash,
  'created_at': instance.createdAt,
  'file_size_bytes': instance.fileSizeBytes,
  'filename': instance.filename,
  'job_id': instance.jobId,
  'mime_type': instance.mimeType,
  'pages_extracted': instance.pagesExtracted,
  'status': instance.status,
  'version_sequence': instance.versionSequence,
  'processing_completed_at': instance.processingCompletedAt,
};
