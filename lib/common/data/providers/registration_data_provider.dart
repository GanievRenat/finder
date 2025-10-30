import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/app_config.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

abstract class RegistrationDataProvider {
  Future<Either<AuthRepositoryErrors, bool>> registrationByGuest(
    RegistrationByGuestBody body,
  );
}

//**
// Поставщик данных для регистрации пользователя
// */
@Singleton(as: RegistrationDataProvider)
class RegistrationDataProviderLocal extends RegistrationDataProvider {
  final SharedPreferences _sharedPreferences;
  final AppConfig _appConfig;

  RegistrationDataProviderLocal({
    required SharedPreferences sharedPreferences,
    required AppConfig appConfig,
  }) : _sharedPreferences = sharedPreferences,
       _appConfig = appConfig;

  @override
  Future<Either<AuthRepositoryErrors, bool>> registrationByGuest(
    RegistrationByGuestBody body,
  ) {
    try {
      var bodyStr = json.encode(body.toMap());
      _sharedPreferences.setString(
        _appConfig.localKeies[LocalKeies.localProfileKey]!,
        bodyStr,
      );
      return Future.value(Right(true));
    } catch (e) {
      return Future.value(Left(AuthRepositoryErrors.wrongRegistration));
    }
  }
}
