// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:flinder/common/config/app_config.dart' as _i412;
import 'package:flinder/common/di/third_party_module.dart' as _i924;
import 'package:flinder/common/domain/app_config.dart' as _i255;
import 'package:flinder/common/router/observers/analytics_observer.dart'
    as _i789;
import 'package:flinder/common/service/analytics/analytics_service.dart'
    as _i922;
import 'package:flinder/common/service/app_state_service.dart' as _i708;
import 'package:flinder/common/service/crashlytics_service.dart' as _i626;
import 'package:flinder/common/service/language_service.dart' as _i806;
import 'package:flinder/common/source/network/http_client/http_client_module.dart'
    as _i31;
import 'package:flinder/common/source/network/interceptors/error_interceptor.dart'
    as _i759;
import 'package:flinder/common/source/network/interceptors/interceptors.dart'
    as _i447;
import 'package:flinder/common/source/network/interceptors/language_interceptor.dart'
    as _i658;
import 'package:flinder/common/source/network/interceptors/logger_interceptors.dart'
    as _i1055;
import 'package:flinder/common/source/network/interceptors/token_interceptor.dart'
    as _i27;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_remote_config/firebase_remote_config.dart' as _i627;
import 'package:get_it/get_it.dart' as _i174;
import 'package:go_router/go_router.dart' as _i583;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:logger/logger.dart' as _i974;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

const String _dev = 'dev';
const String _test = 'test';
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
    gh.factory<_i59.FirebaseAuth>(() => thirdPartyModule.auth);
    gh.singleton<_i974.Logger>(() => thirdPartyModule.logger);
    gh.singleton<_i974.FirebaseFirestore>(() => thirdPartyModule.firestore);
    gh.singleton<_i627.FirebaseRemoteConfig>(
      () => thirdPartyModule.remoteConfig,
    );
    gh.singleton<_i116.GoogleSignIn>(() => thirdPartyModule.googleSignIn);
    gh.singleton<_i708.AppStateService>(() => _i708.AppStateService());
    gh.singleton<_i626.CrashlyticsService>(() => _i626.CrashlyticsService());
    gh.singleton<_i255.AppConfig>(
      () => _i412.DevAppConfig(),
      registerFor: {_dev},
    );
    gh.singleton<_i255.AppConfig>(
      () => _i412.TestAppConfig(),
      registerFor: {_test},
    );
    gh.singleton<_i1055.LoggerInterceptor>(
      () => _i1055.LoggerInterceptor(logger: gh<_i974.Logger>()),
    );
    gh.singleton<_i759.ErrorInterceptor>(
      () => _i759.ErrorInterceptor(
        connectionChecker: gh<_i973.InternetConnectionChecker>(),
      ),
    );
    gh.singleton<_i255.AppConfig>(
      () => _i412.ProdAppConfig(),
      registerFor: {_prod},
    );
    gh.singleton<_i806.LanguageService>(
      () => _i806.LanguageService(
        gh<_i460.SharedPreferences>(),
        gh<_i255.AppConfig>(),
      ),
    );
    gh.singleton<_i27.TokenInterceptor>(
      () => _i27.TokenInterceptor(appStateService: gh<_i708.AppStateService>()),
    );
    gh.singleton<_i658.LanguageInterceptor>(
      () => _i658.LanguageInterceptor(
        appStateService: gh<_i708.AppStateService>(),
      ),
    );
    gh.factory<_i361.Dio>(
      () => httpClientModule.dioWithAuth(
        gh<_i255.AppConfig>(),
        gh<_i447.LoggerInterceptor>(),
        gh<_i447.ErrorInterceptor>(),
        gh<_i447.TokenInterceptor>(),
        gh<_i447.LanguageInterceptor>(),
      ),
      instanceName: 'dioWithAuth',
    );
    gh.singleton<_i922.AnalyticsService>(
      () => _i922.AnalyticsService(
        logger: gh<_i974.Logger>(),
        config: gh<_i255.AppConfig>(),
      ),
    );
    gh.factory<_i361.Dio>(
      () => httpClientModule.dioWithoutAuth(
        gh<_i255.AppConfig>(),
        gh<_i447.LoggerInterceptor>(),
        gh<_i447.ErrorInterceptor>(),
        gh<_i447.LanguageInterceptor>(),
      ),
      instanceName: 'dioWithNoAuth',
    );
    gh.factory<_i789.AnalyticsObserver>(
      () => _i789.AnalyticsObserver(
        analyticsService: gh<_i922.AnalyticsService>(),
        logger: gh<_i974.Logger>(),
      ),
    );
    gh.factory<_i583.GoRouter>(
      () => thirdPartyModule.router(gh<_i789.AnalyticsObserver>()),
    );
    return this;
  }
}

class _$ThirdPartyModule extends _i924.ThirdPartyModule {}

class _$HttpClientModule extends _i31.HttpClientModule {}
