import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/service/app_state_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class CreateNewChat {
  final ChatRepository _chatRepository;
  final AppStateService _appStateService;

  CreateNewChat({
    required ChatRepository chatRepository,
    required AppStateService appStateService,
  }) : _chatRepository = chatRepository,
       _appStateService = appStateService;

  Future<Either<ChatError, int>> call(Person person) async {
    var result = await _chatRepository.createNewChat(
      CreateNewChatBody(
        modelId: person.modelId,
        modelName: person.name,
        modelAvatar: (person.photos.isNotEmpty) ? person.photos.first : '',
        userUid: _appStateService.currentUser.uid,
      ),
    );
    return result;
  }
}
