// Удаляем персонаж из таблицы block
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class UndoLast {
  final AppStateService _appStateService;
  final DatingRepository _datingRepository;

  UndoLast({
    required AppStateService appStateService,
    required DatingRepository datingRepository,
  }) : _appStateService = appStateService,
       _datingRepository = datingRepository;

  Future<bool> call() async {
    // Удаляем пользователя из таблицы заблокированных

    await _datingRepository.undoLast(
      UndoLastBody(userUid: _appStateService.getUid),
    );
    return true;
  }
}
