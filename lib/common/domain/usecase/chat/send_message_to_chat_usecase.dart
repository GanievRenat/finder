import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/service/services.dart';
import 'package:injectable/injectable.dart';

@singleton
class SendMessageToChat {
  final ChatRepository _chatRepository;
  final AppStateService _appStateService;

  SendMessageToChat({
    required ChatRepository chatRepository,
    required AppStateService appStateService,
  }) : _chatRepository = chatRepository,
       _appStateService = appStateService;

  Future<Either<ChatError, int>> call(AddNewMessageBody body) async {
    var result = await _chatRepository.addNewMessage(
      _appStateService.getUid,
      body,
    );
    return result;
  }
}
