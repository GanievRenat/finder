import 'package:either_dart/either.dart';
import 'package:flirta/common/domain/entites/entities.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:flirta/common/service/services.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetChatList {
  final ChatRepository _chatRepository;
  final AppStateService _appStateService;

  GetChatList({
    required ChatRepository chatRepository,
    required AppStateService appStateService,
  }) : _chatRepository = chatRepository,
       _appStateService = appStateService;

  Future<Either<ChatError, List<Chat>>> call() async {
    var result = await _chatRepository.getChats(
      _appStateService.currentUser.uid,
    );
    return result;
  }
}
