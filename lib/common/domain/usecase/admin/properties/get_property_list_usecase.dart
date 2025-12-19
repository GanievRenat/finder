import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetPropertyList {
  final PropertiesAdminRepository _propertyRepository;

  GetPropertyList({required PropertiesAdminRepository propertyRepository})
    : _propertyRepository = propertyRepository;

  Future<List<String>> call(String property) async {
    var result = await _propertyRepository.getValuesOfProperty(property);
    if (result.isLeft) {
      return [];
    }
    return result.right;
  }
}
