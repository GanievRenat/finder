import 'package:either_dart/either.dart';
import 'package:flirta/common/data/models/models.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class CreateNewPerson {
  final PersonAdminRepository _personRepository;

  CreateNewPerson({required PersonAdminRepository personRepository})
    : _personRepository = personRepository;

  Future<Either<PersonRepositoryError, bool>> call(
    PersonModel newPerson,
  ) async {
    var result = await _personRepository.create(newPerson);
    return result;
  }
}
