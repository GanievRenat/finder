// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flirta/common/config/app_config.dart' as _i67;
import 'package:flirta/common/di/third_party_module.dart' as _i362;
import 'package:flirta/common/domain/app_config.dart' as _i1048;
import 'package:flirta/common/router/observers/analytics_observer.dart' as _i36;
import 'package:flirta/common/service/analytics/analytics_service.dart'
    as _i957;
import 'package:flirta/common/service/app_state_service.dart' as _i523;
import 'package:flirta/common/service/crashlytics_service.dart' as _i551;
import 'package:flirta/common/service/language_service.dart' as _i39;
import 'package:flirta/common/source/network/http_client/http_client_module.dart'
    as _i1066;
import 'package:flirta/common/source/network/interceptors/error_interceptor.dart'
    as _i534;
import 'package:flirta/common/source/network/interceptors/interceptors.dart'
    as _i97;
import 'package:flirta/common/source/network/interceptors/language_interceptor.dart'
    as _i864;
import 'package:flirta/common/source/network/interceptors/logger_interceptors.dart'
    as _i1072;
import 'package:flirta/common/source/network/interceptors/token_interceptor.dart'
    as _i970;
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
    gh.singleton<_i523.AppStateService>(() => _i523.AppStateService());
    gh.singleton<_i551.CrashlyticsService>(() => _i551.CrashlyticsService());
    gh.singleton<_i1048.AppConfig>(
      () => _i67.TestAppConfig(),
      registerFor: {_test},
    );
    gh.singleton<_i1048.AppConfig>(
      () => _i67.DevAppConfig(),
      registerFor: {_dev},
    );
    gh.singleton<_i1072.LoggerInterceptor>(
      () => _i1072.LoggerInterceptor(logger: gh<_i974.Logger>()),
    );
    gh.singleton<_i534.ErrorInterceptor>(
      () => _i534.ErrorInterceptor(
        connectionChecker: gh<_i973.InternetConnectionChecker>(),
      ),
    );
    gh.singleton<_i970.TokenInterceptor>(
      () =>
          _i970.TokenInterceptor(appStateService: gh<_i523.AppStateService>()),
    );
    gh.singleton<_i864.LanguageInterceptor>(
      () => _i864.LanguageInterceptor(
        appStateService: gh<_i523.AppStateService>(),
      ),
    );
    gh.singleton<_i1048.AppConfig>(
      () => _i67.ProdAppConfig(),
      registerFor: {_prod},
    );
    gh.factory<_i361.Dio>(
      () => httpClientModule.dioWithoutAuth(
        gh<_i1048.AppConfig>(),
        gh<_i97.LoggerInterceptor>(),
        gh<_i97.ErrorInterceptor>(),
        gh<_i97.LanguageInterceptor>(),
      ),
      instanceName: 'dioWithNoAuth',
    );
    gh.factory<_i361.Dio>(
      () => httpClientModule.dioWithAuth(
        gh<_i1048.AppConfig>(),
        gh<_i97.LoggerInterceptor>(),
        gh<_i97.ErrorInterceptor>(),
        gh<_i97.TokenInterceptor>(),
        gh<_i97.LanguageInterceptor>(),
      ),
      instanceName: 'dioWithAuth',
    );
    gh.singleton<_i957.AnalyticsService>(
      () => _i957.AnalyticsService(
        logger: gh<_i974.Logger>(),
        config: gh<_i1048.AppConfig>(),
      ),
    );
    gh.factory<_i36.AnalyticsObserver>(
      () => _i36.AnalyticsObserver(
        analyticsService: gh<_i957.AnalyticsService>(),
        logger: gh<_i974.Logger>(),
      ),
    );
    gh.singleton<_i39.LanguageService>(
      () => _i39.LanguageService(
        gh<_i460.SharedPreferences>(),
        gh<_i1048.AppConfig>(),
      ),
    );
    gh.factory<_i583.GoRouter>(
      () => thirdPartyModule.router(gh<_i36.AnalyticsObserver>()),
    );
    return this;
  }
}

class _$ThirdPartyModule extends _i362.ThirdPartyModule {}

class _$HttpClientModule extends _i1066.HttpClientModule {}
