import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'bodies/auth_by_admin_body.dart';
import 'bodies/forgot_password_body.dart';

abstract class AuthAdminRepository {
  Future<User?> init();
  Future<Either<AuthAdminRepositoryErrors, User>> authByAdmin(
    AuthByAdminBody body,
  );
  Future<Either<AuthAdminRepositoryErrors, bool>> forgotPassword(
    ForgotPasswordBody body,
  );
  Future<Either<AuthAdminRepositoryErrors, bool>> logout();
}

enum AuthAdminRepositoryErrors { wrongAuth }
