import 'package:flirta/common/data/models/models.dart';
import 'package:flirta/common/domain/app_config.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

abstract class RegistrationFormDataProvider {
  Future<bool> saveRegistrationData(RegistrationDataBody body);
  Future<RegistrationDataModel?> getRegistrationData();
  Future<bool> clearData();
}

//**
// Поставщик локальных данных для анкеты пользователя во время регистрации
// */
@Singleton(as: RegistrationFormDataProvider)
class RegistrationFormDataProviderLocal extends RegistrationFormDataProvider {
  final SharedPreferences _sharedPreferences;
  final AppConfig _appConfig;

  RegistrationFormDataProviderLocal({
    required SharedPreferences sharedPreferences,
    required AppConfig appConfig,
  }) : _sharedPreferences = sharedPreferences,
       _appConfig = appConfig;

  @override
  Future<bool> saveRegistrationData(RegistrationDataBody body) {
    var bodyStr = json.encode(body.toMap());
    _sharedPreferences.setString(
      _appConfig.localKeies[LocalKeies.localRegistrationFormKey]!,
      bodyStr,
    );
    return Future.value(true);
  }

  @override
  Future<RegistrationDataModel?> getRegistrationData() {
    var profileData =
        _sharedPreferences.getString(
          _appConfig.localKeies[LocalKeies.localRegistrationFormKey]!,
        ) ??
        '';
    if (profileData.isNotEmpty) {
      Map<String, dynamic> decoded = json.decode(profileData);
      return Future.value(RegistrationDataModel.fromJson(decoded));
    }

    return Future.value(null);
  }

  @override
  Future<bool> clearData() async {
    await _sharedPreferences.remove(
      _appConfig.localKeies[LocalKeies.localRegistrationFormKey]!,
    );
    return true;
  }
}
