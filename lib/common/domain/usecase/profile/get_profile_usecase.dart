import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetProfile {
  final ProfileRepository repository;

  GetProfile({required this.repository});

  Future<Either<ProfileRepositoryError, User>> call() async {
    var result = await repository.getProfile();
    return result;
  }
}
