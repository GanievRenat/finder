//import 'dart:io';
import 'package:venice_client/common/domain/app_config.dart';
import 'package:dio/dio.dart';
import 'interceptors/interceptors.dart';

class NetworkManager {
  NetworkManager._();

  static Dio getApiDioClient({
    required AppConfig config,
    TokenInterceptor? tokenInterceptor,
    LoggerInterceptor? loggerInterceptor,
    ErrorInterceptor? errorInterceptor,
  }) => _getDioClient(
    baseUrl: Uri.parse(config.baseUrl),
    interceptors: [
      if (tokenInterceptor != null) tokenInterceptor,
      if (loggerInterceptor != null) loggerInterceptor,
      if (errorInterceptor != null) errorInterceptor,
    ],
  );

  static Dio _getDioClient({
    required Uri baseUrl,
    Duration connectTimeout = const Duration(seconds: 25),
    Duration receiveTimeout = const Duration(seconds: 25),
    Duration sendTimeout = const Duration(seconds: 25),
    List<Interceptor> interceptors = const [],
    String? contentType,
  }) {
    final options = BaseOptions(
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      contentType: contentType,
      headers: {'Content-Type': 'application/json'},
    )..baseUrl = baseUrl.toString();

    final dio = Dio(options);

    dio.interceptors.addAll(interceptors);

    return dio;
  }
}
