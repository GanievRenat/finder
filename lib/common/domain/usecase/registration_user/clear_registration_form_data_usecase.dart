import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class ClearRegistrationFormData {
  final RegistrationFormRepository _registrationFormRepository;

  ClearRegistrationFormData({
    required RegistrationFormRepository registrationFormRepository,
  }) : _registrationFormRepository = registrationFormRepository;

  Future<bool> call() async {
    await _registrationFormRepository.clearData();
    return true;
  }
}
