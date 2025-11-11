import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/data/models/models.dart';
import 'package:either_dart/either.dart';
import 'package:flirta/generated/locale_keys.g.dart';

import 'bodies/bodies.dart';

abstract class PersonRepository {
  Future<Either<PersonRepositoryError, List<PersonModel>>> getPersonByFilter(
    GetPersonByFilterBody body,
  );
  Future<Either<PersonRepositoryError, bool>> update(PersonModel person);
  Future<Either<PersonRepositoryError, bool>> create(PersonModel person);
  Future<Either<PersonRepositoryError, bool>> delete(String modelId);
}

sealed class PersonRepositoryError {
  final String errorText;
  PersonRepositoryError(this.errorText);
}

class MainPersonRepositoryError extends PersonRepositoryError {
  MainPersonRepositoryError()
    : super(LocaleKeys.user_profile_error_get_profile_error.tr());
}
