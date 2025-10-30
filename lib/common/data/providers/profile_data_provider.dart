import 'package:either_dart/either.dart';
import 'package:flirta/common/data/models/models.dart';
import 'package:flirta/common/domain/app_config.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

abstract class ProfileDataProvider {
  bool isAuth();
  Future<Either<ProfileRepositoryError, UserModel>> getCurrentUser();
  Future<Either<ProfileRepositoryError, bool>> deleteCurrentUser();
  Future<Either<ProfileRepositoryError, bool>> updateCurrentUser(
    UpdateUserBody body,
  );
}

//**
// Поставщик данных для работы с зарегистрированным пользователем
// */
@Singleton(as: ProfileDataProvider)
class ProfileDataProviderLocal extends ProfileDataProvider {
  final SharedPreferences _sharedPreferences;
  final AppConfig _appConfig;

  ProfileDataProviderLocal({
    required SharedPreferences sharedPreferences,
    required AppConfig appConfig,
  }) : _sharedPreferences = sharedPreferences,
       _appConfig = appConfig;

  @override
  bool isAuth() {
    var profileData =
        _sharedPreferences.getString(
          _appConfig.localKeies[LocalKeies.localProfileKey]!,
        ) ??
        '';
    if (profileData.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Future<Either<ProfileRepositoryError, UserModel>> getCurrentUser() {
    var profileData =
        _sharedPreferences.getString(
          _appConfig.localKeies[LocalKeies.localProfileKey]!,
        ) ??
        '';
    if (profileData.isNotEmpty) {
      Map<String, dynamic> decoded = json.decode(profileData);
      return Future.value(Right(UserModel.fromJson(decoded)));
    } else {
      return Future.value(Left(WrongGetProfileError()));
    }
  }

  @override
  Future<Either<ProfileRepositoryError, bool>> updateCurrentUser(
    UpdateUserBody body,
  ) async {
    var profileData =
        _sharedPreferences.getString(
          _appConfig.localKeies[LocalKeies.localProfileKey]!,
        ) ??
        '';
    if (profileData.isNotEmpty) {
      try {
        var bodyStr = json.encode(body.toMap());
        await _sharedPreferences.setString(
          _appConfig.localKeies[LocalKeies.localProfileKey]!,
          bodyStr,
        );
        return Right(true);
      } catch (e) {
        return Future.value(Left(WrongUpdateProfileError()));
      }
    } else {
      return Future.value(Left(ThereIsntProfileError()));
    }
  }

  @override
  Future<Either<ProfileRepositoryError, bool>> deleteCurrentUser() async {
    var profileData = _sharedPreferences.getString(
      _appConfig.localKeies[LocalKeies.localProfileKey]!,
    );
    if (profileData != null) {
      var result = await _sharedPreferences.remove(
        _appConfig.localKeies[LocalKeies.localProfileKey]!,
      );
      if (result) {
        return Future.value(Right(true));
      } else {
        return Future.value(Left(WrongDeleteProfileError()));
      }
    }
    return Future.value(Right(true));
  }
}
