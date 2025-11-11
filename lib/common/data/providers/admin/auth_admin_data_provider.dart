import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flirta/common/domain/app_config.dart';
import 'package:flirta/common/domain/repository/admin/bodies/auth_by_admin_body.dart';
import 'package:flirta/common/domain/repository/admin/bodies/forgot_password_body.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

abstract class AuthAdminDataProvider {
  FutureOr<User?> init();
  Future<Either<AuthAdminRepositoryErrors, User>> authByAdmin(
    AuthByAdminBody body,
  );
  Future<Either<AuthAdminRepositoryErrors, bool>> forgotPassword(
    ForgotPasswordBody body,
  );
  Future<Either<AuthAdminRepositoryErrors, bool>> logout();
}

//**
// Поставщик данных для регистрации пользователя
// */
@Singleton(as: AuthAdminDataProvider)
class AuthAdminDataProviderLocal extends AuthAdminDataProvider {
  final FirebaseAuth _auth;

  AuthAdminDataProviderLocal({
    required FirebaseAuth auth,
    required AppConfig appConfig,
  }) : _auth = auth;

  @override
  Future<Either<AuthAdminRepositoryErrors, User>> authByAdmin(
    AuthByAdminBody body,
  ) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: body.email,
        password: body.password,
      );

      final user = credential.user;
      if (user == null) throw Exception('Sign-in failed');

      return Right(user);
    } catch (e) {
      return Future.value(Left(AuthAdminRepositoryErrors.wrongAuth));
    }
  }

  @override
  Future<Either<AuthAdminRepositoryErrors, bool>> forgotPassword(
    ForgotPasswordBody body,
  ) async {
    try {
      await _auth.sendPasswordResetEmail(email: body.email);
      return Future.value(Right(true));
    } catch (e) {
      return Future.value(Left(AuthAdminRepositoryErrors.wrongAuth));
    }
  }

  @override
  Future<Either<AuthAdminRepositoryErrors, bool>> logout() async {
    try {
      await _auth.signOut();
      return Future.value(Right(true));
    } catch (e) {
      return Future.value(Left(AuthAdminRepositoryErrors.wrongAuth));
    }
  }

  @override
  User? init() {
    return _auth.currentUser;
  }
}
