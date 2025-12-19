import 'dart:convert';

import 'package:flirta/common/data/models/models.dart';
import 'package:flirta/common/domain/app_config.dart';
import 'package:flirta/common/domain/repository/bodies/bodies.dart';
import 'package:flirta/common/enums/owner_enums.dart';
import 'package:flirta/common/source/database/table/chat_messages_table.dart';
import 'package:flirta/common/source/database/table/chat_table.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ChatLocalDataProvider {
  Future<int> createNewChat({required CreateNewChatBody body});
  Future<List<ChatModel>> getChats({required String userUid});
  Future<List<MessagesModel>> getMessageOfChat(GetMessageOfChatBody body);
  Future<List<MessagesModel>> getAllMessageByUserId(String userUid);
  Future<int> addNewMessage(String userUid, AddNewMessageBody body);
  Future<int> setReadStatus({required SetReadStatusBody body});
  Future<bool> clear(String userUid);
  Future<void> saveRequestIds(Map<String, dynamic> requestIds);
  Future<Map<String, dynamic>> loadRequestIds();
}

//**
// Поставщик локальных данных
// */
@Singleton(as: ChatLocalDataProvider)
class ChatLocalDataProviderImpl extends ChatLocalDataProvider {
  final ChatTable _chatTable;
  final ChatMessagesTable _messageTable;
  final SharedPreferences _sharedPreferences;
  final AppConfig _appConfig;

  ChatLocalDataProviderImpl({
    required ChatTable chatTable,
    required ChatMessagesTable messageTable,
    required SharedPreferences sharedPreferences,
    required AppConfig appConfig,
  }) : _chatTable = chatTable,
       _messageTable = messageTable,
       _sharedPreferences = sharedPreferences,
       _appConfig = appConfig;

  @override
  Future<List<ChatModel>> getChats({required String userUid}) async {
    try {
      var result = await _chatTable.get(userUid: userUid);

      var resultChatModels = result.map((e) => ChatModel.fromJson(e)).toList();
      return resultChatModels;
    } catch (e) {
      throw Exception('No chat found');
    }
  }

  @override
  Future<List<MessagesModel>> getMessageOfChat(
    GetMessageOfChatBody body,
  ) async {
    try {
      var result = await _messageTable.getByModelId(
        userUid: body.userUid,
        modelId: body.modelId,
      );

      var resultMessageModels = result
          .map((e) => MessagesModel.fromJson(e))
          .toList();

      return resultMessageModels;
    } catch (e) {
      throw Exception('No messages found');
    }
  }

  @override
  Future<List<MessagesModel>> getAllMessageByUserId(String userUid) async {
    try {
      var result = await _messageTable.get(userUid: userUid);

      var resultMessageModels = result
          .map((e) => MessagesModel.fromJson(e))
          .toList();
      return resultMessageModels;
    } catch (e) {
      throw Exception('No messages found');
    }
  }

  @override
  Future<int> addNewMessage(String userUid, AddNewMessageBody body) async {
    try {
      var result = await _messageTable.createNewMessage(
        modelId: body.modelId,
        userUid: userUid,
        owner: body.owner.displayName,
        message: body.message,
        images: body.images.join(';'),
        isRead: (body.owner == Owner.you) ? true : false,
      );
      return result;
    } catch (e) {
      throw Exception('No messages found');
    }
  }

  @override
  Future<int> createNewChat({required CreateNewChatBody body}) async {
    try {
      var result = await _chatTable.createNewChat(
        modelId: body.modelId,
        userUid: body.userUid,
        modelName: body.modelName,
        modelAvatar: body.modelAvatar,
      );
      return result;
    } catch (e) {
      throw Exception('No messages found');
    }
  }

  @override
  Future<int> setReadStatus({required SetReadStatusBody body}) async {
    // Отмечаем все сообщения как прочитанные
    var result = await _messageTable.setReadStatus(
      userUid: body.userUid,
      modelId: body.modelId,
    );
    return result;
  }

  @override
  Future<bool> clear(String userUid) async {
    try {
      await _chatTable.clear(userUid: userUid);
      await _messageTable.clear(userUid: userUid);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Map<String, dynamic>> loadRequestIds() {
    var value =
        _sharedPreferences.getString(
          _appConfig.localKeies[LocalKeies.localRequestIds]!,
        ) ??
        '';
    if (value.isNotEmpty) {
      Map<String, dynamic> map = json.decode(value);
      return Future.value(map);
    }
    return Future.value({});
  }

  @override
  Future<void> saveRequestIds(Map<String, dynamic> requestIds) {
    _sharedPreferences.setString(
      _appConfig.localKeies[LocalKeies.localRequestIds]!,
      json.encode(requestIds),
    );

    return Future.value();
  }
}
