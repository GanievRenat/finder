// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:deepseek_client/common/config/app_config.dart' as _i453;
import 'package:deepseek_client/common/data/api/chat_completions/chat_completions_api.dart'
    as _i302;
import 'package:deepseek_client/common/data/repository/message_repository.dart'
    as _i616;
import 'package:deepseek_client/common/data/source/network/interceptors/error_interceptor.dart'
    as _i835;
import 'package:deepseek_client/common/data/source/network/interceptors/logger_interceptors.dart'
    as _i720;
import 'package:deepseek_client/common/data/source/network/interceptors/token_interceptor.dart'
    as _i687;
import 'package:deepseek_client/common/di/api_module.dart' as _i260;
import 'package:deepseek_client/common/domain/app_config.dart' as _i488;
import 'package:deepseek_client/common/domain/repository/message_repository.dart'
    as _i410;
import 'package:deepseek_client/common/domain/usecases/send_message_usecase.dart'
    as _i219;
import 'package:deepseek_client/common/services/app_state_service.dart'
    as _i497;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:logger/logger.dart' as _i974;

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
    gh.singleton<_i497.DeepSeekStateService>(
      () => _i497.DeepSeekStateService(),
    );
    gh.singleton<_i687.TokenInterceptor>(
      () => _i687.TokenInterceptor(
        appStateService: gh<_i497.DeepSeekStateService>(),
      ),
    );
    gh.singleton<_i488.AppConfig>(
      () => _i453.TestAppConfig(),
      registerFor: {_test},
    );
    gh.singleton<_i488.AppConfig>(
      () => _i453.DevAppConfig(),
      registerFor: {_dev},
    );
    gh.singleton<_i720.LoggerInterceptor>(
      () => _i720.LoggerInterceptor(logger: gh<_i974.Logger>()),
    );
    gh.singleton<_i835.ErrorInterceptor>(
      () => _i835.ErrorInterceptor(
        connectionChecker: gh<_i973.InternetConnectionChecker>(),
      ),
    );
    gh.singleton<_i488.AppConfig>(
      () => _i453.ProdAppConfig(),
      registerFor: {_prod},
    );
    gh.factory<_i361.Dio>(
      () => apiModule.dioWithKey(
        gh<_i488.AppConfig>(),
        gh<_i687.TokenInterceptor>(),
        gh<_i720.LoggerInterceptor>(),
        gh<_i835.ErrorInterceptor>(),
      ),
      instanceName: 'dioWithKey',
    );
    gh.singleton<_i302.ChatCompletionsApi>(
      () => _i302.ChatCompletionsApi(gh<_i361.Dio>(instanceName: 'dioWithKey')),
    );
    gh.singleton<_i410.MessageRepository>(
      () => _i616.MessageRepositoryImpl(
        chatCompletionsApi: gh<_i302.ChatCompletionsApi>(),
      ),
    );
    gh.singleton<_i219.SendMessage>(
      () => _i219.SendMessage(messageRepository: gh<_i410.MessageRepository>()),
    );
    return this;
  }
}

class _$ApiModule extends _i260.ApiModule {}
