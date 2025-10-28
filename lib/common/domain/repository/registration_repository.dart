import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';

abstract class RegistrationRepository {
  Future<bool> saveRegistrationData(RegistrationDataBody body);
  Future<RegistrationData?> getRegistrationData();
}
