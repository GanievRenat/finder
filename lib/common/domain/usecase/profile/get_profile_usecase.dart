import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetProfile {
  final ProfileRepository _profileRepository;
  final AppStateService _appStateService;

  GetProfile({
    required ProfileRepository profileRepository,
    required AppStateService appStateService,
  }) : _profileRepository = profileRepository,
       _appStateService = appStateService;

  Future<Either<ProfileRepositoryError, User>> call() async {
    var result = await _profileRepository.getProfile();
    if (result.isRight) {
      _appStateService.currentUser = result.right;
    }
    return result;
  }
}
