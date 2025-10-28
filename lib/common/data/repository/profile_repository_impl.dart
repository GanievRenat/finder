import 'package:flirta/common/data/models/models.dart';
import 'package:flirta/common/data/providers/data_providers.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:injectable/injectable.dart';
import 'package:either_dart/either.dart';

@Singleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final AppStateService appStateService;
  final AuthDataProvider dataProvider;

  ProfileRepositoryImpl({
    required this.appStateService,
    required this.dataProvider,
  });

  @override
  Future<Either<ProfileRepositoryError, User>> getProfile() async {
    var result = await dataProvider.getCurrentUser();
    if (result.isRight) {
      var user = result.right.toEntites();
      appStateService.currentUser = user;
      return Future.value(Right(user));
    } else {
      return Future.value(Left(result.left));
    }
  }

  @override
  Future<Either<ProfileRepositoryError, bool>> update(User user) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<Either<ProfileRepositoryError, bool>> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> init() async {
    await getProfile();
  }
}
