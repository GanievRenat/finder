import 'package:flirta/common/data/models/models.dart';
import 'package:flirta/common/data/providers/admin/person_data_provider.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';
import 'package:either_dart/either.dart';

@Singleton(as: PersonRepository)
class PersonRepositoryImpl implements PersonRepository {
  final PersonDataProvider _dataProvider;

  PersonRepositoryImpl({required PersonDataProvider dataProvider})
    : _dataProvider = dataProvider;

  @override
  Future<Either<PersonRepositoryError, bool>> create(PersonModel person) async {
    var result = await _dataProvider.create(person);
    return result;
  }

  @override
  Future<Either<PersonRepositoryError, List<PersonModel>>> getPersonByFilter(
    GetPersonByFilterBody body,
  ) async {
    var result = await _dataProvider.getPersonsByFilter(body);
    return result;
  }

  @override
  Future<Either<PersonRepositoryError, bool>> delete(String modelId) async {
    var result = await _dataProvider.delete(modelId);
    return result;
  }

  @override
  Future<Either<PersonRepositoryError, bool>> update(PersonModel person) async {
    var result = await _dataProvider.update(person);
    return result;
  }
}
