import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flirta/common/domain/repository/admin/bodies/auth_by_admin_body.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthByAdmin {
  final AuthAdminRepository _authAdminRepository;
  final AppStateService _appStateService;

  AuthByAdmin({
    required AuthAdminRepository authAdminRepository,
    required AppStateService appStateService,
  }) : _authAdminRepository = authAdminRepository,
       _appStateService = appStateService;

  Future<Either<AuthAdminRepositoryErrors, User>> call(
    AuthByAdminBody body,
  ) async {
    var result = await _authAdminRepository.authByAdmin(body);
    if (result.isRight) {
      _appStateService.adminUser = result.right;
    }
    return result;
  }
}
