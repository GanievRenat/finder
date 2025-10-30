import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';

abstract class RegistrationRepository {
  Future<Either<AuthRepositoryErrors, bool>> registrationByGuest(
    RegistrationByGuestBody body,
  );
}

enum AuthRepositoryErrors { wrongRegistration }
