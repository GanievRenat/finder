import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class DeleteProfile {
  final ProfileRepository _profileRepository;
  final ChatRepository _chatRepository;
  final DatingRepository _datingRepository;
  final FilterRepository _filterRepository;
  final SettingsRepository _settingsRepository;
  final AppStateService _appStateService;
  final RegistrationFormRepository _registrationFormRepository;

  DeleteProfile({
    required AppStateService appStateService,
    required ProfileRepository profileRepository,
    required ChatRepository chatRepository,
    required DatingRepository datingRepository,
    required FilterRepository filterRepository,
    required SettingsRepository settingsRepository,
    required RegistrationFormRepository registrationFormRepository,
  }) : _appStateService = appStateService,
       _profileRepository = profileRepository,
       _chatRepository = chatRepository,
       _datingRepository = datingRepository,
       _filterRepository = filterRepository,
       _settingsRepository = settingsRepository,
       _registrationFormRepository = registrationFormRepository;

  Future<Either<ProfileRepositoryError, bool>> call() async {
    var result = await _profileRepository.delete();
    if (result.isRight) {
      await _chatRepository.clear(_appStateService.currentUser.uid);
      await _datingRepository.clear(_appStateService.currentUser.uid);
      await _filterRepository.clear();
      await _settingsRepository.clear(_appStateService.currentUser.uid);
      await _registrationFormRepository.clearData();

      _appStateService.clearCurrentUser();
    }

    return result;
  }
}
