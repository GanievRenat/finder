import 'package:injectable/injectable.dart';
import 'package:drift/drift.dart';

import '../database_manager.dart';

@singleton
class ChatMessagesTable {
  final AppDatabase appDatabase;

  ChatMessagesTable(this.appDatabase);

  /* 
    Добавить новое сообщение в чат
    Отметить все сообщения как прочитанные
    Получить все сообщения чата
    Удалить все сообщения чата
  */

  // Добавить новое сообщение в чат
  Future<int> createNewMessage({
    required String modelId,
    required String userUid,
    required String owner,
    required String message,
    required String images,
    required bool isRead,
  }) async {
    try {
      var result = await appDatabase
          .into(appDatabase.messages)
          .insert(
            MessagesCompanion.insert(
              atCreated: DateTime.now().millisecondsSinceEpoch,
              modelId: modelId,
              userUid: userUid,
              owner: owner,
              message: message,
              images: images,
              isRead: isRead,
            ),
          );
      return result;
    } catch (e) {
      rethrow;
    }
  }

  // Получить все сообщения чата
  Future<List<Map<String, dynamic>>> getByModelId({
    required String userUid,
    required String modelId,
  }) async {
    try {
      var result =
          await (appDatabase.select(appDatabase.messages)..where(
                (t) => t.userUid.equals(userUid) & t.modelId.equals(modelId),
              ))
              .get();

      var resultMap = result.map((row) => row.toJson()).toList();
      return resultMap;
    } catch (e) {
      rethrow;
    }
  }

  // Получить все сообщения от всех чатов пользователя
  Future<List<Map<String, dynamic>>> get({required String userUid}) async {
    try {
      var result = await (appDatabase.select(
        appDatabase.messages,
      )..where((t) => t.userUid.equals(userUid))).get();

      var resultMap = result.map((row) => row.toJson()).toList();
      return resultMap;
    } catch (e) {
      rethrow;
    }
  }

  // Отметить все сообщения как прочитанные
  Future<int> setReadStatus({
    required String userUid,
    required String modelId,
  }) async {
    try {
      var result =
          await (appDatabase.update(appDatabase.messages)..where(
                (t) => t.userUid.equals(userUid) & t.modelId.equals(modelId),
              ))
              .write(MessagesCompanion(isRead: Value(true)));

      return result;
    } catch (e) {
      rethrow;
    }
  }

  // Удалить все сообщения в чатах
  Future<int> clear({required String userUid}) async {
    try {
      var result = await (appDatabase.delete(
        appDatabase.messages,
      )..where((t) => t.userUid.equals(userUid))).go();
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
