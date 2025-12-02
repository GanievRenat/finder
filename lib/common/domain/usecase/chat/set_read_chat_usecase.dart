import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/service/services.dart';
import 'package:injectable/injectable.dart';

@singleton
class SetReadChat {
  final ChatRepository _chatRepository;
  final AppStateService _appStateService;

  SetReadChat({
    required ChatRepository chatRepository,
    required AppStateService appStateService,
  }) : _chatRepository = chatRepository,
       _appStateService = appStateService;

  Future<int> call(String modelId) async {
    var result = _chatRepository.setReadStatus(
      SetReadStatusBody(
        modelId: modelId,
        userUid: _appStateService.currentUser.uid,
      ),
    );
    return result;
  }
}
