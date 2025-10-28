import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class DeleteProfile {
  final ProfileRepository repository;

  DeleteProfile({required this.repository});

  Future<Either<ProfileRepositoryError, bool>> call() async {
    var result = await repository.delete();
    return result;
  }
}
