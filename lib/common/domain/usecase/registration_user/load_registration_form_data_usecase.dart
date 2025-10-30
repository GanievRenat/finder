import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class LoadRegistrationFormData {
  final RegistrationFormRepository _registrationFormRepository;

  LoadRegistrationFormData({
    required RegistrationFormRepository registrationFormRepository,
  }) : _registrationFormRepository = registrationFormRepository;

  Future<RegistrationData> call() async {
    var regData = await _registrationFormRepository.getRegistrationData();
    return regData ?? RegistrationData.empty();
  }
}
