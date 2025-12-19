//import 'dart:developer';
import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  TokenInterceptor({required this.key});

  final String key;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (key.isNotEmpty) {
      options.headers['x-goog-api-key'] = key;
    }
    handler.next(options);
  }
}
