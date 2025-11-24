import 'package:injectable/injectable.dart';
import 'package:drift/drift.dart';

import '../database_manager.dart';

@singleton
class ChatTable {
  final AppDatabase appDatabase;

  ChatTable(this.appDatabase);

  // Создать новый чат
  Future<int> createNewChat({
    required String modelId,
    required String userUid,
    required String modelName,
    required String modelAvatar,
  }) async {
    try {
      var result = await appDatabase
          .into(appDatabase.chat)
          .insert(
            ChatCompanion.insert(
              modelId: modelId,
              atCreated: DateTime.now().millisecondsSinceEpoch,
              userUid: userUid,
              modelAvatar: modelAvatar,
              modelName: modelName,
            ),
          );
      return result;
    } catch (e) {
      rethrow;
    }
  }

  // Получить все чаты пользователя
  Future<List<Map<String, dynamic>>> get({required String userUid}) async {
    try {
      var result = await (appDatabase.select(
        appDatabase.chat,
      )..where((t) => t.userUid.equals(userUid))).get();

      var resultMap = result
          .map(
            (row) => row.toColumns(false) /* {
              'atCreated': row.atCreated,
              'userUid': row.userUid,
              'modelId': row.modelId,
              'modelAvatar': row.modelAvatar,
              'modelName': row.modelName,
            },*/,
          )
          .toList();
      return resultMap;
    } catch (e) {
      rethrow;
    }
  }

  // Удалить чат по modelId
  Future<int> delete({required String modelId, required String userUid}) async {
    try {
      var result =
          await (appDatabase.delete(appDatabase.chat)..where(
                (t) => t.modelId.equals(modelId) & t.userUid.equals(userUid),
              ))
              .go();
      return result;
    } catch (e) {
      rethrow;
    }
  }

  // Очистить все чаты пользователя
  Future<int> clear({required String userUid}) async {
    try {
      var result = await (appDatabase.delete(
        appDatabase.chat,
      )..where((t) => t.userUid.equals(userUid))).go();
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
