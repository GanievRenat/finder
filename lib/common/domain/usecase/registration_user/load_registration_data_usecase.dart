import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class LoadRegistrationData {
  final RegistrationRepository repository;

  LoadRegistrationData({required this.repository});

  Future<RegistrationData> call() async {
    var regData = await repository.getRegistrationData();
    return regData ?? RegistrationData.empty();
  }
}
