// Добавляем персонажа в блок лист

import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class SkipPerson {
  final AppStateService _appStateService;
  final DatingRepository _datingRepository;

  SkipPerson({
    required AppStateService appStateService,
    required DatingRepository datingRepository,
  }) : _appStateService = appStateService,
       _datingRepository = datingRepository;

  Future<bool> call(Person person) async {
    // Записываем пользователя в базу данных куда, чтобы в будущем учесть.
    await _datingRepository.skipPerson(
      SkipPersonBody(person: person, userUid: _appStateService.currentUser.uid),
    );
    return true;
  }
}
