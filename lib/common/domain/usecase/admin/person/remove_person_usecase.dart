import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class RemovePerson {
  final PersonRepository _personRepository;

  RemovePerson({required PersonRepository personRepository})
    : _personRepository = personRepository;

  Future<Either<PersonRepositoryError, bool>> call(String modelId) async {
    var result = await _personRepository.delete(modelId);
    return result;
  }
}
