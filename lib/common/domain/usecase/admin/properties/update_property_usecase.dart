import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class UpdateProperty {
  final PropertiesAdminRepository _propertyRepository;

  UpdateProperty({required PropertiesAdminRepository propertyRepository})
    : _propertyRepository = propertyRepository;

  Future<Either<PropertiesRepositoryError, bool>> call(
    String property,
    List<String> values,
  ) async {
    var result = await _propertyRepository.saveValuesOfProperty(
      property: property,
      values: values,
    );
    return result;
  }
}
