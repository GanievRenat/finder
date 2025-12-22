import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

@singleton
class LoadQueueMessage {
  final ChatRepository _chatRepository;

  LoadQueueMessage({required ChatRepository chatRepository})
    : _chatRepository = chatRepository;

  Future<Map<String, dynamic>> call() async {
    var result = await _chatRepository.loadRequestIds();
    result.removeWhere((key, value) => key.contains('banana'));
    return result;
  }
}
