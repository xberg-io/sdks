// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/create_sandbox_key_response.dart';

part 'super_sandbox_client.g.dart';

@RestApi()
abstract class SuperSandboxClient {
  factory SuperSandboxClient(Dio dio, {String? baseUrl}) = _SuperSandboxClient;

  /// Create sandbox API key.
  ///
  /// Issues an ephemeral API key valid for 24 hours with a 50-page quota.
  /// Limited to 10 keys per IP per 24 hours to prevent abuse.
  ///
  /// # Returns.
  /// - `200 OK` with `CreateSandboxKeyResponse` on success.
  /// - `429 Too Many Requests` if IP has issued 10+ keys in past 24 hours.
  /// - `500 Internal Server Error` on database errors.
  @POST('/v1/sandbox/key')
  Future<CreateSandboxKeyResponse> createSandboxKey();
}
