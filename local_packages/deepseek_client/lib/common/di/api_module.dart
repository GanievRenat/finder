import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../data/source/network/interceptors/error_interceptor.dart';
import '../data/source/network/interceptors/logger_interceptors.dart';
import '../data/source/network/interceptors/token_interceptor.dart';
import '../data/source/network/network_manager.dart';
import '../domain/app_config.dart';

class DependencyDioName {
  static const dioWithKeyDeepSeek = 'dioWithKeyDeepSeek';
}

@module
abstract class ApiModule {
  @Named(DependencyDioName.dioWithKeyDeepSeek)
  Dio dioWithKeyDeepSeek(
    AppConfig config,
    TokenInterceptor tokenInterceptor,
    LoggerInterceptor loggerInterceptor,
    ErrorInterceptor errorInterceptor,
  ) => NetworkManager.getApiDioClient(
    config: config,
    loggerInterceptor: loggerInterceptor,
    errorInterceptor: errorInterceptor,
    tokenInterceptor: tokenInterceptor,
  );
}
