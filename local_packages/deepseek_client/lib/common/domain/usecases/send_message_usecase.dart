import 'package:either_dart/either.dart';

import '../entities/message/message.dart';
import '../entities/answer/answer.dart';
import '../enums/models_enums.dart';
import '../repository/body/send_message_body.dart';
import '../repository/message_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class SendMessage {
  final MessageRepository _messageRepository;

  SendMessage({required MessageRepository messageRepository})
    : _messageRepository = messageRepository;

  Future<Either<SendMessageError, Answer>> call({
    ModelsEnums model = ModelsEnums.chat,
    required List<Message> messages,
  }) async {
    var result = await _messageRepository.send(
      SendMessageBody(model: model, messages: messages),
    );
    return result;
  }
}
