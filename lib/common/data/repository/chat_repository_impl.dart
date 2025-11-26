import 'package:either_dart/either.dart';
import 'package:flirta/common/data/models/models.dart';
import 'package:flirta/common/domain/entites/chat/chat.dart';
import 'package:flirta/common/domain/entites/chat/message.dart';
import 'package:flirta/common/domain/repository/bodies/add_new_message_body.dart';
import 'package:flirta/common/domain/repository/bodies/create_new_chat_body.dart';
import 'package:flirta/common/domain/repository/bodies/get_message_of_chat_body.dart';
import 'package:flirta/common/domain/repository/repositories.dart';
import 'package:injectable/injectable.dart';

import '../providers/chat_local_data_provider.dart';

@Singleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final ChatLocalDataProvider _localDataProvider;

  ChatRepositoryImpl({required ChatLocalDataProvider localDataProvider})
    : _localDataProvider = localDataProvider;

  @override
  Future<Either<ChatError, List<Messages>>> addNewMessage(
    String userUid,
    AddNewMessageBody body,
  ) async {
    try {
      var result = await _localDataProvider.addNewMessage(userUid, body);
      var resultMessages = result.map((e) => e.toEntites()).toList();
      return Future.value(Right(resultMessages));
    } catch (e) {
      return Future.value(Left(MainChatError()));
    }
  }

  @override
  Future<Either<ChatError, List<Chat>>> getChats(String userId) async {
    try {
      // Получаем все сообщения
      var messageModels = await _localDataProvider.getAllMessageByUserId(
        userId,
      );
      var messageEntities = messageModels.map((e) => e.toEntites()).toList();
      // Получаем все чаты.
      var chatModlels = await _localDataProvider.getChats(userUid: userId);
      // комбинируем все в один объект и возвращаем его
      var chatEntities = chatModlels.map((e) {
        var messageByModelId = messageEntities
            .where((msg) => msg.modelId == e.modelId)
            .toList();
        return e.toEntites(messageByModelId);
      }).toList();

      return Right(chatEntities);
    } catch (e) {
      return Future.value(Left(MainChatError()));
    }
  }

  @override
  Future<Either<ChatError, List<Messages>>> getMessageOfChat(
    GetMessageOfChatBody body,
  ) async {
    try {
      var result = await _localDataProvider.getMessageOfChat(body);
      var resultMessages = result.map((e) => e.toEntites()).toList();

      return Future.value(Right(resultMessages));
    } catch (e) {
      return Future.value(Left(MainChatError()));
    }
  }

  @override
  Future<Either<ChatError, int>> createNewChat(CreateNewChatBody body) async {
    try {
      var result = await _localDataProvider.createNewChat(body: body);
      return Right(result);
    } catch (e) {
      return Future.value(Left(MainChatError()));
    }
  }
}
