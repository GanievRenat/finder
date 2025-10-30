import 'package:flirta/common/data/models/models.dart';
import 'package:flirta/common/data/providers/data_providers.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';
import 'package:either_dart/either.dart';

@Singleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataProvider _dataProvider;

  ProfileRepositoryImpl({required ProfileDataProvider dataProvider})
    : _dataProvider = dataProvider;

  @override
  Future<void> init() async {}

  @override
  Future<Either<ProfileRepositoryError, User>> getProfile() async {
    var result = await _dataProvider.getCurrentUser();
    if (result.isRight) {
      var user = result.right.toEntites();
      return Future.value(Right(user));
    } else {
      return Future.value(Left(result.left));
    }
  }

  @override
  Future<Either<ProfileRepositoryError, bool>> update(User user) async {
    var result = await _dataProvider.updateCurrentUser(
      UpdateUserBody(
        name: user.name,
        age: user.age,
        gender: user.gender,
        photo: user.photo,
      ),
    );
    return result;
  }

  @override
  Future<Either<ProfileRepositoryError, bool>> delete() async {
    var result = await _dataProvider.deleteCurrentUser();
    return result;
  }
}
