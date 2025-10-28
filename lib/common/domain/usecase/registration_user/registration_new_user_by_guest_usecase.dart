import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class RegistrationNewUserByGuest {
  final AuthRepository repository;

  RegistrationNewUserByGuest({required this.repository});

  Future<Either<AuthRepositoryErrors, bool>> call(
    RegistrationByGuestBody data,
  ) async {
    var result = await repository.registrationByGuest(data);
    return result;
  }
}
