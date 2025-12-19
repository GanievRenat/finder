import 'package:flirta/common/data/providers/admin/properties_data_provider.dart';
import 'package:flirta/common/domain/repository/admin/properties_admin_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:either_dart/either.dart';

@Singleton(as: PropertiesAdminRepository)
class PropertiesAdminRepositoryImpl implements PropertiesAdminRepository {
  final PropertiesDataProvider _dataProvider;

  PropertiesAdminRepositoryImpl({required PropertiesDataProvider dataProvider})
    : _dataProvider = dataProvider;

  @override
  Future<Either<PropertiesRepositoryError, List<String>>> getValuesOfProperty(
    String property,
  ) async {
    var result = await _dataProvider.getValuesOfProperty(property);
    return result;
  }

  @override
  Future<Either<PropertiesRepositoryError, bool>> saveValuesOfProperty({
    required String property,
    required List<String> values,
  }) async {
    var result = await _dataProvider.saveValuesOfProperty(
      property: property,
      values: values,
    );
    return result;
  }
}
