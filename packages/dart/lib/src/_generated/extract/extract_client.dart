// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/extract_json_request.dart';
import '../models/extract_response.dart';

part 'extract_client.g.dart';

@RestApi()
abstract class ExtractClient {
  factory ExtractClient(Dio dio, {String? baseUrl}) = _ExtractClient;

  /// `POST /v1/extract` — Submit documents for extraction.
  ///
  /// Accepts `application/json` or `multipart/form-data`.
  ///
  /// **JSON body**: `{"documents": [...], "options": {...}, "webhook": {"url": "...", "secret": "...", "metadata": {...}}}`.
  ///
  /// **Multipart**: file parts (binary) + `webhook` part (JSON string) + optional `options` part (JSON string).
  ///
  /// Returns 202 Accepted with job IDs. Results are delivered via the configured webhook.
  @POST('/v1/extract')
  Future<ExtractResponse> extract({@Body() required ExtractJsonRequest body});
}
