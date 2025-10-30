import 'package:flirta/common/data/models/models.dart';
import 'package:flirta/common/data/providers/data_providers.dart';
import 'package:flirta/common/domain/entites/registration/registration_data.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: RegistrationFormRepository)
class RegistrationFormRepositoryImpl implements RegistrationFormRepository {
  final RegistrationFormDataProvider _dataProvider;

  RegistrationFormRepositoryImpl({
    required RegistrationFormDataProvider dataProvider,
  }) : _dataProvider = dataProvider;

  @override
  Future<RegistrationData?> getRegistrationData() async {
    var value = await _dataProvider.getRegistrationData();
    return Future.value(value?.toEntites());
  }

  @override
  Future<bool> saveRegistrationData(RegistrationDataBody body) async {
    var value = await _dataProvider.saveRegistrationData(body);
    return Future.value(value);
  }

  @override
  Future<bool> clearData() async {
    await _dataProvider.clearData();
    return true;
  }
}
