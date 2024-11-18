import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../flavors/flavor_config.dart';
import 'api.dart';

class DioApi extends Api {
  late Dio dio;
  late CancelToken dioCancelToken;

  DioApi() {
    dio = Dio();

    // The following contains code for handling bad certificates.
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };

    // The following contains code for adding options to dio.
    dio.options.connectTimeout = const Duration(minutes: 6);
    dio.options.receiveTimeout = const Duration(minutes: 6);
    dio.options.headers['Language'] = "EN";
    dio.options.headers['Accept'] = "application/json";

    dioCancelToken = CancelToken();

    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestHeader: false,
        responseHeader: false,
        request: false,
        requestBody: true,
      ),
    );

    // The following contains code for adding baseURL to dio.
    if (FlavorConfig.instance != null) {
      baseUrl = FlavorConfig.instance!.flavorValues.baseURL;
    } else {
      throw Exception("Sometimes, an error occurs when trying to instantiate FlavorConfig.");
    }
  }

  @override
  void setToken(String token) {
    dio.options.headers['Authorization'] = "Bearer $token";
  }

  @override
  void clearToken() {
    dio.options.headers['Authorization'] = "";
  }

  @override
  Future<ApiResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final response = await dio.get(
      '$baseUrl/$path',
      queryParameters: queryParameters,
      options: options,
    );
    return DioApiResponse(response);
  }

  @override
  Future<ApiResponse> post(
    String path, {
    ApiFormData? formData,
    Map<String, dynamic>? formObj,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    print('$baseUrl/$path');
    final response = await dio.post(
      '$baseUrl/$path',
      data: formData != null ? formData.getBody() : formObj,
      queryParameters: queryParameters,
      options: options,
    );
    return DioApiResponse(response);
  }

  @override
  Future<ApiResponse> put(
    String path, {
    ApiFormData? formData,
    Map<String, String>? formObj,
    Map<String, String>? queryParameters,
    Options? options,
  }) async {
    final response = await dio.put(
      '$baseUrl/$path',
      data: formData != null ? formData.getBody() : formObj,
      queryParameters: queryParameters,
      options: options,
    );
    return DioApiResponse(response);
  }

  @override
  Future<ApiResponse> delete(
    String path, {
    ApiFormData? formData,
    Map<String, String>? formObj,
    Map<String, String>? queryParameters,
    Options? options,
  }) async {
    final response = await dio.delete(
      '$baseUrl/$path',
      data: formData != null ? formData.getBody() : formObj,
      queryParameters: queryParameters,
      options: options,
    );

    return DioApiResponse(response);
  }
}

class DioApiFormData implements ApiFormData {
  late FormData formData;

  DioApiFormData() {
    formData = FormData();
  }

  @override
  void addField(String key, String value) {
    formData.fields.add(MapEntry(key, value));
  }

  @override
  void addFile(String key, File file, {String? filename}) {
    formData.files.add(MapEntry(
      key,
      MultipartFile.fromFileSync(file.path, filename: filename),
    ));
  }

  @override
  dynamic getBody() {
    return formData;
  }
}

class DioApiResponse extends ApiResponse {
  final Response response;

  DioApiResponse(this.response);

  @override
  int? get statusCode => response.statusCode;

  @override
  dynamic get data => response.data;

  @override
  get headers => response.headers;
}
