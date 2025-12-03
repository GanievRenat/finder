import 'package:venice_client/common/data/api/chat_completions/body/chat_completions_body.dart';
import 'package:venice_client/common/data/models/answer/answer_model.dart';
import 'package:venice_client/common/domain/entities/answer/answer.dart';
import 'package:venice_client/common/domain/repository/body/send_message_body.dart';
import 'package:venice_client/common/domain/repository/message_repository.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../api/chat_completions/chat_completions_api.dart';

@Singleton(as: MessageRepository)
class MessageRepositoryImpl implements MessageRepository {
  final ChatCompletionsApi _chatCompletionsApi;

  MessageRepositoryImpl({required ChatCompletionsApi chatCompletionsApi})
    : _chatCompletionsApi = chatCompletionsApi;

  @override
  Future<Either<SendMessageError, Answer>> send(SendMessageBody body) async {
    try {
      var result = await _chatCompletionsApi.send(
        request: ChatCompletionsBody(
          messages: body.messages.map((e) => e.toMap()).toList(),
          model: body.model.toString(),
        ),
      );
      // result -> entities
      return Right(result.toEntites());
    } catch (e) {
      return Left(SendMessageError.wrongSomeThings);
    }
  }
}
