import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database_manager.g.dart';

class MatchAndBlock extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get atCreated => integer()();
  TextColumn get userUid => text()();
  TextColumn get modelId => text()();
  IntColumn get block => integer()();
}

class Chat extends Table {
  IntColumn get atCreated => integer()();
  TextColumn get userUid => text()();
  TextColumn get modelId => text()();
  TextColumn get modelName => text()();
  TextColumn get modelAvatar => text()();
}

class Messages extends Table {
  IntColumn get atCreated => integer()();
  TextColumn get modelId => text()();
  TextColumn get userUid => text()();
  TextColumn get owner => text()();
  TextColumn get message => text()();
  TextColumn get images => text()();
  BoolColumn get isRead => boolean()();
}

@DriftDatabase(tables: [MatchAndBlock, Chat, Messages])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    // Что делать при создании базы данных
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    // Что делать при обновлении базы данных
    onUpgrade: (Migrator m, int from, int to) async {
      await m.deleteTable(matchAndBlock.actualTableName);
      await m.createTable(matchAndBlock);
      await m.deleteTable(chat.actualTableName);
      await m.createTable(chat);
      await m.deleteTable(messages.actualTableName);
      await m.createTable(messages);
    },
    // Что делать при сбросе базы данных
    beforeOpen: (details) async {
      if (details.wasCreated) {
        log('Database have created');
      } else if (details.hadUpgrade) {
        log(
          'Database have updated from ${details.versionBefore} to ${details.versionNow}!',
        );
      }
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'flinder_database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // feature-web
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
    );
  }
}
