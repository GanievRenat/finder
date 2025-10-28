import 'package:flirta/common/data/providers/data_providers.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';
import 'package:either_dart/either.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDataProvider dataProvider;

  AuthRepositoryImpl({required this.dataProvider});

  @override
  bool isAuth() {
    var result = dataProvider.isAuth();
    return result;
  }

  @override
  Future<Either<AuthRepositoryErrors, bool>> registrationByGuest(
    RegistrationByGuestBody body,
  ) async {
    var result = await dataProvider.registrationByGuest(body);

    if (result.isRight) {
      return Future.value(Right(true));
    } else {
      return Left(AuthRepositoryErrors.wrongRegistration);
    }
  }
}
