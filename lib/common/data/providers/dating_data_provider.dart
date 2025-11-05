import 'package:either_dart/either.dart';
import 'package:flirta/common/data/models/persons/person_model.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/source/database/table/match_table.dart';
import 'package:injectable/injectable.dart';

abstract class DatingDataProvider {
  Future<Either<DatingError, List<PersonModel>>> getPartOfPersonsForDating(
    GetPartOfPersonsForDatingBody body,
  );
  Future<Either<DatingError, bool>> likePerson(LikePersonBody body);
  Future<Either<DatingError, bool>> skipPerson(SkipPersonBody body);
  Future<Either<DatingError, bool>> undoPerson(UndoPersonBody body);
}

//**
// Поставщик данных для регистрации пользователя
// */
@Singleton(as: DatingDataProvider)
class DatingDataProviderLocal extends DatingDataProvider {
  final MatchAndBlockTable _matchAndBlockTable;

  DatingDataProviderLocal({required MatchAndBlockTable matchAndBlockTable})
    : _matchAndBlockTable = matchAndBlockTable;

  @override
  Future<Either<DatingError, List<PersonModel>>> getPartOfPersonsForDating(
    GetPartOfPersonsForDatingBody body,
  ) async {
    try {
      //var listModelIds = await _matchAndBlockTable.allModelIds(
      //  userUid: body.userUid,
      //);
      // Делаем запрос на сервер, передавая список моделей уже в работе и фильтры.
      return Future.value(Right([]));
    } catch (e) {
      return Future.value(Left(MainDatingError()));
    }
  }

  @override
  Future<Either<DatingError, bool>> likePerson(LikePersonBody body) async {
    try {
      await _matchAndBlockTable.insertModel(
        modelId: body.person.modelId,
        isBlock: false,
        userUid: body.userUid,
      );
      return Future.value(Right(true));
    } catch (e) {
      return Future.value(Left(MainDatingError()));
    }
  }

  @override
  Future<Either<DatingError, bool>> skipPerson(SkipPersonBody body) async {
    try {
      await _matchAndBlockTable.insertModel(
        modelId: body.person.modelId,
        isBlock: true,
        userUid: body.userUid,
      );
      return Future.value(Right(true));
    } catch (e) {
      return Future.value(Left(MainDatingError()));
    }
  }

  @override
  Future<Either<DatingError, bool>> undoPerson(UndoPersonBody body) async {
    try {
      await _matchAndBlockTable.deleteFromBlock(
        modelId: body.person.modelId,
        userUid: body.userUid,
      );
      return Future.value(Right(true));
    } catch (e) {
      return Future.value(Left(MainDatingError()));
    }
  }
}
