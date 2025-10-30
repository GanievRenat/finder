import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class SaveRegistrationFormData {
  final RegistrationFormRepository _registrationFormRepository;

  SaveRegistrationFormData({
    required RegistrationFormRepository registrationFormRepository,
  }) : _registrationFormRepository = registrationFormRepository;

  Future<bool> call(RegistrationDataBody data) async {
    await _registrationFormRepository.saveRegistrationData(data);
    return true;
  }
}
