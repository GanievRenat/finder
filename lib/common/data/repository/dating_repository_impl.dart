import 'package:flirta/common/data/models/persons/person_mapper.dart';
import 'package:flirta/common/data/providers/data_providers.dart';
import 'package:flirta/common/domain/entites/person/person.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';
import 'package:either_dart/either.dart';

@Singleton(as: DatingRepository)
class DatingRepositoryImpl implements DatingRepository {
  final DatingDataProvider _dataProvider;

  DatingRepositoryImpl({required DatingDataProvider dataProvider})
    : _dataProvider = dataProvider;

  @override
  Future<Either<DatingError, List<Person>>> getPartOfPersonsForDating(
    GetPartOfPersonsForDatingBody body,
  ) async {
    var result = await _dataProvider.getPartOfPersonsForDating(body);
    if (result.isRight) {
      var entities = result.right.map((e) => e.toEntites()).toList();
      return Future.value(Right(entities));
    } else {
      return Future.value(Left(result.left));
    }
  }

  @override
  Future<Either<DatingError, bool>> likePerson(LikePersonBody body) async {
    var result = await _dataProvider.likePerson(body);
    return result;
  }

  @override
  Future<Either<DatingError, bool>> skipPerson(SkipPersonBody body) async {
    var result = await _dataProvider.skipPerson(body);
    return result;
  }

  @override
  Future<Either<DatingError, bool>> undoPerson(UndoPersonBody body) async {
    var result = await _dataProvider.undoPerson(body);
    return result;
  }
}
