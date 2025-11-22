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

  Future<int> deleteFromBlock({required String userUid}) async {
    try {
      final query = appDatabase.select(appDatabase.matchAndBlock)
        ..where((t) => t.block.equals(1) & t.userUid.equals(userUid))
        ..orderBy([
          (t) => OrderingTerm(expression: t.atCreated, mode: OrderingMode.desc),
        ])
        ..limit(1);

      final record = await query.getSingleOrNull();

      if (record == null) return 0;

      // Удаляем запись по ID
      return await (appDatabase.delete(
        appDatabase.matchAndBlock,
      )..where((t) => t.id.equals(record.id))).go();
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

  Future<int> getSwipeToDay({required String userUid}) async {
    try {
      int lower = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ).millisecondsSinceEpoch;
      int higher = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        23,
        59,
        59,
      ).millisecondsSinceEpoch;

      var result = await (appDatabase.select(
        appDatabase.matchAndBlock,
      )..where((t) => t.atCreated.isBetweenValues(lower, higher))).get();

      return result.length;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> deleteFromBlockAfterWeek({required String userUid}) async {
    try {
      // Удаляем запись после 7 дней
      DateTime dateTime7DaysAgo = DateTime.now().add(Duration(days: -7));

      return await (appDatabase.delete(appDatabase.matchAndBlock)..where(
            (t) =>
                t.block.equals(1) &
                t.userUid.equals(userUid) &
                t.atCreated.isSmallerThanValue(
                  dateTime7DaysAgo.millisecondsSinceEpoch,
                ),
          ))
          .go();
    } catch (e) {
      rethrow;
    }
  }
}
