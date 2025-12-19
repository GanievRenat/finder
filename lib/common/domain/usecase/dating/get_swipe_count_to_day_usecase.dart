// Получить детали персонажа
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetSwipeCountToDay {
  final AppStateService _appStateService;
  final DatingRepository _datingRepository;

  GetSwipeCountToDay({
    required AppStateService appStateService,
    required DatingRepository datingRepository,
  }) : _appStateService = appStateService,
       _datingRepository = datingRepository;

  Future<int> call() async {
    var result = await _datingRepository.getSwipeCount(_appStateService.getUid);
    return result;
  }
}
