import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class UpdateProfile {
  final ProfileRepository repository;

  UpdateProfile({required this.repository});

  Future<Either<ProfileRepositoryError, bool>> call(User user) async {
    var result = await repository.update(user);
    return result;
  }
}
