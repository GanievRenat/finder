import 'package:flirta/common/data/models/models.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

abstract class RegistrationDataProvider {
  Future<bool> saveRegistrationData(RegistrationDataBody body);
  Future<RegistrationDataModel?> getRegistrationData();
}

//**
// Реализация локального хранилища для анкеты во время регистрации
// */
@Singleton(as: RegistrationDataProvider)
class RegistrationDataProviderLocal extends RegistrationDataProvider {
  final SharedPreferences sharedPreferences;

  final String registrationDataKey = 'registration_data';

  RegistrationDataProviderLocal({required this.sharedPreferences});

  @override
  Future<bool> saveRegistrationData(RegistrationDataBody body) {
    var bodyStr = json.encode(body.toMap());
    sharedPreferences.setString(registrationDataKey, bodyStr);
    return Future.value(true);
  }

  @override
  Future<RegistrationDataModel?> getRegistrationData() {
    var profileData = sharedPreferences.getString(registrationDataKey) ?? '';
    if (profileData.isNotEmpty) {
      Map<String, dynamic> decoded = json.decode(profileData);
      return Future.value(RegistrationDataModel.fromJson(decoded));
    }

    return Future.value(null);
  }
}
