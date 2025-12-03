// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:logger/logger.dart' as _i974;
import 'package:venice_client/common/config/app_config.dart' as _i456;
import 'package:venice_client/common/data/api/chat_completions/chat_completions_api.dart'
    as _i656;
import 'package:venice_client/common/data/repository/message_repository.dart'
    as _i802;
import 'package:venice_client/common/data/source/network/interceptors/error_interceptor.dart'
    as _i1072;
import 'package:venice_client/common/data/source/network/interceptors/logger_interceptors.dart'
    as _i37;
import 'package:venice_client/common/data/source/network/interceptors/token_interceptor.dart'
    as _i606;
import 'package:venice_client/common/di/api_module.dart' as _i949;
import 'package:venice_client/common/domain/app_config.dart' as _i258;
import 'package:venice_client/common/domain/repository/message_repository.dart'
    as _i660;
import 'package:venice_client/common/domain/usecases/send_message_usecase.dart'
    as _i1068;
import 'package:venice_client/common/services/app_state_service.dart' as _i709;

const String _test = 'test';
const String _dev = 'dev';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final apiModule = _$ApiModule();
    gh.singleton<_i709.VeniceStateService>(() => _i709.VeniceStateService());
    gh.singleton<_i258.AppConfig>(
      () => _i456.TestAppConfig(),
      registerFor: {_test},
    );
    gh.singleton<_i606.TokenInterceptor>(
      () => _i606.TokenInterceptor(
        appStateService: gh<_i709.VeniceStateService>(),
      ),
    );
    gh.singleton<_i37.LoggerInterceptor>(
      () => _i37.LoggerInterceptor(logger: gh<_i974.Logger>()),
    );
    gh.singleton<_i258.AppConfig>(
      () => _i456.DevAppConfig(),
      registerFor: {_dev},
    );
    gh.singleton<_i1072.ErrorInterceptor>(
      () => _i1072.ErrorInterceptor(
        connectionChecker: gh<_i973.InternetConnectionChecker>(),
      ),
    );
    gh.singleton<_i258.AppConfig>(
      () => _i456.ProdAppConfig(),
      registerFor: {_prod},
    );
    gh.factory<_i361.Dio>(
      () => apiModule.dioWithKey(
        gh<_i258.AppConfig>(),
        gh<_i606.TokenInterceptor>(),
        gh<_i37.LoggerInterceptor>(),
        gh<_i1072.ErrorInterceptor>(),
      ),
      instanceName: 'dioWithKey',
    );
    gh.singleton<_i656.ChatCompletionsApi>(
      () => _i656.ChatCompletionsApi(gh<_i361.Dio>(instanceName: 'dioWithKey')),
    );
    gh.singleton<_i660.MessageRepository>(
      () => _i802.MessageRepositoryImpl(
        chatCompletionsApi: gh<_i656.ChatCompletionsApi>(),
      ),
    );
    gh.singleton<_i1068.SendMessage>(
      () =>
          _i1068.SendMessage(messageRepository: gh<_i660.MessageRepository>()),
    );
    return this;
  }
}

class _$ApiModule extends _i949.ApiModule {}
