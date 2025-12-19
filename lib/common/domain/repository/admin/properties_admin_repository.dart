import 'package:easy_localization/easy_localization.dart';
import 'package:either_dart/either.dart';
import 'package:flirta/generated/locale_keys.g.dart';

abstract class PropertiesAdminRepository {
  Future<Either<PropertiesRepositoryError, List<String>>> getValuesOfProperty(
    String property,
  );
  Future<Either<PropertiesRepositoryError, bool>> saveValuesOfProperty({
    required String property,
    required List<String> values,
  });
}

sealed class PropertiesRepositoryError {
  final String errorText;
  PropertiesRepositoryError(this.errorText);
}

class MainPropertiesRepositoryError extends PropertiesRepositoryError {
  MainPropertiesRepositoryError()
    : super(LocaleKeys.user_profile_error_get_profile_error.tr());
}
