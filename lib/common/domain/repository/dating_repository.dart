import 'package:easy_localization/easy_localization.dart';
import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/generated/locale_keys.g.dart';

abstract class DatingRepository {
  // Получить партию моделей для дейтинга.
  // Учитывает фильтры, список match, список block
  Future<Either<DatingError, List<Person>>> getPartOfPersonsForDating(
    GetPartOfPersonsForDatingBody body,
  );
  Future<Either<DatingError, Person>> getDetailOfPerson(
    GetDetailOfPersonBody body,
  );
  // Должен вернуть ид чата или полноценный чат, добавить в список - match
  Future<Either<DatingError, bool>> likePerson(LikePersonBody body);
  // добавляем в список block
  Future<Either<DatingError, bool>> skipPerson(SkipPersonBody body);
  // удаляем из списка block
  Future<Either<DatingError, bool>> undoLast(UndoLastBody body);
  // Кол-во свайпов за сегодня
  Future<int> getSwipeCount(String userUid);
  Future<int> deleteOlderBlockData(String userUid);
  Future<bool> clear(String userUid);
}

sealed class DatingError {
  final String errorText;
  DatingError(this.errorText);
}

class MainDatingError extends DatingError {
  MainDatingError() : super(LocaleKeys.filter_errors_main.tr());
}
