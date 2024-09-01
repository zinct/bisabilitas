///
/// api.dart
/// lib/core/api
///
/// Created by Indra Mahesa https://github.com/zinct
///

import 'dart:io';

import 'package:dio/dio.dart';

abstract class Api {
  late String baseUrl;
  late Map<String, String> headers;

  Future<ApiResponse> get(
    String path, {
    Map<String, String>? queryParameters,
    Options? options,
  });

  Future<ApiResponse> post(
    String path, {
    ApiFormData? formData,
    Map<String, String>? formObj,
    Map<String, String>? queryParameters,
    Options? options,
  });

  Future<ApiResponse> put(
    String path, {
    ApiFormData? formData,
    Map<String, String>? formObj,
    Map<String, String>? queryParameters,
    Options? options,
  });

  Future<ApiResponse> delete(
    String path, {
    ApiFormData? formData,
    Map<String, String>? formObj,
    Map<String, String>? queryParameters,
    Options? options,
  });

  void setToken(String token);
  void clearToken();
}

abstract class ApiResponse {
  int? get statusCode;
  dynamic get data;
  dynamic get headers;
}

abstract class ApiFormData {
  void addField(String key, String value);
  void addFile(String key, File file, {String? filename});
  dynamic getBody();
}
