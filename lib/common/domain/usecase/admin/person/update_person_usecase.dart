import 'package:either_dart/either.dart';
import 'package:flirta/common/data/models/models.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class UpdatePerson {
  final PersonAdminRepository _personRepository;

  UpdatePerson({required PersonAdminRepository personRepository})
    : _personRepository = personRepository;

  Future<Either<PersonRepositoryError, bool>> call(
    PersonModel newPerson,
  ) async {
    var result = await _personRepository.update(newPerson);
    return result;
  }
}
