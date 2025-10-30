import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/service/services.dart';
import 'package:injectable/injectable.dart';

@singleton
class UpdateProfile {
  final ProfileRepository _profileRepository;
  final AppStateService _appStateService;

  UpdateProfile({
    required ProfileRepository profileRepository,
    required AppStateService appStateService,
  }) : _profileRepository = profileRepository,
       _appStateService = appStateService;

  Future<Either<ProfileRepositoryError, bool>> call(User user) async {
    var result = await _profileRepository.update(user);
    if (result.isRight) {
      _appStateService.currentUser = user;
    }
    return result;
  }
}
