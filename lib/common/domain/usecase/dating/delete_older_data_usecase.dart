import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class DeleteOlderData {
  final AppStateService _appStateService;
  final DatingRepository _datingRepository;

  DeleteOlderData({
    required AppStateService appStateService,
    required DatingRepository datingRepository,
  }) : _appStateService = appStateService,
       _datingRepository = datingRepository;

  Future<bool> call() async {
    // Удаляем старые заблокированные модели
    await _datingRepository.deleteOlderBlockData(
      _appStateService.currentUser.uid,
    );
    return true;
  }
}
