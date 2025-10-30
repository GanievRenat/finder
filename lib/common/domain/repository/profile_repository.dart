import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:either_dart/either.dart';
import 'package:flirta/generated/locale_keys.g.dart';

abstract class ProfileRepository {
  Future<Either<ProfileRepositoryError, User>> getProfile();
  Future<Either<ProfileRepositoryError, bool>> update(User user);
  Future<Either<ProfileRepositoryError, bool>> delete();
  Future<void> init();
}

sealed class ProfileRepositoryError {
  final String errorText;
  ProfileRepositoryError(this.errorText);
}

class WrongGetProfileError extends ProfileRepositoryError {
  WrongGetProfileError()
    : super(LocaleKeys.user_profile_error_get_profile_error.tr());
}

class ThereIsntProfileError extends ProfileRepositoryError {
  ThereIsntProfileError()
    : super(LocaleKeys.user_profile_error_get_profile_error.tr());
}

class WrongDeleteProfileError extends ProfileRepositoryError {
  WrongDeleteProfileError()
    : super(LocaleKeys.user_profile_error_delete_profile_error.tr());
}

class WrongUpdateProfileError extends ProfileRepositoryError {
  WrongUpdateProfileError()
    : super(LocaleKeys.user_profile_error_update_profile_error.tr());
}
