import 'package:firebase_auth/firebase_auth.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class InitAdmin {
  final AuthAdminRepository _authAdminRepository;
  final AppStateService _appStateService;

  InitAdmin({
    required AuthAdminRepository authAdminRepository,
    required AppStateService appStateService,
  }) : _authAdminRepository = authAdminRepository,
       _appStateService = appStateService;

  Future<User?> call() async {
    var result = await _authAdminRepository.init();
    if (result != null) {
      _appStateService.adminUser = result;
      return result;
    }
    return null;
  }
}
