import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../exceptions/base_api_exceptions.dart';

class ErrorInterceptor extends Interceptor {
  ErrorInterceptor({required InternetConnectionChecker connectionChecker})
    : _connectionChecker = connectionChecker;

  final InternetConnectionChecker _connectionChecker;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final apiException = await BaseApiException.parse(
      err,
      checkHasConnection: () => _connectionChecker.hasConnection,
    );
    super.onError(apiException, handler);
  }
}
