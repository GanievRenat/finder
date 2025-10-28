import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class SaveRegistrationData {
  final RegistrationRepository repository;

  SaveRegistrationData({required this.repository});

  Future<bool> call(RegistrationDataBody data) async {
    await repository.saveRegistrationData(data);
    return true;
  }
}
