// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flinder/common/config/app_config.dart' as _i56;
import 'package:flinder/common/di/third_party_module.dart' as _i107;
import 'package:flinder/common/domain/app_config.dart' as _i51;
import 'package:flinder/common/router/observers/analytics_observer.dart'
    as _i475;
import 'package:flinder/common/service/analytics/analytics_service.dart'
    as _i149;
import 'package:flinder/common/service/app_state_service.dart' as _i708;
import 'package:flinder/common/service/crashlytics_service.dart' as _i169;
import 'package:flinder/common/service/language_service.dart' as _i788;
import 'package:flinder/common/source/network/http_client/http_client_module.dart'
    as _i272;
import 'package:flinder/common/source/network/interceptors/error_interceptor.dart'
    as _i645;
import 'package:flinder/common/source/network/interceptors/interceptors.dart'
    as _i940;
import 'package:flinder/common/source/network/interceptors/language_interceptor.dart'
    as _i746;
import 'package:flinder/common/source/network/interceptors/logger_interceptors.dart'
    as _i334;
import 'package:flinder/common/source/network/interceptors/token_interceptor.dart'
    as _i242;
import 'package:get_it/get_it.dart' as _i174;
import 'package:go_router/go_router.dart' as _i583;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:logger/logger.dart' as _i974;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

const String _test = 'test';
const String _dev = 'dev';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final thirdPartyModule = _$ThirdPartyModule();
    final httpClientModule = _$HttpClientModule();
    gh.factory<_i973.InternetConnectionChecker>(
      () => thirdPartyModule.connectionChecker,
    );
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => thirdPartyModule.storage,
      preResolve: true,
    );
    gh.singleton<_i974.Logger>(() => thirdPartyModule.logger);
    gh.singleton<_i708.AppStateService>(() => _i708.AppStateService());
    gh.singleton<_i169.CrashlyticsService>(() => _i169.CrashlyticsService());
    gh.singleton<_i242.TokenInterceptor>(
      () =>
          _i242.TokenInterceptor(appStateService: gh<_i708.AppStateService>()),
    );
    gh.singleton<_i746.LanguageInterceptor>(
      () => _i746.LanguageInterceptor(
        appStateService: gh<_i708.AppStateService>(),
      ),
    );
    gh.singleton<_i334.LoggerInterceptor>(
      () => _i334.LoggerInterceptor(logger: gh<_i974.Logger>()),
    );
    gh.singleton<_i51.AppConfig>(
      () => _i56.TestAppConfig(),
      registerFor: {_test},
    );
    gh.singleton<_i51.AppConfig>(
      () => _i56.DevAppConfig(),
      registerFor: {_dev},
    );
    gh.singleton<_i645.ErrorInterceptor>(
      () => _i645.ErrorInterceptor(
        connectionChecker: gh<_i973.InternetConnectionChecker>(),
      ),
    );
    gh.singleton<_i51.AppConfig>(
      () => _i56.ProdAppConfig(),
      registerFor: {_prod},
    );
    gh.factory<_i361.Dio>(
      () => httpClientModule.dioWithAuth(
        gh<_i51.AppConfig>(),
        gh<_i940.LoggerInterceptor>(),
        gh<_i940.ErrorInterceptor>(),
        gh<_i940.TokenInterceptor>(),
        gh<_i940.LanguageInterceptor>(),
      ),
      instanceName: 'dioWithAuth',
    );
    gh.singleton<_i788.LanguageService>(
      () => _i788.LanguageService(
        gh<_i460.SharedPreferences>(),
        gh<_i51.AppConfig>(),
      ),
    );
    gh.singleton<_i149.AnalyticsService>(
      () => _i149.AnalyticsService(
        logger: gh<_i974.Logger>(),
        config: gh<_i51.AppConfig>(),
      ),
    );
    gh.factory<_i475.AnalyticsObserver>(
      () => _i475.AnalyticsObserver(
        analyticsService: gh<_i149.AnalyticsService>(),
        logger: gh<_i974.Logger>(),
      ),
    );
    gh.factory<_i361.Dio>(
      () => httpClientModule.dioWithoutAuth(
        gh<_i51.AppConfig>(),
        gh<_i940.LoggerInterceptor>(),
        gh<_i940.ErrorInterceptor>(),
        gh<_i940.LanguageInterceptor>(),
      ),
      instanceName: 'dioWithNoAuth',
    );
    gh.factory<_i583.GoRouter>(
      () => thirdPartyModule.router(gh<_i475.AnalyticsObserver>()),
    );
    return this;
  }
}

class _$ThirdPartyModule extends _i107.ThirdPartyModule {}

class _$HttpClientModule extends _i272.HttpClientModule {}
