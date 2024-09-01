///
/// http_api.dart
/// lib/core/api
///
/// Created by Indra Mahesa https://github.com/zinct
///

import 'dart:io';

import 'package:dio/dio.dart';

import 'api.dart';

class HttpApi extends Api {
  @override
  void clearToken() {
    // TODO: implement clearToken
  }

  @override
  Future<ApiResponse> delete(
    String path, {
    ApiFormData? formData,
    Map<String, String>? formObj,
    Map<String, String>? queryParameters,
    Options? options,
  }) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> get(
    String path, {
    Map<String, String>? queryParameters,
    Options? options,
  }) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> post(
    String path, {
    ApiFormData? formData,
    Map<String, String>? formObj,
    Map<String, String>? queryParameters,
    Options? options,
  }) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> put(
    String path, {
    ApiFormData? formData,
    Map<String, String>? formObj,
    Map<String, String>? queryParameters,
    Options? options,
  }) {
    // TODO: implement put
    throw UnimplementedError();
  }

  @override
  void setToken(String token) {
    // TODO: implement setToken
  }
}

class HttpApiFormData implements ApiFormData {
  @override
  void addField(String key, String value) {
    // TODO: implement addField
  }

  @override
  void addFile(String key, File file, {String? filename}) {
    // TODO: implement addFile
  }

  @override
  getBody() {
    // TODO: implement getBody
    throw UnimplementedError();
  }
}

class HttpApiResponse extends ApiResponse {
  @override
  // TODO: implement data
  get data => throw UnimplementedError();

  @override
  // TODO: implement headers
  get headers => throw UnimplementedError();

  @override
  // TODO: implement statusCode
  int? get statusCode => throw UnimplementedError();
}
