import 'package:flirta/common/data/models/models.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/enums/owner_enums.dart';
import 'package:flirta/common/source/database/table/chat_messages_table.dart';
import 'package:flirta/common/source/database/table/chat_table.dart';
import 'package:injectable/injectable.dart';

abstract class ChatLocalDataProvider {
  Future<List<ChatModel>> createNewChat({required CreateNewChatBody body});
  Future<List<ChatModel>> getChats({required String userUid});
  Future<List<MessagesModel>> getMessageOfChat(GetMessageOfChatBody body);
  Future<List<MessagesModel>> getAllMessageByUserId(String userUid);
  Future<List<MessagesModel>> addNewMessage(
    String userUid,
    AddNewMessageBody body,
  );
}

//**
// Поставщик локальных данных
// */
@Singleton(as: ChatLocalDataProvider)
class ChatLocalDataProviderImpl extends ChatLocalDataProvider {
  final ChatTable _chatTable;
  final ChatMessagesTable _messageTable;

  ChatLocalDataProviderImpl({
    required ChatTable chatTable,
    required ChatMessagesTable messageTable,
  }) : _chatTable = chatTable,
       _messageTable = messageTable;

  @override
  Future<List<ChatModel>> getChats({required String userUid}) async {
    var result = await _chatTable.get(userUid: userUid);
    if (result.isNotEmpty) {
      var resultChatModels = result.map((e) => ChatModel.fromJson(e)).toList();
      return resultChatModels;
    } else {
      throw Exception('No chat found');
    }
  }

  @override
  Future<List<MessagesModel>> getMessageOfChat(
    GetMessageOfChatBody body,
  ) async {
    var result = await _messageTable.getByModelId(
      userUid: body.userUid,
      modelId: body.modelId,
    );
    if (result.isNotEmpty) {
      var resultMessageModels = result
          .map((e) => MessagesModel.fromJson(e))
          .toList();

      // Отмечаем все сообщения как прочитанные
      await _messageTable.setReadStatus(
        userUid: body.userUid,
        modelId: body.modelId,
      );

      return resultMessageModels;
    } else {
      throw Exception('No messages found');
    }
  }

  @override
  Future<List<MessagesModel>> getAllMessageByUserId(String userUid) async {
    var result = await _messageTable.get(userUid: userUid);
    if (result.isNotEmpty) {
      var resultMessageModels = result
          .map((e) => MessagesModel.fromJson(e))
          .toList();
      return resultMessageModels;
    } else {
      throw Exception('No messages found');
    }
  }

  @override
  Future<List<MessagesModel>> addNewMessage(
    String userUid,
    AddNewMessageBody body,
  ) async {
    try {
      await _messageTable.createNewMessage(
        modelId: body.modelId,
        userUid: userUid,
        owner: body.owner.displayName,
        message: body.message,
        images: body.images.join(';'),
        isRead: (body.owner == Owner.you) ? true : false,
      );
      var newMessageList = await getMessageOfChat(
        GetMessageOfChatBody(modelId: body.modelId, userUid: userUid),
      );
      return newMessageList;
    } catch (e) {
      throw Exception('No messages found');
    }
  }

  @override
  Future<List<ChatModel>> createNewChat({
    required CreateNewChatBody body,
  }) async {
    try {
      await _chatTable.createNewChat(
        modelId: body.modelId,
        userUid: body.userUid,
        modelName: body.modelName,
        modelAvatar: body.modelAvatar,
      );
      var result = getChats(userUid: body.userUid);
      return result;
    } catch (e) {
      throw Exception('No messages found');
    }
  }
}
