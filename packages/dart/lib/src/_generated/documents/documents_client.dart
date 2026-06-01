// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/diff_response.dart';
import '../models/document_version_entry.dart';

part 'documents_client.g.dart';

@RestApi()
abstract class DocumentsClient {
  factory DocumentsClient(Dio dio, {String? baseUrl}) = _DocumentsClient;

  /// Get the latest version of a document with its extraction result.
  ///
  /// [documentId] - Logical document ID.
  @GET('/v1/documents/{document_id}')
  Future<void> getLatest({@Path('document_id') required String documentId});

  /// Compute diff between two versions (sync with async fallback on budget exceeded).
  ///
  /// [documentId] - Logical document ID.
  ///
  /// [from] - Source version (sequence integer or job UUID).
  ///
  /// [to] - Target version (sequence integer or job UUID).
  @GET('/v1/documents/{document_id}/diff')
  Future<DiffResponse> getDiff({
    @Path('document_id') required String documentId,
    @Query('from') required String from,
    @Query('to') required String to,
  });

  /// Poll the status of an async diff job.
  ///
  /// [documentId] - Logical document ID.
  ///
  /// [diffJobId] - Async diff job ID returned by the 202 fallback.
  @GET('/v1/documents/{document_id}/diff/{diff_job_id}')
  Future<DiffResponse> pollDiff({
    @Path('document_id') required String documentId,
    @Path('diff_job_id') required String diffJobId,
  });

  /// List all versions of a document with pagination.
  ///
  /// [documentId] - Logical document ID.
  @GET('/v1/documents/{document_id}/versions')
  Future<List<DocumentVersionEntry>> listVersions({
    @Path('document_id') required String documentId,
  });
}
