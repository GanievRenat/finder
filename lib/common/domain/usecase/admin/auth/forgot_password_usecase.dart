import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/repository/admin/bodies/forgot_password_body.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class ForgotAdminPassword {
  final AuthAdminRepository _authAdminRepository;

  ForgotAdminPassword({required AuthAdminRepository authAdminRepository})
    : _authAdminRepository = authAdminRepository;

  Future<Either<AuthAdminRepositoryErrors, bool>> call(
    ForgotPasswordBody body,
  ) async {
    var result = await _authAdminRepository.forgotPassword(body);
    return result;
  }
}
