import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class SaveQueueMessage {
  final ChatRepository _chatRepository;

  SaveQueueMessage({required ChatRepository chatRepository})
    : _chatRepository = chatRepository;

  Future<void> call(Map<String, dynamic> requestIds) async {
    requestIds.removeWhere((key, value) => key.contains('banana'));
    var result = _chatRepository.saveRequestIds(requestIds);
    return result;
  }
}
