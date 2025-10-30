import 'package:flirta/common/data/providers/data_providers.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';
import 'package:either_dart/either.dart';

@Singleton(as: RegistrationRepository)
class RegistrationRepositoryImpl implements RegistrationRepository {
  final RegistrationDataProvider _dataProvider;

  RegistrationRepositoryImpl({required RegistrationDataProvider dataProvider})
    : _dataProvider = dataProvider;

  @override
  Future<Either<AuthRepositoryErrors, bool>> registrationByGuest(
    RegistrationByGuestBody body,
  ) async {
    var result = await _dataProvider.registrationByGuest(body);

    if (result.isRight) {
      return Future.value(Right(true));
    } else {
      return Left(AuthRepositoryErrors.wrongRegistration);
    }
  }
}
