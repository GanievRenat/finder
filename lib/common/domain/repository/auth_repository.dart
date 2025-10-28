import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';

abstract class AuthRepository {
  Future<Either<AuthRepositoryErrors, bool>> registrationByGuest(
    RegistrationByGuestBody body,
  );
  bool isAuth();
}

enum AuthRepositoryErrors { wrongRegistration }
