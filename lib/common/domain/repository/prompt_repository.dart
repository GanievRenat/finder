import 'package:easy_localization/easy_localization.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:either_dart/either.dart';
import 'package:flirta/generated/locale_keys.g.dart';

abstract class PromptRepository {
  Future<Either<PromptRepositoryError, Prompts>> getPrompts();
  Future<Either<PromptRepositoryError, bool>> update(Prompts prompt);
  Future<void> init();
}

sealed class PromptRepositoryError {
  final String errorText;
  PromptRepositoryError(this.errorText);
}

class WrongPromptError extends PromptRepositoryError {
  WrongPromptError()
    : super(LocaleKeys.user_profile_error_get_profile_error.tr());
}
