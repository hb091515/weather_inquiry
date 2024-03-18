import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HttpHandler {
  static final HttpHandler _instance = HttpHandler._internal();
  factory HttpHandler() => _instance;

  late Dio dio;

  HttpHandler._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: "https://opendata.cwa.gov.tw/api",
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );

    dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options); //continue
      },
      onResponse: (response, handler) {
        return handler.next(response); // continue
      },
      onError: (error, handler) {
        return handler.next(error); //continue
      },
    ));
  }
  Future<Map<String, dynamic>> getRequest(String path, Map<String, dynamic>? parameters) async {
    try {
      final response = await dio.get(path,
          options: Options(headers: {
            "Authorization": "CWA-1539EAF7-6F81-4742-90F3-3F0EAE6B070F",
          }),
          queryParameters: parameters);
      return response.data;
    } catch (e) {
      debugPrint("Error occurred: $e");
      return {};
    }
  }
}
