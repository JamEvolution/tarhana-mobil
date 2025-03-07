import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tarhana_app/core/constants/api_constants.dart';
import 'package:tarhana_app/core/logger/app_logger.dart';

final dioClientProvider = Provider<Dio>((ref) {
  return createDioClient();
});

Dio createDioClient() {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Özel logger interceptor
  dio.interceptors.add(_createLogInterceptor());
  
  // Pretty Dio Logger
  if (kDebugMode) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: false,
        maxWidth: 120,
      ),
    );
  }

  return dio;
}

/// API isteklerini loglamak için interceptor oluşturur
Interceptor _createLogInterceptor() {
  return InterceptorsWrapper(
    onRequest: (options, handler) {
      appLogger.i('🌐 REQUEST[${options.method}] => PATH: ${options.path}');
      appLogger.d('Headers: ${options.headers}');
      appLogger.d('Data: ${options.data}');
      return handler.next(options);
    },
    onResponse: (response, handler) {
      appLogger.i('✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
      appLogger.d('Data: ${response.data}');
      return handler.next(response);
    },
    onError: (DioException e, handler) {
      appLogger.e(
        '❌ ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}',
        e,
        e.stackTrace,
      );
      return handler.next(e);
    },
  );
} 