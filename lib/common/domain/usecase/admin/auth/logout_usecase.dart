import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class LogoutAdmin {
  final AuthAdminRepository _authAdminRepository;
  final AppStateService _appStateService;

  LogoutAdmin({
    required AuthAdminRepository authAdminRepository,
    required AppStateService appStateService,
  }) : _authAdminRepository = authAdminRepository,
       _appStateService = appStateService;

  Future<Either<AuthAdminRepositoryErrors, bool>> call() async {
    var result = await _authAdminRepository.logout();
    _appStateService.adminUser = null;
    return result;
  }
}
