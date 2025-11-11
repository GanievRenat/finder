import 'package:either_dart/either.dart';
import 'package:flirta/common/data/models/models.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetPersonList {
  final PersonRepository _personRepository;

  GetPersonList({required PersonRepository personRepository})
    : _personRepository = personRepository;

  Future<Either<PersonRepositoryError, List<PersonModel>>> call(
    GetPersonByFilterBody body,
  ) async {
    var result = await _personRepository.getPersonByFilter(body);
    return result;
  }
}
