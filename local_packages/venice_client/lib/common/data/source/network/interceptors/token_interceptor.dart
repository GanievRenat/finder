//import 'dart:developer';

import 'package:venice_client/common/services/app_state_service.dart';
import 'package:dio/dio.dart';

import 'package:injectable/injectable.dart';

@singleton
class TokenInterceptor extends Interceptor {
  TokenInterceptor({required this.appStateService});

  final VeniceStateService appStateService;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final key = appStateService.key;
    if (key.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $key';
    }
    handler.next(options);
  }
}
