// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/confirm_upload_request.dart';
import '../models/confirm_upload_response.dart';
import '../models/presign_upload_request.dart';
import '../models/presign_upload_response.dart';

part 'uploads_client.g.dart';

@RestApi()
abstract class UploadsClient {
  factory UploadsClient(Dio dio, {String? baseUrl}) = _UploadsClient;

  /// Confirm uploads and start processing.
  ///
  /// Verifies all files exist in storage, then dispatches jobs to the worker queue.
  @POST('/v1/uploads/confirm')
  Future<ConfirmUploadResponse> confirmUpload({
    @Body() required ConfirmUploadRequest body,
  });

  /// Generate presigned upload URLs.
  ///
  /// Returns upload URLs for each document. The client uploads files directly.
  /// to storage, then calls `/v1/uploads/confirm` to trigger processing.
  @POST('/v1/uploads/presign')
  Future<PresignUploadResponse> presignUpload({
    @Body() required PresignUploadRequest body,
  });
}
