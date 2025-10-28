import 'package:either_dart/either.dart';
import 'package:flirta/common/data/models/models.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

abstract class AuthDataProvider {
  Future<Either<AuthRepositoryErrors, bool>> registrationByGuest(
    RegistrationByGuestBody body,
  );

  bool isAuth();

  Future<Either<ProfileRepositoryError, UserModel>> getCurrentUser();
}

//**
// Реализация локального хранилища для пользователя
// */
@Singleton(as: AuthDataProvider)
class AuthDataProviderLocal extends AuthDataProvider {
  final SharedPreferences sharedPreferences;

  final String profileKey = 'profile';

  AuthDataProviderLocal({required this.sharedPreferences});

  @override
  bool isAuth() {
    var profileData = sharedPreferences.getString(profileKey) ?? '';
    if (profileData.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Future<Either<AuthRepositoryErrors, bool>> registrationByGuest(
    RegistrationByGuestBody body,
  ) {
    try {
      var bodyStr = json.encode(body.toMap());
      sharedPreferences.setString(profileKey, bodyStr);
      return Future.value(Right(true));
    } catch (e) {
      return Future.value(Left(AuthRepositoryErrors.wrongRegistration));
    }
  }

  @override
  Future<Either<ProfileRepositoryError, UserModel>> getCurrentUser() {
    var profileData = sharedPreferences.getString(profileKey) ?? '';
    if (profileData.isNotEmpty) {
      Map<String, dynamic> decoded = json.decode(profileData);
      return Future.value(Right(UserModel.fromJson(decoded)));
    } else {
      return Future.value(Left(ProfileRepositoryError.wrongGetProfile));
    }
  }
}
