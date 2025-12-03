import 'package:venice_client/common/domain/entities/message/message.dart';
import 'package:venice_client/common/domain/enums/enums.dart';

import 'body_request.dart';

class SendMessageBody extends RequestBody {
  final ModelsEnums model;
  final int frequencyPenalty;
  final List<Message> messages;

  SendMessageBody({
    required this.model,
    required this.messages,
    this.frequencyPenalty = 0,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      "model": model.toString(),
      "frequency_penalty": frequencyPenalty,
      "messages": messages.map((m) => m.toMap()),
    };
  }
}
