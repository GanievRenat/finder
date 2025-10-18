import 'package:flirta/common/source/network/exceptions/base_api_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@singleton
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
