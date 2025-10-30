import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class DeleteProfile {
  final ProfileRepository _profileRepository;
  final AppStateService _appStateService;

  DeleteProfile({
    required AppStateService appStateService,
    required ProfileRepository profileRepository,
  }) : _appStateService = appStateService,
       _profileRepository = profileRepository;

  Future<Either<ProfileRepositoryError, bool>> call() async {
    var result = await _profileRepository.delete();
    _appStateService.clearCurrentUser();
    return result;
  }
}
