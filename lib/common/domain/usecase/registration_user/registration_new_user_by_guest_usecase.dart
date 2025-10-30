import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class RegistrationNewUserByGuest {
  final RegistrationRepository _registrationRepository;

  RegistrationNewUserByGuest({
    required RegistrationRepository registrationRepository,
  }) : _registrationRepository = registrationRepository;

  Future<Either<AuthRepositoryErrors, bool>> call(
    RegistrationByGuestBody data,
  ) async {
    var result = await _registrationRepository.registrationByGuest(data);
    return result;
  }
}
