import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/service/services.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetDetailChat {
  final ChatRepository _chatRepository;
  final AppStateService _appStateService;

  GetDetailChat({
    required ChatRepository chatRepository,
    required AppStateService appStateService,
  }) : _chatRepository = chatRepository,
       _appStateService = appStateService;

  Future<Either<ChatError, List<Messages>>> call(String modelId) async {
    var result = await _chatRepository.getMessageOfChat(
      GetMessageOfChatBody(userUid: _appStateService.getUid, modelId: modelId),
    );
    if (result.isRight) {
      _chatRepository.setReadStatus(
        SetReadStatusBody(modelId: modelId, userUid: _appStateService.getUid),
      );
    }
    return result;
  }
}
