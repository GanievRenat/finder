import 'package:injectable/injectable.dart';
import 'package:drift/drift.dart';

import '../database_manager.dart';

@singleton
class MatchAndBlockTable {
  final AppDatabase appDatabase;

  MatchAndBlockTable(this.appDatabase);

  Future<int> insertModel({
    required String modelId,
    required bool isBlock,
    required String userUid,
  }) async {
    try {
      var result = await appDatabase
          .into(appDatabase.matchAndBlock)
          .insert(
            MatchAndBlockCompanion.insert(
              modelId: modelId,
              block: isBlock ? 1 : 0,
              atCreated: DateTime.now().millisecondsSinceEpoch,
              userUid: userUid,
            ),
          );
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>> allModelIds({required String userUid}) async {
    try {
      var result = await (appDatabase.select(
        appDatabase.matchAndBlock,
      )..where((t) => t.userUid.equals(userUid))).get();

      return result.map((row) => row.modelId).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<int> deleteFromBlock({
    required String modelId,
    required String userUid,
  }) async {
    try {
      var result =
          await (appDatabase.delete(appDatabase.matchAndBlock)..where(
                (t) =>
                    t.modelId.equals(modelId) &
                    t.block.equals(1) &
                    t.userUid.equals(userUid),
              ))
              .go();
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> deleteFromMatch({
    required String modelId,
    required String userUid,
  }) async {
    try {
      var result =
          await (appDatabase.delete(appDatabase.matchAndBlock)..where(
                (t) =>
                    t.modelId.equals(modelId) &
                    t.block.equals(0) &
                    t.userUid.equals(userUid),
              ))
              .go();
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> clear({required String userUid}) async {
    try {
      var result = await (appDatabase.delete(
        appDatabase.matchAndBlock,
      )..where((t) => t.userUid.equals(userUid))).go();
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
