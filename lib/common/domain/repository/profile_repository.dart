import 'package:flirta/common/domain/entites/entities.dart';
import 'package:either_dart/either.dart';

abstract class ProfileRepository {
  Future<Either<ProfileRepositoryError, User>> getProfile();
  Future<Either<ProfileRepositoryError, bool>> update(User user);
  Future<Either<ProfileRepositoryError, bool>> delete();
  Future<void> init();
}

enum ProfileRepositoryError { wrongGetProfile }
