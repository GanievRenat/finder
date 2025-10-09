import 'package:flinder/common/service/app_state_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class LanguageInterceptor extends Interceptor {
  LanguageInterceptor({required AppStateService appStateService})
    : _appState = appStateService;

  final AppStateService _appState;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final languageCode = _appState.currentLocale.languageCode;
    options.headers['Language'] = languageCode;
    handler.next(options);
  }
}
